function [len] = InfoLSB(image, string, key)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
img = imread(image);
ste_img = img;
ste_img = double(ste_img);
[m, n] = size(ste_img);
f = fopen(string);
[info, len] = fread(f, 'ubit1');
fclose(f);
if len > m * n
    error('Ƕ����Ϣ������������ѡ��ͼ��')
end
%p��Ϊ��ϢǶ��λ������
p=1;
[row,col]=randinterval(ste_img,len,key);

for i=1:len
    ste_img(row(i),col(i))=ste_img(row(i),col(i))-mod(ste_img(row(i),col(i)),2) + info(p,1);
    if p==len
        break;
    end
    p=p+1;
end
ste_img=uint8(ste_img);
imwrite(ste_img,'test.bmp');
output = imread('test.bmp');
%��ʾʵ����
subplot(1,2,1);imshow(img);title('ԭʼͼ��');
subplot(1,2,2);imshow(output);title('����ͼ��');
end

