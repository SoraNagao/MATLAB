function y = figreshaper(hfig,aspect)
    %myFun - Description
    %
    % Syntax: figreshaper y =  = myFun(input)
    % hfig: figのハンドラ
    % aspect: 縦の横の比 1で3:1 2で3:2
    % Long description
        hold on;
        grid on;
        box on;
        pfig=pubfig(hfig);
        if aspect==1
            pfig.Dimension=[24,8];
        elseif aspect==2
            pfig.Dimension=[20,15];
        else
            pfig.Dimension=[20,20];
        end
end