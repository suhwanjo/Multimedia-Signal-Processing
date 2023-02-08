i=imread("lena2.bmp"); % 영상 읽음
i=double(i); % 컨볼루션을 위해 double로 형 변환
x=fspecial("gaussian",[5,5],6); % fspecial 함수는 filter를 생성해줌. 첫 번째 인수부터 각각 filter의 이름, filter의 size, gamma의 크기이다.
blured=uint8(conv2(i,x)); % 영상과 가우시안 필터를 convolution
imshow(blured);

% fspecial 함수를 사용하기 위해 pkg load image 명령어를 입력하고 실행해야 함 