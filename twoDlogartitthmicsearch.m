img1=imread('frame1.jpg');
img2=imread('frame2.jpg');

figure(1); % 이전 프레임 출력
imshow(img1);

p=15; % 탐색영역
n=16; % 매크로 블록의 한쪽 크기

[m1,n1]=size(img2); % 매크로 블록 크기 n의 정수배로 맞추기 위한 처리 과정이다. 142+2=16*9
imgP1=zeros(m1+2,n1);
for i=1:m1;
  for j=1:n1
    imgP1(i,j)=img1(i,j);
  end 
end

imgP2=zeros(m1+(2*n),n1+(2*n)); % 현재 프레임에서 step 1 과정 수행 시 주변 8 방향 탐색을 위해 Zero-Padding 처리가 필요하다.
for i=1:m1
  for j=1:n1
    imgP2(i+n,j+n)=img2(i,j);
  end 
end

count=1;
for i=n+1:n:n*9+n    % 144=16*9, Padding 과정 후 처리하기 때문에 시작 좌표는 (17,17)
  for j=n+1:n:n*13+n % 208=16*13
    cx0=i;
    cy0=j;
    % Step 1
    [cx1,cy1,p1]=MIN_MAD(imgP1,imgP2,cx0,cy0,p);
    % Step 2
    [cx2,cy2,p2]=MIN_MAD(imgP1,imgP2,cx1,cy1,p1);
    % Step 3
    [cx3,cy3,p3]=MIN_MAD(imgP1,imgP2,cx2,cy2,p2);
    % Step 4
    [cx4,cy4,p4]=MIN_MAD(imgP1,imgP2,cx3,cy3,p3);
    
    motion_vectorx=cx4-cx0; % Motion Vector 계산
    motion_vectory=cy4-cy0;
    printf('Motion Vector for point(%d,%d) of img1=(%d,%d)   count=%d\n',cx0-n,cy0-n,motion_vectorx,motion_vectory,count++);
    if motion_vectorx==0 && motion_vectory==0 % Motion Vector가 존재하는 매크로 블록만을 사용해 움직임 보상 프레임을 만들기 위한 처리이다.
     continue;
    end
    img1(cx4-n:1:cx4-n+15,cy4-n:1:cy4-n+15)=imgP2(cx4:1:cx4+15,cy4:1:cy4+15); % 움직임 보상 프레임 생성
  end
end

imgn1=zeros(m1,n1); % 현재 프레임 - 움직임 보상 프레임을 생성하기 위한 처리이다.
for i=1:m1
  for j=1:n1
    imgn1(i,j)=img1(i,j);
  end
end

imgD=img2-imgn1; % 현재 프레임 - 움직임 보상 프레임

figure(2);
imshow(img2); % 현재 프레임
figure(3);
imshow(img1); % 움직임 보상 프레임(프레임의 크기가 줄어들었기 때문에 수업자료에서처럼 세밀한 움직임을 잡아내는 데에는 어려움이 있는 것으로 보인다.)
figure(4);
imshow(imgD); % 현재 프레임 - 움직임 보상 프레임임(움직임 보상 프레임의 이유와 동일하게 움직임이 많이 포착되지 않는다.)



