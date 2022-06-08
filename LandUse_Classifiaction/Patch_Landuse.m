
Clear all;close all;clc;

% Generation of Patches of study resgion

StudyArea= imread('\.extensionformate');

figure, imshow(StudyArea);
imSize = size(StudyArea);

patchSize = [6 6];   % Adusted of patches with samples size
xIdxs = [1:patchSize(2):imSize(2) imSize(2)+1];
yIdxs = [1:patchSize(1):imSize(1) imSize(1)+1];
patches = cell(length(yIdxs)-1,length(xIdxs)-1);
cnt=0;
for i = 1:length(yIdxs)-1
    Isub = StudyArea(yIdxs(i):yIdxs(i+1)-1,:,:);
    for j = 1:length(xIdxs)-1
        II = Isub(:,xIdxs(j):xIdxs(j+1)-1,:);
        cnt=cnt+1;
        imwrite(newfolder,['Specided location folder' num2str(cnt) '.extensionformate']);
        i
        j
    end
end

display(patches);

