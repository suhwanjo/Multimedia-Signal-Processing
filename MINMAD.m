function [ncx,ncy,pn]=MIN_MAD(img01,img02,cx,cy,p0) 
% img01,02를 입력으로 받아 cx,cy좌표를 중심으로 하고, 자기 자신과 p0/2만큼 일정하게 떨어져 있는 9개 매크로 블록의 MAD의 최소값을 구한다.
% MAD가 최소일 때의 좌표를 새로운 탐색영역의 중심으로 설정하고 새로운 좌표와 반으로 감소된 탐색영역을 반환한다.  

pn=round(p0/2); % 감소하는 탐색 영역. 함수를 호출할 때마다 1/2씩 감소한다.
n=16;           % 매크로 블록 한쪽의 크기

for i=1:n % MAD를 계산해 각각 다른 변수에 저장하기 위한 루프
  for j=1:n
    MAD1(i,j)=abs(img01(cx-n+i-1,cy-n+j-1)-img02(cx-pn+i-1,cy-pn+j-1)); % 좌측 상단
    MAD2(i,j)=abs(img01(cx-n+i-1,cy-n+j-1)-img02(cx-pn+i-1,cy+j-1));    % 상단
    MAD3(i,j)=abs(img01(cx-n+i-1,cy-n+j-1)-img02(cx-pn+i-1,cy+pn+j-1)); % 우측 상단
    MAD4(i,j)=abs(img01(cx-n+i-1,cy-n+j-1)-img02(cx+i-1,cy-pn+j-1));    % 좌측 
    MAD5(i,j)=abs(img01(cx-n+i-1,cy-n+j-1)-img02(cx+i-1,cy+j-1));       % 중앙
    MAD6(i,j)=abs(img01(cx-n+i-1,cy-n+j-1)-img02(cx+i-1,cy+pn+j-1));    % 우측
    MAD7(i,j)=abs(img01(cx-n+i-1,cy-n+j-1)-img02(cx+pn+i-1,cy-pn+j-1)); % 좌측 하단
    MAD8(i,j)=abs(img01(cx-n+i-1,cy-n+j-1)-img02(cx+pn+i-1,cy+j-1));    % 하단
    MAD9(i,j)=abs(img01(cx-n+i-1,cy-n+j-1)-img02(cx+pn+i-1,cy+pn+j-1)); % 우측 하단
  end
end

mad_buf1=zeros(1,9); % MAD의 최소값을 찾기 위한 변수
mad_buf(1,1)=sum(sum(MAD1)); % 매크로 블록의 화소 값을 모두 더한다.
mad_buf(1,2)=sum(sum(MAD2));
mad_buf(1,3)=sum(sum(MAD3));
mad_buf(1,4)=sum(sum(MAD4));
mad_buf(1,5)=sum(sum(MAD5));
mad_buf(1,6)=sum(sum(MAD6));
mad_buf(1,7)=sum(sum(MAD7));
mad_buf(1,8)=sum(sum(MAD8));
mad_buf(1,9)=sum(sum(MAD9));
mad_buf./(n*n); % 매크로 블록의 크기로 나눠준다.

[step_mad_value,step_MAD_index]=min(mad_buf); % MAD가 최소일 때의 value와 index를 저장한다.


if step_MAD_index==1 % MAD가 최소인 index, 즉 방향에 따라 탐색영역의 중심이 변한다.
  ncx=cx-pn;
  ncy=cy-pn;    
 endif
if step_MAD_index==2
  ncx=cx-pn;
  ncy=cy;    
endif
if step_MAD_index==3
  ncx=cx-pn;
  ncy=cy+pn;    
endif
if step_MAD_index==4
  ncx=cx;
  ncy=cy-pn;    
endif
if step_MAD_index==5
  ncx=cx;
  ncy=cy;    
endif
if step_MAD_index==6
  ncx=cx;
  ncy=cy+pn;    
endif
if step_MAD_index==7
  ncx=cx+pn;
  ncy=cy-pn;    
endif
if step_MAD_index==8
  ncx=cx+pn;
  ncy=cy;    
endif
if step_MAD_index==9
  ncx=cx+pn;
  ncy=cy+pn;    
 endif
endfunction