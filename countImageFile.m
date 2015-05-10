function cnt = countImageFile(dirTrainData)
cnt = 0; 
listFile = getAllFiles(dirTrainData); 
for i=1:size(listFile,1) 
    nama = listFile{i}; 
    nama = regexp(nama, '\.' , 'split'); 
    if size(nama,2)== 2
        nama = nama{2}; 
        m = strcmpi(nama, 'jpg');
        if m
            cnt = cnt + 1;
        end
    end
end