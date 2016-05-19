function Qw = experiment(Hw)
%Hw: ��������

clc %�ʱ�ȭ (�� ����� 20��C ����)
rho = 1000; %�� �е�
ga = 9.81; %�߷°��ӵ�
mu = 1.519e-03; %�������
De = 0.023; %�Ա��� ���� (m)
Dt = 0.0145; %throttle ���� (m)
beta = Dt/De; %�����
Ae = (pi * De^2)/4; %�Ա��� �ʺ�
At = (pi * Dt^2)/4; %throttle �ʺ�

%��������
Lw = 0.17; %���� ��
Pw = 0.295; %�����ٴ�~���� ������ ����
if Pw <= 1
    ew = 0;
else
    ew = something;
end
Kw = 1.785 + ( ( (0.00295 / Hw) + 0.237 * (Hw/Pw) ) * (1 + ew) )
Qw = Kw * Lw * (Hw^(3/2))

%���� ����
Vcd = 0.9858 - 0.196*(beta).^(4.5); %������
Vp = rho*ga*0.421; %�з��� (�������� -3cm)
Vv = (2*Vp/(rho*(1-(beta^4)))).^(1/2); %����
Vq = Vcd * At * Vv; %����

fprintf('@@@@@ Venturi Tube @@@@@\n\n');
fprintf('������ : %f\n',Vcd);
fprintf('\n# 900RPM #\n\n');
fprintf('�з��� : %f Pa\n',Vp);
fprintf('���� : %f m/s\n',Vv);
fprintf('���� : %f m^3/s\n',Vq);

%�������� ����
Re = 40000; % �ʱ� ���̳���� ����
FvR = (mu*Re)/(rho*De); % �ʱⰪ
Fcd = 0.9965 - 6.53*(beta/Re)^(1/2); %������
Fp = rho*ga*0.072; %�з��� (�������� -3cm)
Fq = Fcd*At*(2*Fp/rho*(1-(beta^4)))^(1/2); %����
Fv = Fq/Ae; %����
Re = (rho*Fv*De)/mu; %���̳����

err900 = abs(Fv - FvR); %����

count = 0;

while (err900 >= 0.00001) %�ݺ��� (������ 0.00001 �̸��� �ɶ�����)
    count = count + 1;
    FvR = (mu*Re)/(rho*De);
    Fcd = 0.9965 - 6.53*(beta/Re)^(1/2);
    Fq = Fcd*At*(2*Fp/rho*(1-(beta^4)))^(1/2);
    Fv = Fq/Ae;
    Re = (rho*Fv*De)/mu;
    err900 = abs(Fv - FvR);
end

Fcd = 0.9965 - 6.53*(beta/Re)^(1/2); %������
Fq = Fcd*At*(2*Fp/rho*(1-(beta^4)))^(1/2); %����

fprintf('\n@@@@@ Flow Nozzle @@@@@\n');
fprintf('\n# 900RPM #\n\n');
fprintf('������ : %f\n',Fcd);
fprintf('���̳���� : %f\n',Re);
fprintf('�з��� : %f Pa\n',Fp);
fprintf('���� : %f m/s\n',Fv);
fprintf('���� : %f m^3/s\n',Fq);
