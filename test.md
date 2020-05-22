平台：Matlab
算法：LSB算法
流程概述：从input.bmp和string.txt中读取隐藏载体和需要隐藏的信息，利用随机数发生器产生一个与信息二进制形式长度相等长度的随机序列，按照随机序列的顺序将二进制信息嵌入到对应像素
位置的LSB位， 提取时则根据信息长度以及随机数发生器种子，逆序完成该过程，再将排列好的二进制文本以二进制方式写入到result.txt文件中即可.
示例：
input.bmp作为图像载体，string.txt保存了隐藏信息，随机数种子位2134：
InfoLSB('input.bmp', 'string.txt' ,2134) → 生成含有隐藏信息的图片test.bmp

从test.bmp中提取隐藏信息：
rand_lsb_get('test.bmp', 120, 'result.txt', 2134) % 120是隐藏信息的长度
提取信息被保存至result.txt中

附有源码：

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


function result = rand_lsb_get(output,len_total,goalfile,key)
ste_cover=imread(output);
ste_cover=double(ste_cover);
%判断嵌入信息量是否过大
[m,n]=size(ste_cover);
if len_total>m*n
  error('嵌入信息量过大，请重新选择图像');
end
frr=fopen(goalfile,'a');
%p作为消息嵌入位计数器,将消息序列写回文本文件
p=1;
%调用随机间隔函数选取像素点
[row,col]=randinterval(ste_cover,len_total,key);
for i=1 :len_total
    if bitand(ste_cover(row(i),col(i)),1)==1
        fwrite(frr,1,'ubit1');
        result(p,1)=1;
    else
        fwrite(frr,0,'ubit1');
        result(p,1)=0;
    end
    if p ==len_total
        break;
    end
    p=p+1;
end
fclose(frr);
end

