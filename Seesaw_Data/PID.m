%load data
clear all, clc, close all
load('PID.mat');
load('PD.mat');
load('P.mat');
%initialization time on zero
time1 = time1 - time1(1);
time2 = time2 - time2(1);
time3 = time3 - time3(1);

%time-angle w/ cmd Diagram [PID]
figure (1)
subplot(2,3,1);
plot(time1,angle1,'b','LineWidth',1);
hold on
plot(time1,command1,'r','LineWidth',1);
set(gcf,'color','w')
title('time-angle w/ cmd Diagram [PID]','fontsize',12)
xlabel('Time(sec)','fontsize',12)
ylabel('Angle(deg)','fontsize',12)

%time-angle w/ cmd Diagram [PD]
subplot(2,3,2);
plot(time2,angle2,'b','LineWidth',1);
hold on
plot(time2,command2,'r','LineWidth',1);
set(gcf,'color','w')
title('time-angle w/ cmd Diagram [PD]','fontsize',12)
xlabel('Time(sec)','fontsize',12)
ylabel('Angle(deg)','fontsize',12)

%time-angle w/ cmd Diagram [P]
subplot(2,3,3);
plot(time3,angle3,'b','LineWidth',1);
hold on
plot(time3,command3,'r','LineWidth',1);
set(gcf,'color','w')
legend('angle','command')
title('time-angle w/ cmd Diagram [P]','fontsize',12)
xlabel('Time(sec)','fontsize',12)
ylabel('Angle(deg)','fontsize',12)

%time-angular velocity w/ cmd Diagram [PID]
subplot(2,3,4);
plot(time1,av1,'c','LineWidth',1);
hold on
plot(time1,command1,'m','LineWidth',1);
set(gcf,'color','w')
title('time-angular velocity w/ cmd Diagram [PID]','fontsize',12)
xlabel('Time(sec)','fontsize',12)
ylabel('Angular Velocity(RPM)','fontsize',12)

%time-angular velocity w/ cmd Diagram [PD]
subplot(2,3,5);
plot(time2,av2,'c','LineWidth',1);
hold on
plot(time2,command2,'m','LineWidth',1);
set(gcf,'color','w')
title('time-angular velocity w/ cmd Diagram [PD]','fontsize',12)
xlabel('Time(sec)','fontsize',12)
ylabel('Angular Velocity(RPM)','fontsize',12)

%time-angular velocity w/ cmd Diagram [PID]
subplot(2,3,6);
plot(time3,av3,'c','LineWidth',1);
hold on
plot(time3,command3,'m','LineWidth',1);
set(gcf,'color','w')
legend('angular velocity','command')
title('time-angular velocity w/ cmd Diagram [P]','fontsize',12)
xlabel('Time(sec)','fontsize',12)
ylabel('Angular Velocity(RPM)','fontsize',12)

%calculating error
err1 = abs(command1 - angle1);
err2 = abs(command2 - angle2);
err3 = abs(command3 - angle3);
%define sample rate
dt = 0.1;
%apply PID gain into manipulated variable
for i=1:1923
    %Propotional/Intergrating/Derivating errors
    Perr1(i+1) = err1(i+1);
    Derr1(i+1) = (err1(i+1) - err1(i))/dt;
    Ierr1(i+1) = (err1(i+1) + err1(i))*dt/2;
    MV1(i+1) = (P1(i)*Perr1(i) + I1(i)*Ierr1(i+1) + D1(1)*Derr1(i))*0.1;
end
for i=1:1588
    %Propotional/Intergrating/Derivating errors
    Perr2(i+1) = err2(i+1);
    Derr2(i+1) = (err2(i+1) - err2(i))/dt;
    Ierr2(i+1) = (err2(i+1) + err2(i))*dt/2;
    MV2(i+1) = (P2(i)*Perr2(i) + I1(i)*Ierr2(i+1) + D1(1)*Derr2(i))*0.1;
end
for i=1:527
    %Propotional/Intergrating/Derivating errors
    Perr3(i+1) = err3(i+1);
    Derr3(i+1) = (err3(i+1) - err3(i))/dt;
    Ierr3(i+1) = (err3(i+1) + err3(i))*dt/2;
    MV3(i+1) = (P3(i)*Perr3(i) + I3(i)*Ierr3(i+1) + D3(1)*Derr3(i))*0.1;
end
%cutoff time

%time-PID w/ cmd Diagram
figure (2)
plot(time1,MV1,'b','LineWidth',1);
hold on
plot(time2,MV2,'g','LineWidth',1);
plot(time3,MV3,'c','LineWidth',1);
plot(time1,command1,'r','LineWidth',1);
set(gcf,'color','w')
legend('PID','PD','P','ON/OFF')
title('time-PID w/ cmd Diagram','fontsize',12)
xlabel('Time(sec)','fontsize',12)
ylabel('angle(deg)','fontsize',12)
