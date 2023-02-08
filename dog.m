i=imread("lena2.bmp"); % 영상 읽음

gf=fspecial("gaussian",3,0.5);  % 3x3 사이즈의 표준편차가 0.5인 가우시안 마스크 생성

maskx=[-1,0,1;-2,0,2;-1,0,1]; % 미분연산을 위한 sobel 마스크 x축
masky=[-1,-2,-1;0,0,0;1,2,1]; % 미분연산을 위한 sobel 마스크 y축

gx=conv2(gf,maskx); % 가우시안 마스크를 미분 연산
gy=conv2(gf,masky);

dogx=conv2(gx,i); % 미분된 가우시안 필터를 영상에 적용
dogy=conv2(gy,i);

dog=abs(dogx)+abs(dogy); % 엣지 강도 계산

[m,n]=size(dog);

for j=1:m % 임계강도 80으로 이진화 후 경계선 확인
  for k=1:n
    if dog(j,k)>=80
      dog(j,k)=255;
    else
      dog(j,k)=0;
    end
  end
end

dog=uint8(dog);
imshow(dog);

