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
