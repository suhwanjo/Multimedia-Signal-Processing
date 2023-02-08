i=imread("lena.jpg"); % 이미지 읽기
i=uint32(i); % 255이상의 수 표현을 위해 부호가 없는 32비트 정수로 변환
maxi=uint32(max(max(i))); 
mini=uint32(min(min(i)));
T=(maxi+mini)/2 % 초기 경계값

while(1)
Told=T; % 새로운 경계값과 바로 전의 경계값을 비교하기 위함
up=uint32(0); % 합계 저장 배열
low=uint32(0);
up_total=uint32(0); % 인덱스 수 저장 배열
low_total=uint32(0);
up_mean=uint32(0); % 평균 저장 배열
low_mean=uint32(0);
for j=1:256
  for k=1:256
    if(i(j,k)>Told) % 경계값보다 큰 집단
    up(1,1)+=i(j,k); % 합계
    up_total(1,1)+=1; % 카운팅
  else % 경계값보다 작은 집단
    low(1,1)+=i(j,k);
    low_total(1,1)+=1;
    end
  end
end
  up_mean=up/up_total; % 평균 계산
  low_mean=low/low_total;
  T=(up_mean+low_mean)/2 % 새로운 경계값 계산
  if(abs(Told-T)<0.3) % 경계값의 변화가 미리 정의된 오차 0.3보다 작을 시 종료
  break;
end 
end
% 이진화
for j=1:256
  for k=1:256
    if(i(j,k)>=T)
    i(j,k)=255;
  else
    i(j,k)=0;
  end
end
end
i=uint8(i);
imshow(i);