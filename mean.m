i=imread("lena2.bmp"); % 영상 읽기
i=double(i);
f=zeros(3,3); % 3x3 평균 필터 생성
for j=1:3
  for k=1:3
    filter(j,k)=(1/9); % (1+1+1+1+1+1+1+1+1)/9 평균 산출
    end
  end
  blured=uint8(conv2(i,filter)); % 영상과 평균필터를 컨볼루션
  
  imshow(blured);
