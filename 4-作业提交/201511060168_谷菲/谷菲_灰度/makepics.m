clear all;clc;
% Current Working Path ��õ�ǰ�ļ�����·�����Ȱ����ļ�������ȥ��
CWPath = fileparts(mfilename('fullpath'));
cd(CWPath);
yuan = imread('0.jpg');%��ȡRGB��ʽ��ͼ��

step=0.2;%ͼƬ�Ĳ���ֵ
number=4;%���ɵ�ͼƬ����

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%֮ǰ�ҵ���RGB2gray
%MyFirstGrayPic = rgb2gray(MyYuanLaiPic);%��matlab���еĺ�������RGB���Ҷ�ͼ���ת��
%�����Լ��ķ���
% [rows , cols , colors] = size(MyYuanLaiPic);%�õ�ԭ��ͼ��ľ���Ĳ���
% MidGrayPic = zeros(rows , cols);%�õõ��Ĳ�������һ��ȫ��ľ���������������洢������ķ��������ĻҶ�ͼ��
% MidGrayPic = uint8(MidGrayPic);%��������ȫ�����ת��Ϊuint8��ʽ����Ϊ���������䴴��֮��ͼ����double�͵�
% 
% for i = 1:rows
%     for j = 1:cols
%         sum = 0;
%         for k = 1:colors
%             sum = sum + MyYuanLaiPic(i , j , k) / 3;%����ת���Ĺؼ���ʽ��sumÿ�ζ���Ϊ��������ֶ����ܳ���255
%         end
%         MidGrayPic(i , j) = sum;
%     end
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 h={'/hposition = 25pct','/hposition = 75pct'...
     ,'/hposition = 25pct','/hposition = 75pct'};%ͼƬ��λ��-ˮƽ
 v={'/vposition = 25pct','/vposition = 25pct'...
     ,'/vposition = 75pct','/vposition = 75pct'};%ͼƬ��λ��-��ֱ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����picture��д<picture>
p=cell(number,4);%������ͼƬ<picture >�������ں����trial
for i=1:number%(1/step)
    pic=yuan*(step*i+step*floor(((1/step)-number)/2));%ȡ�м䲿�ֵ�
    picname=sprintf('pic_%02d.jpg',i);
    imwrite(pic,picname,'jpg');%����ͼƬ
    for j=1:4
        f=fopen('items.txt','a+');
    fprintf(f,'<picture %02d%d>\r\n    /items = ("%s")\r\n    /size = (300,300)\r\n    %s\r\n    %s\r\n',i,j,picname,h{j},v{j});
    fprintf(f,'</picture>\r\n');
        fclose(f);%д<picture>����
        p{i,j}=sprintf('%02d%d',i,j);%��¼picture����
    end    
   %fprintf(f,'    /%d = ("%s")\r\n',i,picname);%��item�����txt�ļ�
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%дtrial
f=fopen('items.txt','a+');
con=0;
for i=1:number%������ǻҶȲ�һ����ͼƬ
    
    ku=1:number;%����������
    ku(i)=[];%ȥ���ҶȲ�һ������һ��
    for j=1:number-1
        con=con+1;
        weizhi=randperm(4);wei=weizhi(1);%���ֵ�λ��
        unique=p{i,wei};%s���һ������ͼƬ��λ�ã�ʣ����ͬ��ͼƬλ��Ҳ�Ͷ���
     fprintf(f,'<trial %d>\r\n',con);
fprintf(f,'    /correctmessage = (correctmsg,500)\r\n');
fprintf(f,'    /errormessage = (errormsg,500)\r\n');
fprintf(f,'	   /pretrialpause = 500\r\n');
fprintf(f,'	   /inputdevice = mouse\r\n');
fprintf(f,'	   /correctresponse = (%s)\r\n',unique);
fprintf(f,'    /validresponse = (%s, %s, %s, %s)\r\n',unique,p{ku(j),weizhi(2)},p{ku(j),weizhi(3)},p{ku(j),weizhi(4)});
fprintf(f,'	   /ontrialbegin = [values.fixationtime = expressions.generaterandomfixation]\r\n');
fprintf(f,'	   /ontrialbegin = [values.shapetime = values.fixationtime + expressions.generaterandomshape]\r\n');
%fprintf(f,'	   /ontrialbegin = [values.stimulustimep = values.shapetime + 300]\r\n');
fprintf(f,'	   /ontrialbegin = [trial.%d.insertstimulustime(text.fixation, 0)]\r\n',con);
fprintf(f,'	   /ontrialbegin = [trial.%d.insertstimulustime(shape.blank,values.fixationtime)]\r\n',con);
fprintf(f,'	   /ontrialbegin = [trial.%d.insertstimulustime(picture.%s,values.shapetime)]\r\n',con,unique);
fprintf(f,'	   /ontrialbegin = [trial.%d.insertstimulustime(picture.%s,values.shapetime)]\r\n',con,p{ku(j),weizhi(2)});
fprintf(f,'	   /ontrialbegin = [trial.%d.insertstimulustime(picture.%s,values.shapetime)]\r\n',con,p{ku(j),weizhi(3)});
fprintf(f,'	   /ontrialbegin = [trial.%d.insertstimulustime(picture.%s,values.shapetime)]\r\n',con,p{ku(j),weizhi(4)});
%fprintf(f,'	   /ontrialbegin = [trial.%d.insertstimulustime(shape.blank,values.stimulustimep)]\r\n',con);
fprintf(f,'	   /ontrialend = [trial.%d.clearstimulusframes()]\r\n',con);
fprintf(f,'	   /beginresponsetime = values.shapetime\r\n');
fprintf(f,'</trial>\r\n');
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%дblock
shunxu=randperm(number*(number-1));%trial˳�����

fprintf(f,'<block exerciseblk1>\r\n');
fprintf(f,'     /screencolor = (0,0,0)\r\n');
fprintf(f,'	    /blockfeedback = (meanlatency,correct)\r\n');
fprintf(f,'	    /trials = [');
for i=1:number*(number-1)/2-1
    fprintf(f,'%d=%d;',i,shunxu(i));
end
i=i+1;
fprintf(f,'%d=%d]\r\n',i,shunxu(i));
fprintf(f,'</block>\r\n');
%����blockƽ��trial����Ϊtrial����ż����
fprintf(f,'<block exerciseblk2>\r\n');
fprintf(f,'     /screencolor = (0,0,0)\r\n');
fprintf(f,'	    /blockfeedback = (meanlatency,correct)\r\n');
fprintf(f,'	    /trials = [');
for i=1+number*(number-1)/2:number*(number-1)-1
    fprintf(f,'%d=%d;',i-number*(number-1)/2,shunxu(i));
end
i=i+1;
fprintf(f,'%d=%d]\r\n',i/2,shunxu(i));
fprintf(f,'</block>\r\n');
fclose(f);