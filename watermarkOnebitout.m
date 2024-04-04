img=imread("lena2wm1.bmp");
[m,n]=size(img);
rand("seed",201810892);
wm=randi([0,1],256);

% 추출
for i=1:m
  for j=1:n
    innerp(i,j)=img(i,j)*wm(i,j); % 고유키로 생성된 워터마크와 그것이 삽입된 영상의의 내적을 통해 추출 가능
    if innerp(i,j)>0
      wm_out(i,j)=1;
    else
      wm_out(i,j)=0;
    end
  end
end
corr2(wm,wm_out) % 상관도가 1로 추출 성공

% LPF 공격
lpf=fspecial("gaussian",[3,3],0.5);
a=conv2(lpf,img);
for i=1:m
  for j=1:n
    a_lpf_img(i,j)=a(i+2,j+2);
  end
end
% LPF 공격 후 추출
wm_out_lpf=img.-a_lpf_img; % 워터마크가 삽입된 영상과 LPF를 거친 영상의 차이를 추출한 워터마크라고 보는 방법
corr2(wm_out_lpf,wm) % 상관도가 매우 작음(워터마크가 손상됨)

% JPEG 공격
imwrite(img,"lena2_jpeg.jpg");
jpeg_img=imread("lena2_jpeg.jpg");
% JPEG 공격 후 추출
b=conv2(lpf,jpeg_img);
for i=1:m
  for j=1:n
    b_jpeg_img(i,j)=b(i+2,j+2);
  end
end
wm_out_jpeg=img.-b_jpeg_img; % 워터마크가 삽입된 영상과 LPF를 거친 영상의 차이를 추출한 워터마크라고 보는 방법
corr2(wm_out_jpeg,wm) % 상관도가 매우 작음(워터마크가 손상됨)

figure(1);
imshow([img,a_lpf_img,b_jpeg_img]);
