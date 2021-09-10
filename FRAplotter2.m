function [bp f g p]= FRAplotter(CSV,tidx,fidx,inidx,outidx,Ts,Fsta,Fend,Fstep,Ni,Au,Bu,Tsta,col,lw,ms)
%FRAPLOTTER �������ʂƃV�~�����[�V�����̃{�[�h���}���d�˂�
%  
FileName=CSV;

%% FRA�̑���p�����[�^�̐ݒ�(���@�̃p�����[�^�ɍ��킹��)
%Ts;% [s]  �T���v�����O����
%Fsta;	% [Hz] �J�n���g��
%Fend;	% [Hz] �I�����g��
%Fstep;% [Hz] ���g���X�e�b�v
%Ni;	% [-]  �ϕ�����
%Au;   % [-]  �U��
%Bu;		% [-]  �o�C�A�X
%Tsta;	% [s] FRA�J�n����

%% ���g���x�N�g������
freq = Fsta:Fstep:Fend;
flen = length(freq);

%% ���@�f�[�^�ǂݍ���
%% �J�n�������ȑO�̃f�[�^���폜����O����
data=csvread(strcat(FileName,'.csv'));
ClipIndex = data(:,1) >= Tsta;    % �~�����f�[�^�͈͂����ԂŎ��o�����߂̃C���f�b�N�X

t = data(ClipIndex,tidx) - Tsta;      % [s]  ����
f = data(ClipIndex,fidx);             % [Hz] ���g��
ref = data(ClipIndex,inidx);         % [A]  �d���w�ߒl
res = data(ClipIndex,outidx);         % [rad]���x����


tlen = length(t);
clear data;
% ------- �f�[�^���Ԉ����ꍇ
% ThinRate = 1;	% �Ԉ����v�f��
[~,fidx] = max(f);
tmax = t(fidx);
% tThin = t(1:ThinRate:tlen);
% fThin = f(1:ThinRate:tlen);
% iqrefThin = iqref(1:ThinRate:tlen);
% wmresThin = wmres(1:ThinRate:tlen);

%% FRA�̌v�Z
y = res;
tini = 0;
Ar(1:flen) = 0;
Ai(1:flen) = 0;
j = 1;
for i=1:tlen-1,
	Ar(j) = Ar(j) + y(i)*cos(2*pi*f(i)*(t(i) - tini))*Ts;
	Ai(j) = Ai(j) + y(i)*sin(2*pi*f(i)*(t(i) - tini))*Ts;
	if(f(i) ~= f(i+1))
		if(j < flen)
			Ar(j) = 2*f(i)/Ni*Ar(j);
			Ai(j) = 2*f(i)/Ni*Ai(j);
			tini = t(i);
			j = j + 1;
		else
			break;
		end;
	end
end
%figure(127); plot(freq,Ar,'x-', freq,Ai,'x-');	% �m�F�p

%% �Ō�̃f�[�^�������������Ȃ�̂ŏ����Ă���
Ar(flen) = [];
Ai(flen) = [];
freq(flen) = [];
flen = length(freq);

%% ���g�������̌v�Z
Ay = sqrt(Ar.^2 + Ai.^2);          % �o�͐U���v�Z
G = 20*log10(Ay./Au);              % �Q�C�������v�Z
P = unwrap(-atan2(Ai,Ar))*180/pi;  % �ʑ������v�Z
f=freq; g=G; p=P;                  % �߂�l
%% ���g�������̕`��
ax1=subplot(2,1,1);
	h=semilogx(freq,G,'x-');
	set(h,'linewidth',lw);
    set(h,'markersize',ms);
    set(h,'Color',col);
    bp=h;
	xlabel('Frequency [Hz]', 'FontSize',12);
	ylabel('Gain [dB]', 'FontSize',12);
	set(gca,'FontSize',12);
	grid on;
	xlim([Fsta,Fend]);
    set(ax1,'NextPlot','Add');
ax2=subplot(2,1,2);
    h=semilogx(freq,P,'x-');
	set(h,'linewidth',lw);
    set(h,'markersize',ms);
    set(h,'Color',col);
    bp=h;
	xlabel('Frequency [Hz]', 'FontSize',12);
	ylabel('Phase [deg]', 'FontSize',12);
	xlim([Fsta,Fend]);
	grid on;

% 	legend('G','Location','NorthEast','Orientation','Vertical');
% 	legend boxoff;
    set(ax2,'NextPlot','Add');
end

