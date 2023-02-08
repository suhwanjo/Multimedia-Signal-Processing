img = imread('lena.jpg'); % 영상 읽기

hist = zeros(256,1); % 히스토그램 배열 선언

for i = 1:256
  for j = 1:256
    hist(img(i, j)+1) = hist(img(i, j)+1) + 1; % 해당 화소의 빈도수를 인덱스에 저장
  end
end
hist = hist/(256*256); % 화소수를 영상 크기로 나눠 전체 확률 계산

P1 = zeros(256,1); % 클래스1 확률 저장 배열 선언

for k = 1:256
    P1(k) = sum(hist(1:k)); % 한 픽셀이 클래스1에 들어갈 확률 계산(클래스1이 발생할 확률) 
end

P2 = 1 - P1; % 클래스2 확률 계산
m = zeros(256,1);
in = [0:1:256]';

for k = 1:256 
    m(k) = sum(in(1:k).*hist(1:k)); % 밝기 레벨 k까지의 평균 밝기 값
end
m_G = m(256); % 전체 이미지의 평균 밝기 값

sigma = ((m_G*P1 - m).^2)./(P1.*P2); % 최적의 임계값을 찾기 위해 클래스 간 분산 계산
[maximum, k_opt] = max(sigma) % 클래스 간 분산을 최대화 하는 값이 임계값

for q = 1:256*256 % 클래스 간 분산의 최대값으로 이진화
  if img(q) <= k_opt
     img(q) = 0;
  else 
     img(q) = 256;
  end
end

imshow(img);