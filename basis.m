
global img2
img = double(img2);%more quickly
cluster_num = 4;%���÷�����
maxiter = 60;%����������
%-------------�����ʼ����ǩ----------------
 label = randi([1,cluster_num],size(img));
%-----------kmeans��Ϊ��ʼ��Ԥ�ָ�----------
% label = kmeans(img(:),cluster_num);
 %label = reshape(label,size(img));
iter = 0;
while iter < maxiter
    %-------�����������---------------
    %�����Ҳ��õ������ص��3*3����ı�ǩ��ͬ
    %�������Ϊ�������
    %------�ռ���������б�Ȱ˸�����ı�ǩ--------
    label_u = imfilter(label,[0,1,0;0,0,0;0,0,0],'replicate');
    label_d = imfilter(label,[0,0,0;0,0,0;0,1,0],'replicate');
    label_l = imfilter(label,[0,0,0;1,0,0;0,0,0],'replicate');
    label_r = imfilter(label,[0,0,0;0,0,1;0,0,0],'replicate');
    label_ul = imfilter(label,[1,0,0;0,0,0;0,0,0],'replicate');
    label_ur = imfilter(label,[0,0,1;0,0,0;0,0,0],'replicate');
    label_dl = imfilter(label,[0,0,0;0,0,0;1,0,0],'replicate');
    label_dr = imfilter(label,[0,0,0;0,0,0;0,0,1],'replicate');
    p_c = zeros(4,size(label,1)*size(label,2));
    %�������ص�8�����ǩ�����ÿһ�����ͬ����
    for i = 1:cluster_num
        label_i = i * ones(size(label));
        temp = ~(label_i - label_u) + ~(label_i - label_d) + ...
            ~(label_i - label_l) + ~(label_i - label_r) + ...
            ~(label_i - label_ul) + ~(label_i - label_ur) + ...
            ~(label_i - label_dl) +~(label_i - label_dr);
        p_c(i,:) = temp(:)/8;%�������
    end
    p_c(find(p_c == 0)) = 0.001;%��ֹ����0
    %---------------������Ȼ����----------------
    mu = zeros(1,4);
    sigma = zeros(1,4);
    %���ÿһ��ĵĸ�˹����--��ֵ����
    for i = 1:cluster_num
        index = find(label == i);%�ҵ�ÿһ��ĵ�
        data_c = img(index);
        mu(i) = mean(data_c);%��ֵ
        sigma(i) = var(data_c);%����
    end
    p_sc = zeros(4,size(label,1)*size(label,2));
%     for i = 1:size(img,1)*size(img,2)
%         for j = 1:cluster_num
%             p_sc(j,i) = 1/sqrt(2*pi*sigma(j))*...
%               exp(-(img(i)-mu(j))^2/2/sigma(j));
%         end
%     end
    %------����ÿ�����ص�����ÿһ�����Ȼ����--------
    %------Ϊ�˼������㣬��ѭ����Ϊ����һ�����--------
    for j = 1:cluster_num
        MU = repmat(mu(j),size(img,1)*size(img,2),1);
        p_sc(j,:) = 1/sqrt(2*pi*sigma(j))*...
            exp(-(img(:)-MU).^2/2/sigma(j));
    end 
    %�ҵ�����һ�����������Ϊ��ǩ��ȡ������ֵֹ̫С
    [~,label] = max(log(p_c) + log(p_sc));
    %�Ĵ�С������ʾ
    label = reshape(label,size(img));
    %---------��ʾ----------------
%     if ~mod(iter,10) 
%         figure;
%         n=1;
%     end
%     subplot(2,5,n);
%     imshow(label,[])
%     title(['iter = ',num2str(iter)]);
%     pause(0.01);
%     n = n+1;
%     iter = iter + 1;
%       figure
%       imshow(label,[]);
%         img2=label;
%      subplot(1,1,1)
%      imshow(label,[])
%        img2=mat2gray(label);
       iter = iter+1;
end
 img2=mat2gray(label);
% img2=label;
% figure,imshow(img2)
