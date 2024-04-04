img=imread("lena2.bmp");
img=imresize(img,[256 256]);
[m,n]=size(img);

% 워터마크 생성
rand("seed",201810892);
wm=uint8(randi([0,1],256));

% 삽입
img=bitand(img,254);
wmimg=bitor(img,wm);
figure(1);
imshow(wmimg);


% 추출
wm2=bitand(wmimg,1);
cor2=corr2(wm,wm2) % 상관도가 1로 추출 성공

% LPF공격
lpf=fspecial("gaussian",[3,3],0.5);
a=uint8(conv2(lpf,wmimg));
for i=1:m
  for j=1:n
    a_lpf_img(i,j)=a(i+2,j+2);
  end
end
figure(2);
imshow(a_lpf_img);
% LPF공격 후 추출
wm3=bitand(a_lpf_img,1);
cor3=corr2(wm,wm3) % 상관도가 매우 작음(워터마크가 손상됨)

% JPEG공격
imwrite(wmimg,"lena2_lsb.jpg");
a_jpeg_img=imread("lena2_lsb.jpg");
figure(3);
imshow(a_jpeg_img);
% JPEG공격 후 추출
wm4=bitand(a_jpeg_img,1);
cor4=corr2(wm,wm4) % 상관도가 매우 작음(워터마크가 손상됨)
