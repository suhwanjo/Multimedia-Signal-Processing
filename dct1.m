img=imread("lena2.bmp");
[m,n]=size(img);

buf1=zeros(8,8); % 영상을 8x8단위로 임시 저장하기 위한 matrix 선언
buf2=zeros(8,8);
dct1=zeros(8,8); % DCT-Quantization을 위한 배열
d1=zeros(8,8);
dct3=zeros(8,8); % 역DCT-Quantization을 위한 배열
d2=zeros(8,8);
dct_a=zeros(512,512); % 8x8을 512x512로 모으기 위한 배열
dct_b=zeros(512,512);

k=0.01; % k값에 따라 압축 정도가 달라짐

qtable=[10 10 15 20 25 30 35 40; % 양자화 table은 수업자료에 명시되어 있는 수치 사용
        10 15 20 25 30 35 40 50;
        15 20 25 30 35 40 50 60;
        20 25 30 35 40 50 60 70;
        25 30 35 40 50 60 70 80; 
        30 35 40 50 60 70 80 90;
        35 40 50 60 70 80 90 100;
        40 50 60 70 80 90 100 100]*k; 
        
% DCT-Quantization 과정
for i=1:8:m 
  for j=1:8:n
 
for k=i:i+7
 for p=j:j+7
  buf1(k-(i-1),p-(j-1))=img(k,p); % 원본영상을 8x8단위로 버퍼에 저장
end
end

d1=dct2(buf1); % DCT 진행
dct1=round(d1./qtable); % 영상의 화소값을 양자화 table값으로 나눠 반올림하면 Quantization 완료

for k=i:i+7
 for p=j:j+7
  dct_a(k,p)=dct1(k-(i-1),p-(j-1)); % 8x8 단위의 DCT-Quantization이 완료된 영상을 모아 원본영상의 크기인 512x512로 만드는 과정
end
end

end
end

% 역DCT-Quantization 과정
for i=1:8:m
  for j=1:8:n
 
for k=i:i+7
 for p=j:j+7
  buf2(k-(i-1),p-(j-1))=dct_a(k,p); % 원본영상을 8x8단위로 버퍼에 저장
end
end

dct3=round(buf2.*qtable); % DCT-Quantization 완료된 8x8영상의 화소값을 양자화 table값으로 곱해 반올림하면 역Quantization 완료
d2=idct2(dct3); % 역DCT 진행

for k=i:i+7
 for p=j:j+7
  dct_b(k,p)=d2(k-(i-1),p-(j-1)); % 8x8 단위의 역DCT-Quantization이 완료된 영상을 모아 원본영상의 크기인 512x512로 만드는 과정
end
end

end
end

dct_b=uint8(dct_b);
figure(1);
imshow(img);
figure(2);
imshow(dct_b);
% dct2,idct2 함수 사용을 위해 실행 전 pkg load signal,communications라는 명령어를 입력해야 함
