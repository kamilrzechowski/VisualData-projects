%% load images
Ir_rgb = imread("C:\Kamil\VCC-KTH\Visual data analysis\projects\Project\data1\obj1_5.JPG");
It_rgb = imread("C:\Kamil\VCC-KTH\Visual data analysis\projects\Project\data1\obj1_t1.JPG");
Ir_sift = single(rgb2gray(Ir_rgb));
It_sift = single(rgb2gray(It_rgb));
Ir_surf = single(rgb2gray(Ir_rgb));
It_surf = single(rgb2gray(It_rgb));

%% SIFT keypoints (2.2. a)
% [f_ref, d_ref] = vl_sift(Ir_sift, 'PeakThresh', 14, 'edgethresh', 6) ; %adjust threshold and extract features
% 
% imshow(uint8(Ir_sift));
% h1 = vl_plotframe(f_ref(:,:)) ;
% h2 = vl_plotframe(f_ref(:,:)) ;
% set(h1,'color','k','linewidth',3);
% set(h2,'color','y','linewidth',2);

%% SURF keypoints (2.2. a)
%surf on the reference image
% features_SURF_ref = detectSURFFeatures(uint8(Ir_surf));
% figure;
% imshow(uint8(Ir_surf)); hold on;
% features_SURF_ref = features_SURF_ref.selectStrongest(293);
% keypoints_SURF_ref = features_SURF_ref.Location';
% plot(keypoints_SURF_ref(1,:),keypoints_SURF_ref(2,:),'o'); hold off;

%% SIFT and SURF rotate repeatability (2.2. b)
numMatchSIFT = zeros(1,25);
numMatchSURF = zeros(1,25);
repeatabilitySIFT = zeros(1,25);
repeatabilitySURF = zeros(1,25);
degrees = zeros(1,25);

for angle = 0:15:360
    i = (angle/15) +1;
    degrees(i) = angle;
    
    %SIFT image
    %roatate SURF img and extarct keypoints
    I_temp_sift = imrotate(uint8(Ir_sift),angle);
    [keypoints_sift_rotated, descriptor_sift_rotated] = vl_sift(single(I_temp_sift), 'PeakThresh', 14, 'edgethresh', 6);
    %extract keypoints and rotate them (org_keypoints)
    [keypoints_sift, descriptor_sift] = vl_sift(single(Ir_sift), 'PeakThresh', 14, 'edgethresh', 6);
    keypoints_org_sift_rotated = point_rotation(keypoints_sift, angle, size(Ir_sift), size(I_temp_sift));
    
    %SURF image
    %roatate SURF img and extarct keypoints
    num_features = 293; %let's choose only strongest features
    I_temp_surf = imrotate(uint8(Ir_surf), angle);
    features_surf_rotated = detectSURFFeatures(I_temp_surf);
    features_surf_rotated = features_surf_rotated.selectStrongest(num_features);
    keypoints_surf_rotated = features_surf_rotated.Location';
    %extract keypoints and rotate them (org_keypoints)
    features_surf = detectSURFFeatures(uint8(Ir_surf));
    features_surf = features_surf.selectStrongest(num_features);
    keypoints_surf = features_surf.Location';
    keypoints_org_surf_rotated = point_rotation(keypoints_surf, angle, size(Ir_surf), size(I_temp_surf));
    
    
    matches_sift=0;
    matches_surf=0;
    
    numMatchSIFT(i)=find_matches(keypoints_org_sift_rotated,keypoints_sift_rotated);
    numMatchSURF(i)=find_matches(keypoints_org_surf_rotated,keypoints_surf_rotated);
    repeatabilitySIFT(i) = numMatchSIFT(i) / size(keypoints_sift,2);
    repeatabilitySURF(i) = numMatchSURF(i) / size(keypoints_surf,2);
end

title('Repeatability'); xlabel('rotation [degees]'); ylabel('Repability');
plot(degrees,repeatabilitySIFT,'-x'); hold on
plot(degrees,repeatabilitySURF, '-x'); hold off
