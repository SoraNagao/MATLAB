function y = scopeplotter(scopedata,idx_t,idx_outputs,lineopts)
%myFun - Description
%
% Syntax: scopeplotter y =scopeplotter(input)
% idx_t: 時間データの添え字
% idx_outputs: 出力データの添え字　配列
% lineoptions: セル配列
% Long description
    if length(idx_outputs)~=length(lineopts)
        error('出力データの要素数とオプションの要素数が違います')
    end
    for i=1:length(idx_outputs)
        y=plot(scopedata(:,idx_t),scopedata(:,idx_outputs(i)),lineopts{i});
    end
end