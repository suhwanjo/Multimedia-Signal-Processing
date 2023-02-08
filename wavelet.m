img=imread("lena2.bmp");
[m,n]=size(img);

bufH=zeros(1,n); % 수평 성분 저장 배열
bufP=zeros(m,1); % 수직 성분 저장 배열

lpfx=[0.5 0.5]; % WT LPF (이산 WT는 0,5로 진행, Haar WT는 0.707로 진행하면 됩니다.)
lpfy=lpfx';

hpfx=[-0.5 0.5]; % WT HPF
hpfy=hpfx';

% 수평 LPF,HPF / down sampling
for i=1:m
  for j=1:n
    bufH(1,j)=img(i,j); 
  end
    horiL=conv(bufH,lpfx); % 수평 LPF
    horiH=conv(bufH,hpfx); % 수평 HPF
  for k=2:2:n+1
    L(i,k/2)=horiL(1,k); % 수평 LPF - down sampling
    H(i,k/2)=horiH(1,k); % 수평 HPF - down sampling
  end
end


[m1,n1]=size(L);

% 수평 LPF - 수직 LPF,HPF / down sampling
for i=1:n1
  for j=1:m1
    bufP(j,1)=L(j,i); 
  end
    perpLL=conv(bufP,lpfy); % 수평 LPF - 수직 LPF
    perpLH=conv(bufP,hpfy); % 수평 LPF - 수직 HPF
  for k=2:2:m1+1
    LL(k/2,i)=perpLL(k,1); % 수평 LPF - 수직 LPF - down sampling
    LH(k/2,i)=perpLH(k,1); % 수평 LPF - 수직 HPF - down sampling
  end
end

% 수평 HPF - 수직 LPF,HPF / down sampling
for i=1:n1
  for j=1:m1
    bufP(j,1)=H(j,i); 
  end
    perpHL=conv(bufP,lpfy); % 수평 HPF - 수직 LPF
    perpHH=conv(bufP,hpfy); % 수평 HPF - 수직 HPF
  for k=2:2:m1+1
    HL(k/2,i)=perpHL(k,1); % 수평 HPF - 수직 HPF - down samlping
    HH(k/2,i)=perpHH(k,1); % 수평 HPF - 수직 HPF - down sampling
   end
end

% 4개의 분할 영상을 하나로 종합
wtmat=zeros(m,n);
for i=1:m/2
  for j=1:n/2
    wtmat(i,j)=LL(i,j)/255; % 왼쪽 상단은 수평, 수직 모두 평균 계수를 포함한다. 따라서 원래 영상에 대한 저역통과 필터 적용의 형태다. 한 화면에 영상을 모두 출력하기 위해 LL영역을 255로 나눠 double형태로 변환함.
    wtmat(i+(m/2),j)=LH(i,j); % 좌측 하단은 수평평균의 수직차분을 포함, 원래 영상에서 수평방향 경계를 포함한다.
    wtmat(i,j+(n/2))=HL(i,j); % 우측 상단은 수평차분의 수직평균을 포함, 원래 영상에서 수직방향 경계를 포함한다.
    wtmat(i+(m/2),j+(n/2))=HH(i,j); % 우측 하단은 수평, 수직 모두 차분에 해당한다. 원래 영상에서 대각선 방향 경계를 포함한다.
  end
end

imshow(wtmat);


