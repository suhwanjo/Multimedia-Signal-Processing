i=imread("lena2.bmp"); % 영상 읽음

gf=fspecial("gaussian",3,0.5); % 3x3 사이즈의 표준편차가 0.5인 가우시안 마스크 생성
logf=[0,1,0;1,-4,1;0,1,0]; % 2차 미분인 라플라시안 연산을 구현한 라플라시안 마스크 생성
blured=conv2(i,gf); % log는 잡음에 민감하기 때문에 가우시안 마스크를 통한 블러 처리
log=conv2(blured,logf); % 그 후 라플라시안 마스크를 블러된 영상에 적용시키는 log 

log1=zeros(518,518); % zero crossing 계산을 위한 새로운 배열 생성
[m,n]=size(log1);

for j=1:516 % 경계선 계산을 위한 zero padding 
  for k=1:516
    log1(j+1,k+1)=log(j,k);
  end
end

t=5; % 임계값 설정
edgelist=zeros(1,1); 

for j=2:517 
  for k=2:517
    sum=0;
    
    if log1(j-1,k-1)*log1(j+1,k+1)<0 % 좌측 45도 방향에서 부호가 바뀌는지 확인
      edgelist(j,k)=abs(log1(j-1,k-1))+abs(log1(j+1,k+1)); % 바뀐다면 그 차이가 임계값보다 큰지 확인
      if edgelist(j,k)>=t
      sum+=1; % 크다면 카운팅
    end  
  end
    
    if log1(j+1,k-1)*log1(j-1,k+1)<0 % 우측 45도 방향에서 부호가 바뀌는지 확인
      edgelist(j,k)=abs(log1(j-1,k-1))+abs(log1(j-1,k+1));
      if edgelist(j,k)>=t
      sum+=1;  
    end
  end
  
    if log1(j,k-1)*log1(j,k+1)<0 % 세로 방향에서 부호가 바뀌는지 확인
      edgelist(j,k)=abs(log1(j,k-1))+abs(log1(j,k+1));
      if edgelist(j,k)>=t
      sum+=1;  
    end
  end
  
    if log1(j-1,k)*log1(j+1,k)<0 % 가로 방향에서 부호가 바뀌는지 확인
      edgelist(j,k)=abs(log1(j-1,k))+abs(log1(j+1,k));
      if edgelist(j,k)>=t
      sum+=1;
    end
  end
 
 if sum>=2 % 부호가 바뀌는 쌍과 그 차이가 임계값보다 큰 경우가 2쌍 이상이면 에지 처리
      log1(j,k)=255;
    end

end
end

for j=1:516 % zero padding 된 영상을 복구
  for k=1:516
    log(j,k)=log1(j+1,k+1);
  end
end


log=uint8(log);
imshow(log);
