function update_display4(obj, event, hImage)
global net counter
% ÿ5��ͼ��ʶ��һ��
if mod(counter,5)==1 
% ��ʾԭʼͼ��
% set(hImage, 'CData',event.Data);
imgOri = event.Data;

%%��ȡ����
% ɫ��ת��RGB to HSV
imgHSV=rgb2hsv(event.Data);
imgT=imgHSV(:,:,2);
% ������ƽ
imgBG=imgaussfilt(imgT,10);%10 6  5
imgDiff=imgT-imgBG;
% ��ֵ������׶�
imgBW=imbinarize(imgDiff);
imgBWori=imgBW;
imgBW = imclose(imgBW,strel('disk',5));

%% ��ȡǱ����Ч��������ԣ���Χ��������������ص�λ�ã�
EasterEgg=0;
Pred='None';
hNum=regionprops(imgBW,'BoundingBox','Area','PixelList');
Area= cat(1,hNum.Area);
BBox=cat(1,hNum.BoundingBox);
[hmax,hmind]=sort(Area,'descend');
imgBWlabel=uint8(imgBW*255);
for i=1:length(hmax)
    % ���С��200�Ĳ��ֲ���ʶ��
    if  (Area(hmind(i))>200)
        Swidth = max([BBox(hmind(i),3),BBox(hmind(i),4)]);
        Sstart1 =fix( BBox(hmind(i),1))+1;
        Sstart2 = fix(BBox(hmind(i),2) )+1;
        Swidth1 = BBox(hmind(i),3);
        Swidth2 = BBox(hmind(i),4);        
        SimgGray=imgBWori(Sstart2:(Sstart2+Swidth2-1), Sstart1:(Sstart1+Swidth1-1));        
        % ���췽�ε�ͼƬ
            SimgNew = zeros(Swidth,Swidth);
            if Swidth1<Swidth2
            SimgNew(:,fix((Swidth-Swidth1)/2+1): (fix((Swidth-Swidth1)/2+1)+Swidth1-1))=SimgGray;
            else
            SimgNew(fix((Swidth-Swidth2)/2+1): (fix((Swidth-Swidth2)/2+1)+Swidth2-1),:)=SimgGray;
            end
            % ͼƬʶ��
            imgT2=imresize(uint8(SimgNew*255),[28 28]);
            Pred = classify(net, imgT2);
            % ͼ���м����ע����10��Ϊ�ʵ����ֱ�ǣ�
            if Pred~=categorical(cellstr('10'))
            imgBWlabel = insertObjectAnnotation(imgBWlabel, 'rectangle', BBox(hmind(i),:), char(Pred),'FontSize',16);
            imgOri = insertObjectAnnotation(imgOri, 'rectangle', BBox(hmind(i),:), char(Pred),'FontSize',16);
            else
            imgBWlabel = insertObjectAnnotation(imgBWlabel, 'rectangle', BBox(hmind(i),:), 'Fu','FontSize',16,'color','r');
            imgOri = insertObjectAnnotation(imgOri, 'rectangle', BBox(hmind(i),:), 'Fu','FontSize',16,'color','r');
            EasterEgg=1;
            end       
    end% end of
end
% ����ͼƬ��ʾ
set(hImage, 'CData',imgOri);
% �ʵ������ж�
if EasterEgg==1
    xlabel('���ף����´����֣�����������','Color','r','FontSize',16)
else
    xlabel('')
end

end% End of if Mod

counter=counter+1;
drawnow



