
% %  function main
%  filename='D:\1-02.dcm'; % dcm文件路径+文件名
imgTest01=img2;
% 以默认窗显示图像
% 先设定FCM的几个初始参数
options=[2;	500;1e-6];	% 目标函数的最小误差		
class_num= 2;  % 分为2类

%[imgTest01,map]=dicomread(filename);
%if ~isempty(map)
%    imgTest01 = ind2rgb(imgTest01,map);
%end

class_num= 2;
%subplot(1,2,1),imshow(imgTest01,[]),title('原图');


I = im2double(imgTest01); 
x = size(imgTest01,1);
y = size(imgTest01,2);
I2 = reshape(I,x*y,1);

alpha = 2;			% 参数m
max_it= 10000;		% 最终的迭代次数
min_de = 1e-8;
obj = 0;

% 生成隶属度矩阵U
u = rand(class_num, x*y); % 随机生成隶属度矩阵U
col_sum = sum(u);
col = col_sum(ones(class_num, 1), :);
u = u./col;

for i = 1:max_it
    
    ud = u;
    nf = ud;       %Uik
    mf = ud.^alpha; 
    
    data = zeros(class_num,x*y);
        for j=1:class_num
        data(j,:) = I2';
        end
        
    center = sum(nf.*data,2)./sum(nf,2); %c cc个聚类中心
    dist = zeros(class_num, x*y);
    for k = 1:class_num
        dist(k, :) = sqrt(sum(((I2-ones(x*y, 1)*center(k, :)).^2)', 1));
    end
    tmp = sum(sum((dist.^2).*mf));
    t = dist.^(-2/(alpha-1));      % 如果迭代次数不为1,计算新的隶属度矩阵
    newu = t./(ones(class_num, 1)*sum(t));
    
  %  fprintf('第%d次迭代, 目标函数值为%f\n', i, tmp);
    if(abs(tmp - obj) < min_de)
        fprintf('第%d次迭代已经收敛', i);
        break;
    else
        obj = tmp;
        u = newu;
    end
end


max1 = max(u); % 找出每一列的最大隶属度
temp = sort(center); 
for i = 1:class_num % 按聚类结果分割图像
   
    eval(['class_',int2str(i), '= find(u(', int2str(i), ',:) == max1);']); 
    
        index = find(temp == center(i)); 
        
    if (index == 1)
        gray = 0; 
    elseif (index == class_num)
        gray = 255;
    else 
        gray = fix(255*(index-1)/(class_num-1)); 
  %  switch index 
  %      case 1 
  %          gray = 0; 
  %      case class_num 
  %          gray = 255; 
  %      otherwise 
  %          gray = fix(255*(index-1)/(class_num-1)); 
    end 
    eval(['I(class_',int2str(i), '(:))=', int2str(gray),';']); 
end
img = mat2gray(I);
img2=img;