function [bp f g p]= FRAplotter(CSV,tidx,fidx,inidx,outidx,Ts,Fsta,Fend,Fstep,Ni,Au,Bu,Tsta,col,lw,ms)
%FRAPLOTTER 実験結果とシミュレーションのボード線図を重ねる
%  
FileName=CSV;

%% FRAの測定パラメータの設定(実機のパラメータに合わせる)
%Ts;% [s]  サンプリング時間
%Fsta;	% [Hz] 開始周波数
%Fend;	% [Hz] 終了周波数
%Fstep;% [Hz] 周波数ステップ
%Ni;	% [-]  積分周期
%Au;   % [-]  振幅
%Bu;		% [-]  バイアス
%Tsta;	% [s] FRA開始時刻

%% 周波数ベクトル生成
freq = Fsta:Fstep:Fend;
flen = length(freq);

%% 実機データ読み込み
%% 開始時刻より以前のデータを削除する前処理
data=csvread(strcat(FileName,'.csv'));
ClipIndex = data(:,1) >= Tsta;    % 欲しいデータ範囲を時間で取り出すためのインデックス

t = data(ClipIndex,tidx) - Tsta;      % [s]  時間
f = data(ClipIndex,fidx);             % [Hz] 周波数
ref = data(ClipIndex,inidx);         % [A]  電流指令値
res = data(ClipIndex,outidx);         % [rad]速度応答


tlen = length(t);
clear data;
% ------- データを間引く場合
% ThinRate = 1;	% 間引く要素数
[~,fidx] = max(f);
tmax = t(fidx);
% tThin = t(1:ThinRate:tlen);
% fThin = f(1:ThinRate:tlen);
% iqrefThin = iqref(1:ThinRate:tlen);
% wmresThin = wmres(1:ThinRate:tlen);

%% FRAの計算
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
%figure(127); plot(freq,Ar,'x-', freq,Ai,'x-');	% 確認用

%% 最後のデータだけおかしくなるので消しておく
Ar(flen) = [];
Ai(flen) = [];
freq(flen) = [];
flen = length(freq);

%% 周波数特性の計算
Ay = sqrt(Ar.^2 + Ai.^2);          % 出力振幅計算
G = 20*log10(Ay./Au);              % ゲイン特性計算
P = unwrap(-atan2(Ai,Ar))*180/pi;  % 位相特性計算
f=freq; g=G; p=P;                  % 戻り値
%% 周波数特性の描画
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

