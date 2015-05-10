function [fungsiPrepare, fungsiClassify , H , newMap] ... 
                = initSvm(width, height , dirTrainData )
            
fileList = getAllFiles(dirTrainData);
n = size(fileList , 1 ); 

% pertama identifikasi semua jenis pohon dan map nilainya untuk di training
map = java.util.HashMap; 
index = int8(1); 
for i=1:n
    name = fileList{i}; 
    name = getNamaTanaman(name); 
    d = map.get(name); 
    if isempty(d)
       map.put(name , index ); 
       index = index + 1;
    end
end

newMap = java.util.HashMap; 

% mulai pembentukan struct bagi klasifikasi dengan SVM
w = width ; 
h = height; 
A = zeros(n, w * h);
B = zeros(n,1); 

for i=1:n
    temp = imread(fileList{i}); 
    A(i,:) = prepareImage(temp, w , h ) ;
    nama = getNamaTanaman(fileList{i}); 
    s = map.get(nama); 
    B(i) = s; 
end

iterator = map.entrySet.iterator; 
while iterator.hasNext
    key = iterator.next.getKey;
    val = map.get(key);
    newMap.put(val , key); 
end

xxx = int8(-100); 
newMap.put(xxx, 'tidak ditemukan'); 

H  = multiClassSvm(A, B);
fungsiPrepare = @prepareImage; 
fungsiClassify = @classify; 


function result = classify( H , I )
a = length(H); 
match = 0;
for k=1:a
    state = svmclassify(H(k),I); 
    if (state)
        match = 1; 
        break; 
    end
end
if match 
    result = k;
else
    xxx = int8(-100); 
    result = xxx ; 
end


function models =  multiClassSvm(trainData, group)
u=unique(group);
sort(u); 
numClasses=length(u);
for k=1:numClasses,
    GivAll = ( group == u(k) );
    models(k) = svmtrain(trainData , GivAll);
end

function out = prepareImage(I, w , h)
out = im2double(I);
out = rgb2gray(out); 
out = imresize(out, [w h]); 
out = reshape(out', 1 , w * h );


function nama = getNamaTanaman(sname)
nama = regexp(sname, '\\', 'split'); 
nama = nama{end}; 
nama = regexp(nama, '\.' , 'split') ; 
nama = regexprep(nama{1} , '[^a-zA-Z\s]' , ''); 