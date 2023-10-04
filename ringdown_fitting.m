function Q_ring = ringdown_fitting(Ring_Down)
    % This function performs an analysis on the ringdown data
    % and returns the coefficients from the fitting procedure.

    % Compute the upper envelope of the signal
    [up,~] = envelope(Ring_Down(:,2));
    up = smooth(up,15);

    % Detect the start of the ringdown based on a threshold
    threshold_start = max(up);
    start_idx = find(abs(up) == threshold_start, 1);

    % Detect the stop of the ringdown based on a threshold
    threshold_stop = 0.5*std(up);
    stop_idx = start_idx + find(abs(up(start_idx:end)) < threshold_stop,1);

    % Compute the time points for the extracted envelope
    delta = Ring_Down(2,1);
    num_terms = length(up(start_idx:stop_idx));
    end_time = (num_terms-1)*delta;
    e_decay(:,1) = linspace(0, end_time, num_terms);
    e_decay(:,2) = up(start_idx:stop_idx);

    % Initial estimation and constants
    Q_estimation = 50;

    % Plot the extracted ringdown and envelope data
    figure;
    plot(e_decay(:,1), Ring_Down(start_idx:stop_idx,2),'LineWidth',2);
    hold on;
    plot(e_decay(:,1), e_decay(:,2),'o');
    hold on;

    % Prepare the data for curve fitting
    [xData, yData] = prepareCurveData( e_decay(:,1), e_decay(:,2) );

    % Define the fit type and options
    ft = fittype( 'a*exp((-b/Q)*x)', 'independent', 'x', 'dependent', 'y' );
    opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
    opts.Display = 'Off';
    opts.StartPoint = [Q_estimation max(e_decay(:,2)) 5650];
    opts.TolFun = 1e-08;
    opts.TolX = 1e-08;

    % Execute the curve fitting
    [fitresult, ~] = fit( xData, yData, ft, opts );

    % Plot the fitting result
    fit_result = plot(fitresult,'--');
    set(fit_result,'LineWidth',1.2);
    
    % Extract and return the coefficients
    coeffs = coeffvalues(fitresult);
    Q_ring = coeffs(1);
    
    % Design plot
    xlabel('$Time\ (s)$', 'Interpreter','latex')
    ylabel('$Intensity\ (A.U)$', 'Interpreter','latex')
    grid off
    box on
    set(gca,'fontsize',16)
    set(legend,'fontsize',10)
    legend('Ring Down','Envelope','Fit')
    annotation('textbox',[.4 .5 .3 .3],'String',['Q = ',num2str(Q_ring)],'FitBoxToText','on');
end