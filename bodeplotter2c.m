function bp1 = bodeplotter2(G,glineopts,plineopts,col,fsta,fend)

% プロットの設定
% fsta = 0;				% 開始周波数の指数 10^fsta [Hz]
% fend = 3;				% 終了周波数の指数 10^fend [Hz]
N = 1000;				% プロット点数

% 独自ボードプロットの計算
f = logspace(fsta,fend,N);
w = 2*pi*f;
[mag pha] = bode(G, w);
gain(1:length(w)) = mag(1,1,:);
phas(1:length(w)) = pha(1,1,:);

% if max(phas)>=360
%     while max(phas)>=360
%         phas=phas-360;
%     end
% elseif min(phas)<=-360
%     while min(phas)<=-360
%         phas=phas+360;
%     end
% end
% figure(1);
% 独自ボードプロットの描画
% set(gcf,'PaperPositionMode','auto');
% set(gcf,'color',[1 1 1]);
ax1=subplot(2,1,1);
	h = semilogx(f, 20*log10(gain),glineopts{1});
	set(h,'LineWidth',glineopts{2});    set(h,'Color',col);
    bp1=h;
	xlabel('Frequency [Hz]', 'FontSize',12);
	ylabel('Gain [dB]', 'FontSize',12);
	set(gca,'FontSize',12);
	grid on;
%     xlim([10^fsta 10^fend]);
% 	legend('G','Location','NorthEast','Orientation','Vertical');
% 	legend boxoff;
    set(ax1,'NextPlot','Add');
ax2=subplot(2,1,2);
	h = semilogx(f, phas,plineopts{1});
	set(h,'LineWidth',plineopts{2});    set(h,'Color',col);
    bp2=h;
	xlabel('Frequency [Hz]', 'FontSize',12);
	ylabel('Phase [deg]', 'FontSize',12);
	set(gca,'FontSize',12);
	grid on;
%     xlim([10^fsta 10^fend]);
% 	legend('G','Location','NorthEast','Orientation','Vertical');
% 	legend boxoff;
    set(ax2,'NextPlot','Add');
end