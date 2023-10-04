function Q_frq = frequency_response_analysis(Frequency_Response)
    % This function performs analysis on the frequency response data
    % and returns the coefficients from the fitting procedure.

    % Preliminary constants for the analysis
    Q_estimation = 50;
    scaning_rang = 20;

    % Plot raw frequency response data
    plot(Frequency_Response(:,1),Frequency_Response(:,2),'o','LineWidth',2);
    hold on;

    % Identify the maximum value in the frequency response data
    index = find(Frequency_Response(:,2) == max(Frequency_Response(:,2)));

    % Prepare data for curve fitting
    [xData, yData] = prepareCurveData( Frequency_Response(index-scaning_rang:index+scaning_rang,1), Frequency_Response(index-scaning_rang:index+scaning_rang,2) );

    % Define the fit type and options
    ft = fittype( 'delta_st/sqrt((1-(f/fr)^2)^2+(f/(fr*Q))^2)', 'independent', 'f', 'dependent', 'y' );
    opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
    opts.Display = 'Off';
    opts.Lower = [0 0 0];
    opts.Robust = 'Bisquare';
    opts.StartPoint = [Q_estimation 3.93e-05 Frequency_Response(index,1)];

    % Execute the curve fitting
    [fitresult, ~] = fit( xData, yData, ft, opts );

    % Plot the fitting result
    fit_result = plot(fitresult,'--');
    set(fit_result,'LineWidth',1.2);
    
    % Extract and return the coefficients
    coeffs = coeffvalues(fitresult);
    Q_frq = coeffs(1);
    
    % Design plot
    xlabel('$Frequancy\ (Hz)$', 'Interpreter','latex')
    ylabel('$Intensity\ (A.U)$', 'Interpreter','latex')
    grid off
    box on
    set(gca,'fontsize',16)
    set(legend,'fontsize',10)
    legend('hide')
    annotation('textbox',[.6 .5 .3 .3],'String',['Q = ',num2str(Q_frq)],'FitBoxToText','on');
end