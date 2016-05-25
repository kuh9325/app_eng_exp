%load data
load('refined_data.mat');
%initialization time on zero
time1_2 = time1_2 - time1_2(1);
time2_2 = time2_2 - time2_2(1);
time3_2 = time3_2 - time3_2(1);

%time-angle Diagram [P=0.8]
plot(time1_2,angle1_2,'LineWidth',1);
hold on
%time-angle Diagram [P=1.0, D=0.01]
plot(time2_2,angle2_2,'LineWidth',1);
%time-angle Diagram [P=1.0, D=0.01, I=0.002]
plot(time3_2,angle3_2,'LineWidth',1);
title('time-angle Diagram [compare w/ P, PD, PID, P=1.0, D=0.01, I=0.002]','fontsize',12)
xlabel('Time (sec)','fontsize',12)
ylabel('Angle (¡Æ)','fontsize',12)
legend('P','PD','PID')