%% Atom Tracing
% load the reconstructed 3D volume
addpath('./src');
Recon_filename = './Input/Run1s_FinalReconEnd.mat';
Recon = importdata(Recon_filename);
RecVol = Recon.reconstruction;
clear Recon

% Set tracing parameters
Th = 1;
MaxNumberPeaks = 1000000;
SearchRad = 3;
MaxIter = 14;
CritIter = 7;
Res = 0.339418 / 3; % Angstrom per oversampled voxel
Dmin = 2.0 / Res;

atom_pos = trace_atom_positions(RecVol, Dmin, MaxNumberPeaks, SearchRad, Th, MaxIter, CritIter);

%% Classify the traced peaks
% Initial integrated-intensity windows for the three templates
IntensityCenters = [0, 2e5, 3e5];
IntensityHalfWidth = 1e4;
labels = classify_atom_positions(double(RecVol), atom_pos, IntensityCenters, IntensityHalfWidth);
model = atom_pos(:, labels ~= 1);

%% Save the traced atomic model
if ~isfolder('Output')
    mkdir('Output');
end
save('Output/PdSi_Tracing.mat', 'model');
