function [I2]=dctcompress(I,ratio)
%% get DCT matrix
A = zeros(8);   
for i = 0:7
    for j = 0:7
        if i == 0
            a = sqrt(1/8);
        else
            a = sqrt(2/8);
        end
        A(i+1,j+1) = a*cos((2*j+1)*pi*i/16);
    end
end 
%% show DCT basis
B=zeros(8,8,8,8);
for i=1:8
    for j=1:8
            B(:,:,i,j)=A(j,:)'*A(i,:);
    end
end
for i=1:8
    for j=1:8
        subplot(8,8,(i-1)*8+j)
        imshow(B(:,:,i,j),[]);
    end
end
%% get 64 coordinates
x=[];
y=[];
for i=1:8
    if rem(i,2)==0
        x=[x,1:i];
        y=[y,i:-1:1];
    end
    if rem(i,2)~=0
        y=[y,1:i];
        x=[x,i:-1:1];
    end
end
for i=2:8
    if rem(i,2)==0
        x=[x,8:-1:i];
        y=[y,i:8];
    end
    if rem(i,2)~=0
        x=[x,i:8];
        y=[y,8:-1:i];
    end
end
%% DCT transform
dct = @(block_struct) A * block_struct.data * A';
D = blockproc(I,[8 8],dct);
%% compress
mask=ones(8,8);
for i=ceil(ratio*64)+1:64
    mask(x(i),y(i))=0;
end
D2 = blockproc(D,[8 8],@(block_struct) mask .* block_struct.data);
%% inverse DCT
invdct = @(block_struct) A' * block_struct.data * A;
I2 = blockproc(D2,[8 8],invdct);
end