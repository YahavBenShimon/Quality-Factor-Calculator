% Initialization: Clearing workspace, closing figures and clearing command window
clear all;
close all;
clc;

% Load and preprocess the data
Ring_Down = importdata('Ring_Down.txt');
Ring_Down = Ring_Down.data;

Frequency_Response = importdata('Frequency_Response.CSV');
Frequency_Response = Frequency_Response.data;
Frequency_Response(:,3) = [];

% Analyze the frequency response data and retrieve coefficients
Q_frq = frequency_response_analysis(Frequency_Response);

% Analyze the ringdown data and retrieve coefficients
Q_ring = ringdown_fitting(Ring_Down);

% Display the resulting coefficients
fprintf('Frequency Response Quality Factor: %s\n', num2str(Q_frq));
fprintf('Ringdown Quality Factor: %s\n', num2str(Q_ring));






