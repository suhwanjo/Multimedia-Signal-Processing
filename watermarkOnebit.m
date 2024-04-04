img=imread("lena2.bmp");
img=imresize(img,[256 256]);
[m,n]=size(img);
% 워터마크 생성
rand("seed",201810892);
wm=randi([0,1],256);

% 가중치
a=0.5;
wm=a.*wm;

% 삽입
imgwm=img.+wm;
imshow([img,imgwm]);
imwrite(imgwm,"lena2wm1.bmp");



