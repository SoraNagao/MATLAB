function bp = bodeplotter(syses,lineopts)

    %myFun - Description
    %
    % Syntax: scopeplotter y =bodeplotter(input)
    % syses: 伝達関数のリスト
    % lineops: セル配列で各伝達関数のプロットオプションを指定する{Linespec,LineWidth}
    % Long description
    bodeopt=bodeoptions;
    bodeopt.PhaseMatching='on';
    bodeopt.PhaseMatchingValue=0;
    bodeopt.Xlabel.String='Frequnecy';
    bodeopt.Xlabel.FontSize=12;
    bodeopt.Xlabel.String='Frequnecy';
    bodeopt.Ylabel.String={'Gain','Phase'};
    bodeopt.Ylabel.FontSize=12;
    bodeopt.Title.String=' ';
    bodeopt.Grid='on';
    for i=1:length(syses)
        bp=bodeplot(syses(i),bodeopt);
        bp.InputName={''};
        bp.OutputName={''};
        % 7で一巡する
        bp.StyleManager.Styles(i).setstyle('LineStyle',lineopts{i}{1},'LineWidth',lineopts{i}{2});
    end
    hold on;
    grid on; 
    % box on;
    bp.updatestyle;
    % ll=findall(gcf,'type','line');
    % ll(4).LineWidth=lineopts{2}; % phase
    % ll(4).LineStyle=lineopts{1};
    % ll(6).LineWidth=lineopts{2}; % gain
    % ll(6).LineStyle=lineopts{1};

end