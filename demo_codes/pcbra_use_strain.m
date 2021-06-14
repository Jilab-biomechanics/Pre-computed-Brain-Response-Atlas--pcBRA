%% Load Atlas
pcbra = load('atlas_vox.mat');
pcbra = pcbra.atlas_vox;
a_rot = linspace(1500, 7500, 9);
theta_1 = linspace(-90, 90, 13);
alpha_1 = linspace(-90, 90, 13);
[arot2, theta2, alpha2] = ndgrid(a_rot, theta_1, alpha_1);
load_matrix = [arot2(:), theta2(:), alpha2(:)];
a = 1:length(a_rot);
b = 1:length(theta_1);
c = 1:length(alpha_1);
[a, b, c] = ndgrid(a, b, c);
ind_mat = [a(:), b(:), c(:)];
%% Interpolate
acceleration = 7000;
azimuth = 60;
elevation = 70;
parfor jj = 1:size(pcbra,4)
    iter_elm(jj) = interpn(arot2,theta2, alpha2,pcbra(:,:,:,jj), acceleration, azimuth, elevation,'spline');
end

%% Visualize
brain = load('brain.mat');
brain = brain.brain;

strains = nan(size(brain));
strains(brain==1) = iter_elm;
figure
subplot(1,3,1)
imagesc(squeeze(strains(:,15,:)))
axis equal
subplot(1,3,2)
imagesc(squeeze(strains(:,:,15)))
axis equal
subplot(1,3,3)
imagesc(squeeze(strains(10,:,:)))
axis equal