i=imread("lena2.bmp"); % 영상 읽음
j= imnoise(i,'salt & pepper'); % 임의의 잡음 추가
j=medfilt2(i); % 메디안 필터 적용
imshow(j);
% mdefil2 함수를 사용하기 위해 pkg load image 명령어를 입력하고 실행해야 함.