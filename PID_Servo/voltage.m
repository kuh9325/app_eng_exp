load('voltage.mat');
%initialization time on zero
time1 = time1 - time1(1);

%time-angle Diagram [PID]
figure (1)
plot(time1,angle1,'LineWidth',1);
title('time-angle Diagram [changing voltage]','fontsize',12)
xlabel('Time(sec)','fontsize',12)
ylabel('Angular Velocity(RPM)','fontsize',12)