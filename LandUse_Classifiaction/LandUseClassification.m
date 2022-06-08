%% Land Use Classification

%% Background subtraction

StudyBackSub=im2bw(StudyArea,0.99);
Se = strel('line',50,90);

StudyBackSub=imerode(StudyBackSub,Se);
StudyBackSub=imerode(StudyBackSub,Se);
figure, imshow(StudyBackSub);

bgpatch = zeros(length(yIdxs)-1,length(xIdxs)-1);
for i = 1:length(yIdxs)-1
    Isub = StudyBackSub(yIdxs(i):yIdxs(i+1)-1,:);
    for j = 1:length(xIdxs1)-1
        Isub1 = Isub(:,xIdxs(j):xIdxs(j+1)-1);
        bgpatch(i,j)=round(sum(sum(Isub1))/100);
    end
end

figure, imshow(bgpatch);

% Proposed model applied on study area



cnt=0;
for i = 1:length(yIdxs)-1
     for j = 1:length(xIdxs)-1
         cnt=cnt+1
         filename=['folder of study patches ' num2str(cnt) '.extensionformate'];
         PatchesDataset = imageDatastore(filename);
         PreLabel(cnt) = classify(net,PatchesDataset);
           i
           j
     end
end



%%



%save predictedLabels predictedLabels

PreLabels=grp2idx(PreLabel);


cnt=0;
for i = 1:length(yIdxs)-1
     for j = 1:length(xIdxs)-1
         cnt=cnt+1
         
         PreLabelsImage(i,j) = PreLabels(cnt);
     end
end
figure,imagesc(PreLabelsImage)
%% LULC classfication feature map

bgpatch=imresize(StudyBackSub,[-,-]);  % size of study area 
bgpatch=imcomplement(bgpatch);

se = strel('disk',7);  % put 0 to 10 as per adjusment

bgpatch=imerode(bgpatch,se);

PreLabels=PreLabelsImage.*bgpatch;
figure,imagesc(PreLabels)
bar(PreLabels)

class(:,:,1)=PreLabels;
class(:,:,2)=PreLabels;
class(:,:,3)=PreLabels;

[row,col]= find(PreLabels(:,:)==0); % background 
for i=1:length(row)
class(row(i),col(i),1)=255;
class(row(i),col(i),2)=255;
class(row(i),col(i),3)=255;
end

[row,col]= find(PreLabels(:,:)==4); % class of vegetation
for i=1:length(row)
class(row(i),col(i),1)=0;
class(row(i),col(i),2)=204;
class(row(i),col(i),3)=0;
end

[row,col]= find(PreLabels(:,:)==2);  %% Class of builtup area
for i=1:length(row)
class(row(i),col(i),1)=255;
class(row(i),col(i),2)=0;
class(row(i),col(i),3)=0;
end


[row,col]= find(PreLabels(:,:)==3); % class of coal mining region
for i=1:length(row)
class(row(i),col(i),1)=0;
class(row(i),col(i),2)=0;
class(row(i),col(i),3)=0;
end

[row,col]= find(PreLabels(:,:)==1);%% class of barren land
for i=1:length(row)
class(row(i),col(i),1)=204;
class(row(i),col(i),2)=204;
class(row(i),col(i),3)=0;
end

[row,col]= find(PreLabels(:,:)==5); % class of waterbody
for i=1:length(row)
class(row(i),col(i),1)=0;
class(row(i),col(i),2)=204;
class(row(i),col(i),3)=204;
end

figure,imagesc(class)

figure,imshow(uint8(class))
title('land Use map ');

y=hist(PreLabels(:),5);
su=sum(y)
y=y*100/su

bar(y)


