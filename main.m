clear, close all, clc

% load dataset
load('biopsy.mat')

% extracting the needle-only images across time
params.T_period=8; % tracking period
[Needles, b]=NeedleTrackig(img,params);
figure, montage(Needles,"Size",[2 6],"DisplayRange",[0 0.4])

%% trajectory estimation using Hough transform
% Needles: needle-only images, 
% frames: estimation frames of the needles (typically use the strong intensity frame)
% ranges: rough estimation of the insertion angles
% est_traj(Needles,frames,ranges);
est_traj(Needles,7,[30:0.5:70]);

