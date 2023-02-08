i=imread("lena2.bmp"); % 영상 읽음

mask1=[-1,0,1;-2,0,2;-1,0,1]; % sobel 에지검출 마스크 x축
mask2=[-1,-2,-1;0,0,0;1,2,1]; % sobel 에지검출 마스크 y축

x=conv2(i,mask1); % 에지 검출을 위한 미분연산
y=conv2(i,mask2);

amp=abs(x)+abs(y); % 에지 강도 계산

[m,n]=size(amp);

for j=1:m % 에지강도 임계값 80으로 경계선 검출
  for k=1:n
    if amp(j,k)>=80
      amp(j,k)=255;
    else
      amp(j,k)=0;
    end
  end
end

amp=uint8(amp);
imshow(amp);
