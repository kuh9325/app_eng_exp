%load data
load('PID.mat');
load('PD.mat');
load('P.mat');
%initialization time on zero
time1_1 = time1_1 - time1_1(1);
time1_2 = time1_2 - time1_2(1);
time1_3 = time1_3 - time1_3(1);
time2_1 = time2_1 - time2_1(1);
time2_2 = time2_2 - time2_2(1);
time2_3 = time2_3 - time2_3(1);
time3_1 = time3_1 - time3_1(1);
time3_2 = time3_2 - time3_2(1);
time3_3 = time3_3 - time3_3(1);

figure(1)
%time-angular velocity Diagram [P=0.8]
plot(time1_1,velocity1_1,'LineWidth',1);
hold on
title('time-angular velocity Diagram [variable P]','fontsize',12)
xlabel('Time(sec)','fontsize',12)
ylabel('Angular Velocity(RPM)','fontsize',12)

%time-angular velocity Diagram [P=1.0]
plot(time1_2,velocity1_2,'LineWidth',1);

%time-angular velocity Diagram [P=1.2]
plot(time1_3,velocity1_3,'LineWidth',1);
legend('P=0.8','P=1.0','P=1.2')

figure(2)
%time-angular velocity Diagram [P=1.0, D=0.005]
plot(time2_1,velocity2_1,'LineWidth',1);
hold on
title('time-angular velocity Diagram [P=1.0, variable D]','fontsize',12)
xlabel('Time(sec)','fontsize',12)
ylabel('Angular Velocity(RPM)','fontsize',12)

%time-angular velocity Diagram [P=1.0, D=0.01]
plot(time2_2,velocity2_2,'LineWidth',1);

%time-angular velocity Diagram [P=1.0, D=0.03]
plot(time2_3,velocity2_3,'LineWidth',1);
legend('D=0.005','D=0.01','D=0.03')

figure(3)
%time-angular velocity Diagram [P=1.0, D=0.01, I=0.001]
plot(time3_1,velocity3_1,'LineWidth',1);
hold on
title('time-angular velocity Diagram [P=1.0, D=0.01, variable I]','fontsize',12)
xlabel('Time(sec)','fontsize',12)
ylabel('Angular Velocity(RPM)','fontsize',12)

%time-angular velocity Diagram [P=1.0, D=0.01, I=0.002]
plot(time3_2,velocity3_2,'LineWidth',1);

%time-angular velocity Diagram [P=1.0, D=0.03, I=0.004]
plot(time3_3,velocity3_3,'LineWidth',1);
legend('I=0.001','I=0.002','I=0.004')