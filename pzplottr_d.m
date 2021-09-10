function pzplt = pzplotter_d(sys, mksizes, font_size, x_lim, y_lim)
    %
    % 引数の説明
    %
    % sys システム 連続でも離散でも可
    %
    % mksize(1) 極のマーカーサイズ
    % mksize(2) 零点のマーカーサイズ
    % mksize(3) マーカーの線の太さ
    %
    % font_size ラベルと目盛り数字のフォントサイズ
    %
    % x_lim(1) 0:x軸範囲指定無し、0以外:x軸範囲指定あり
    % x_lim(2) x軸最小値
    % x_lim(3) x軸最大値
    %
    % y_lim(1) 0:y軸範囲指定無し、0以外:y軸範囲指定あり
    % y_lim(2) y軸最小値
    % y_lim(3) y軸最大値

    % xy軸の原点に線を引く
    xline(0,'k-','LineWidth',1);
    hold on;
    yline(0,'k-','LineWidth',1);
    hold on;

    % sysの極と零点を求める
    [p, z]=pzmap(sys);
    real_p=real(p);imag_p=imag(p);real_z=real(z);imag_z=imag(z);

    % プロット開始
    if mksizes(1)~=0 & mksizes(2)~=0
        pzplt=plot(real_p,imag_p,'x','MarkerSize',mksizes(1),'LineWidth',mksizes(3));
        ax=gca;ax.ColorOrderIndex = ax.ColorOrderIndex-1;
        hold on;
        pzplt=plot(real_z,imag_z,'o','MarkerSize',mksizes(2),'LineWidth',mksizes(3));
    elseif mksizes(1)~=0 
        pzplt=plot(real_p,imag_p,'x','MarkerSize',mksizes(1),'LineWidth',mksizes(3));
    elseif mksizes(2)~=0
        pzplt=plot(real_z,imag_z,'o','MarkerSize',mksizes(2),'LineWidth',mksizes(3));
    end

    % 離散システムの場合に単位円を追加
    if sys.Ts ~= 0
      cirt = [0:pi/10000:2*pi];
      hold on;
      unit_circle = plot(sin(cirt), cos(cirt), 'k--');
    end

    % 右上の枠線を追加
    box on;

    % ラベル指定
    xlabel('Real Axis [rad/s]', 'FontSize', font_size, 'color', 'k');
    ylabel('Imaginary Axis [rad/s]', 'FontSize', font_size, 'color', 'k');

    % xy軸の描画範囲指定
    if x_lim(1) ~= 0
      set(gca, 'Xlim', [x_lim(2), x_lim(3)]);
    end
    if y_lim(1) ~= 0
      set(gca, 'Ylim', [y_lim(2), y_lim(3)]);
    end

    % その他設定
    ax.FontSize = font_size; % 目盛りの文字サイズ指定
    ax.LineWidth = 1;
    ax.FontName = 'Times New Roman';
end