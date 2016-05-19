clc %초기화 (전 계수는 20°C 기준
rho = 1.204; %공기밀도
mu = 1.82e-05; %점성계수
De = 0.04; %입구의 직경 (m)
Dt = 0.018; %throttle 직경 (m)
beta = Dt/De; %직경비
Ae = (pi * De^2)/4; %입구의 너비
At = (pi * Dt^2)/4; %throttle 너비

%벤츄리 실험
Vcd = 0.9858 - 0.196*(beta).^(4.5); %유출계수
Vp900 = 998.2*9.81*0.095; %압력차 (오차보정 -3cm)
Vp1300 = 998.2*9.81*0.24;
Vv900 = (2*Vp900/(rho*(1-(beta^4)))).^(1/2); %유속
Vv1300 = (2*Vp1300/(rho*(1-(beta^4)))).^(1/2);
Vq900 = Vcd * At * Vv900; %유량
Vq1300 = Vcd * At * Vv1300;

fprintf('@@@@@ Venturi Tube @@@@@\n\n');
fprintf('유출계수 : %f\n',Vcd);
fprintf('\n# 900RPM #\n\n');
fprintf('압력차 : %f Pa\n',Vp900);
fprintf('유속 : %f m/s\n',Vv900);
fprintf('유량 : %f m^3/s\n',Vq900);
fprintf('\n# 1300RPM #\n\n');
fprintf('압력차 : %f Pa\n',Vp1300);
fprintf('유속 : %f m/s\n',Vv1300);
fprintf('유량 : %f m^3/s\n',Vq1300);

%유동노즐 실험
%900RPM
Re900 = 40000; % 초기 레이놀즈수 가정
FvR900 = (mu*Re900)/(rho*De); % 초기값
Fcd900 = 0.9965 - 6.53*(beta/Re900)^(1/2); %유출계수
Fp900 = 998.2*9.81*0.125; %압력차 (오차보정 -3cm)
Fq900 = Fcd900*At*(2*Fp900/rho*(1-(beta^4)))^(1/2); %유량
Fv900 = Fq900/Ae; %유속
Re900 = (rho*Fv900*De)/mu; %레이놀즈수

err900 = abs(Fv900 - FvR900); %오차

count900 = 0;

while (err900 >= 0.00001) %반복문 (오차가 0.00001 미만이 될때까지)
    count900 = count900 + 1;
    FvR900 = (mu*Re900)/(rho*De);
    Fcd900 = 0.9965 - 6.53*(beta/Re900)^(1/2);
    Fq900 = Fcd900*At*(2*Fp900/rho*(1-(beta^4)))^(1/2);
    Fv900 = Fq900/Ae;
    Re900 = (rho*Fv900*De)/mu;
    err900 = abs(Fv900 - FvR900);
end

Fcd900 = 0.9965 - 6.53*(beta/Re900)^(1/2); %유출계수
Fq900 = Fcd900*At*(2*Fp900/rho*(1-(beta^4)))^(1/2); %유량

%1300RPM
Re1300 = 40000; % 초기 레이놀즈수 가정
FvR1300 = (mu*Re1300)/(rho*De); % 초기값
Fcd1300 = 0.9965 - 6.53*(beta/Re1300)^(1/2); %유출계수
Fp1300 = 998.2*9.81*0.302; %압력차 (오차보정 -3cm)
Fq1300 = Fcd1300*At*(2*Fp1300/rho*(1-(beta^4))).^(1/2); %유량
Fv1300 = Fq1300/Ae; %유속
Re1300 = (rho*Fv1300*De)/mu; %레이놀즈수

err1300 = abs(Fv1300 - FvR1300); %오차

count1300 = 0;

while (err1300 >= 0.00001) %반복문
    count1300 = count1300 +1;
    FvR1300 = (mu*Re1300)/(rho*De);
    Fcd1300 = 0.9965 - 6.53*(beta/Re1300)^(1/2);
    Fq1300 = Fcd1300*At*(2*Fp1300/rho*(1-(beta^4))).^(1/2);
    Fv1300 = Fq1300/Ae;
    Re1300 = (rho*Fv1300*De)/mu;
    err1300 = abs(Fv1300 - FvR1300);
end

Fcd1300 = 0.9965 - 6.53*(beta/Re1300)^(1/2); %유출계수
Fq1300 = Fcd1300*At*(2*Fp1300/rho*(1-(beta^4))).^(1/2); %유량

fprintf('\n@@@@@ Flow Nozzle @@@@@\n');
fprintf('\n# 900RPM #\n\n');
fprintf('유출계수 : %f\n',Fcd900);
fprintf('레이놀즈수 : %f\n',Re900);
fprintf('압력차 : %f Pa\n',Fp900);
fprintf('유속 : %f m/s\n',Fv900);
fprintf('유량 : %f m^3/s\n',Fq900);
fprintf('\n# 1300RPM #\n\n');
fprintf('유출계수 : %f\n',Fcd900);
fprintf('레이놀즈수 : %f\n',Re1300);
fprintf('압력차 : %f Pa\n',Fp1300);
fprintf('유속 : %f m/s\n',Fv1300);
fprintf('유량 : %f m^3/s\n',Fq1300);

%피토관 실험
x = -0.02:2.5e-03:0.02;
p900 = [45 59 65 73 80 82 86 87 87 ...
    85 81 76 70 65 56 48 48];
p1300 = [97 120 135 148 160 168 173 ...
    178 178 175 170 167 158 140 123 107 100];

%유속 계산
v900 = zeros(17,1);
v1300 = zeros(17,1);
vcount = 0;
for i=1:17
    vcount = vcount +1;
    v900(i) = (2*p900(i)/rho).^(1/2);
    v1300(i) = (2*p1300(i)/rho).^(1/2);
end

%유량 계산
q900 = zeros(8,1);
q1300 = zeros(8,1);
A900 = zeros(8,1);
A1300 = zeros(8,1);
qcount = 0;
for i=1:7
    qcount = qcount + 1;
    A900(i) = pi*((x(i).^2)-(x(i+1).^2)); %미소면적
    q900(i) = A900(i)*((v900(i)+v900(i+1)+v900(18-i)+v900(17-i))/4); %유량
    A1300(i) = pi*((x(i).^2)-(x(i+1).^2));
    q1300(i) = A1300(i)*((v1300(i)+v1300(i+1)+v900(18-i)+v900(17-i))/4);
end
qcount = 8;
A900(8) = pi*(x(8).^2);
A1300(8) = pi*(x(8).^2);
q900(8) = A900(8)*((v900(8)+v900(9)+v900(10))/3);
q1300(8) = A1300(8)*((v1300(8)+v1300(9)+v1300(10))/3);

%이론치
ov900 = zeros(17,1);
ov1300 = zeros(17,1);
qa900 = zeros(17,1);
qa1300 = zeros(17,1);
for i=1:17
    ov900(i) = (2*p900(i)/rho*(1-(beta^4))).^(1/2); %오리피스 유속
    ov1300(i) = (2*p1300(i)/rho*(1-(beta^4))).^(1/2); 
    qa900(i) = At*(2*p900(i)/rho*(1-(beta^4))).^(1/2); %유량 이론값
    qa1300(i) = At*(2*p1300(i)/rho*(1-(beta^4))).^(1/2);
end

fprintf('\n@@@@@ Pitot Tube @@@@@\n');
fprintf('\n# 900RPM #\n\n');
fprintf('유량 : %f m^3/s\n',sum(q900));
fprintf('\n# 1300RPM #\n\n');
fprintf('유량 : %f m^3/s\n',sum(q1300));

%오차
fprintf('\n@@@@@ ERROR @@@@@\n');
erv900 = (abs(sum(q900) - Vq900)/sum(q900))*100;
erf900 = (abs(sum(q900) - Fq900)/sum(q1300))*100;
erv1300 = (abs(sum(q1300) - Vq1300)/sum(q1300))*100;
erf1300 = (abs(sum(q1300) - Fq1300)/sum(q1300))*100;
fprintf('\n# 900RPM #\n\n');
fprintf('Venturi : %f %%\n',erv900);
fprintf('Flow Nozzle : %f %%\n',erf900);
fprintf('\n# 1300RPM #\n\n');
fprintf('Venturi : %f %%\n',erv1300);
fprintf('Flow Nozzle : %f %%\n',erf1300);

%그래프
figure(1)
plot(x,v900,'-o')
hold on
plot(x,v1300,'-o')
title('피토관 위치에 따른 측정 유속','fontsize',12)
xlabel('위치(mm)','fontsize',12)
ylabel('유속(m/s)','fontsize',12)
set(gca,'xlim',[-0.021 0.021],'ylim',[8,18])
legend('900RPM','1300RPM')