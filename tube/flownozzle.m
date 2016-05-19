clc %초기화 (전 계수는 20°C 기준)
rho = 1000; %물 밀도
ga = 9.81; %중력가속도
mu = 1.519e-03; %점성계수
De = 0.023; %입구의 직경 (m)
Dt = 0.0145; %throttle 직경 (m)
beta = Dt/De; %직경비
Ae = (pi * De^2)/4; %입구의 너비
At = (pi * Dt^2)/4; %throttle 너비

%유동노즐 실험
Re = 40000; % 초기 레이놀즈수 가정
FvR = (mu*Re)/(rho*De); % 초기값
Fcd = 0.9965 - 6.53*(beta/Re)^(1/2); %유출계수
Fp = rho*ga*0.072; %압력차 (오차보정 -3cm)
Fq = Fcd*At*(2*Fp/rho*(1-(beta^4)))^(1/2); %유량
Fv = Fq/Ae; %유속
Re = (rho*Fv*De)/mu; %레이놀즈수

err900 = abs(Fv - FvR); %오차

count = 0;

while (err900 >= 0.00001) %반복문 (오차가 0.00001 미만이 될때까지)
    count = count + 1;
    FvR = (mu*Re)/(rho*De);
    Fcd = 0.9965 - 6.53*(beta/Re)^(1/2);
    Fq = Fcd*At*(2*Fp/rho*(1-(beta^4)))^(1/2);
    Fv = Fq/Ae;
    Re = (rho*Fv*De)/mu;
    err900 = abs(Fv - FvR);
end

Fcd = 0.9965 - 6.53*(beta/Re)^(1/2); %유출계수
Fq = Fcd*At*(2*Fp/rho*(1-(beta^4)))^(1/2); %유량

fprintf('\n@@@@@ Flow Nozzle @@@@@\n');
fprintf('유출계수 : %f\n',Fcd);
fprintf('레이놀즈수 : %f\n',Re);
fprintf('압력차 : %f Pa\n',Fp);
fprintf('유속 : %f m/s\n',Fv);
fprintf('유량 : %f m^3/s\n',Fq);
