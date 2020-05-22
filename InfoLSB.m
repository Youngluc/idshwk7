function [len] = InfoLSB(image, string, key)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
img = imread(image);
ste_img = img;
ste_img = double(ste_img);
[m, n] = size(ste_img);
f = fopen(string);
[info, len] = fread(f, 'ubit1');
fclose(f);
if len > m * n
    error('嵌入信息量过大，请重新选择图像')
end
%p作为消息嵌入位计数器
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
%显示实验结果
subplot(1,2,1);imshow(img);title('原始图像');
subplot(1,2,2);imshow(output);title('隐藏图像');
end

