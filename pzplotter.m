function pzplt = pzplotter(sys,mksizes)
    % (sys, mksizes)
    % (tf, [pole-size, zero-size, linewidth]
    %

    yline(0,'k-','LineWidth',1);
    xline(0,'k-','LineWidth',1);
    [p, z]=pzmap(sys);
    real_p=real(p);imag_p=imag(p);real_z=real(z);imag_z=imag(z);
    if mksizes(1)~=0 & mksizes(2)~=0
            pzplot=plot(real_p,imag_p,'x','MarkerSize',mksizes(1),'LineWidth',mksizes(3));
            ax=gca;ax.ColorOrderIndex = ax.ColorOrderIndex-1;
            pzplt=plot(real_z,imag_z,'o','MarkerSize',mksizes(2),'LineWidth',mksizes(3));
    elseif mksizes(1)~=0
            pzplt=plot(real_p,imag_p,'x','MarkerSize',mksizes(1),'LineWidth',mksizes(3));
    elseif mksizes(2)~=0
        pzplt=plot(real_z,imag_z,'o','MarkerSize',mksizes(2),'LineWidth',mksizes(3));
    end
    ylabel('Im [rad/s]');
    xlabel('Re [rad/s]');

end