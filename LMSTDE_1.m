% ����LMS������Ӧʱ�ӹ���

close all; clear all; clc
L=5;           %ȡ5���ź�����;L=6,7,8,9,10
fs=1000;       %����Ƶ��
t=(0:fs)/fs;   %����ʱ����
s1=sin(2*pi*L*t); %�����ź� 
m=length(t);  %m=1001

N=50;
delta=0.001;
J=10;
if J<0
    d=[zeros(1,-J) s1]; 
    x=[s1 zeros(1,-J)];
else
    x=[zeros(1,J) s1];
    d=[s1 zeros(1,J)];
end
M=length(x); 
t1=(0:M-1)/fs;
y=zeros(1,M); %�����ʼ��
e=zeros(1,M);
h=zeros(1,2*N+1); 
for n=N:M-N-1
    x1=x(n-N+1:n+N+1);
    y(n)=h*x1';                   %����nʱ�̵����
    e(n)=d(n)-y(n);               %����nʱ�̵����
    h=h+delta*e(n)*x1;            %�����˲�����ϵ��
    hh(n,:)=h;
end
figure(1)
subplot(311);
plot(t1,d,'r',t1,x,'b');
legend('�ο��ź�','�����ź�'); grid;
title('s�źž���һ����ʱ����ź�');
subplot(312);
plot(t1,d,'r',t1,y,'b'); 
legend('�ο��ź�','����ź�'); grid;
title('������Ӧ�˲����������ź�');
subplot(313);
plot(t1,e); grid;
title('����ź�');

for k=N : M-N-1
    h=hh(k,:);
    [hmax,hloc]=max(h);
    Hmax(k)=hmax; Hloc(k)=hloc;
end
HL=length(Hmax);

[HHM,HHL]=max(Hmax);
figure(2);
plot(hh(HHL,:));
delay=(Hloc(HHL)-N-1);  %�ӳٵ�������
delaytime=delay/fs;     %������ӳٵ�ʱ��
fprintf('�ӳ�������=%4d   �ӳ�ʱ��=%5.6f(��)\n',delay,delaytime);
