%% load images
Ir_rgb = imread("C:\Kamil\VCC-KTH\Visual data analysis\projects\Project\data1\obj1_5.JPG");
It_rgb = imread("C:\Kamil\VCC-KTH\Visual data analysis\projects\Project\data1\obj1_t1.JPG");
Ir_sift = single(rgb2gray(Ir_rgb));
It_sift = single(rgb2gray(It_rgb));
Ir_surf = (rgb2gray(Ir_rgb));
It_surf = (rgb2gray(It_rgb));

%% apply sift
peakThreshold = 14;
edgeThreshold = 6;
[f_ref, d_ref] = vl_sift(Ir_sift, 'PeakThresh', peakThreshold, 'edgethresh', edgeThreshold) ;
[f_target, d_target] = vl_sift(It_sift, 'PeakThresh', peakThreshold, 'edgethresh', edgeThreshold) ;

%% threshold matching
%matches = fixed_treshold(d_ref, d_target,4);

%% nearest neighobur
%matches = nearest_neighbour(d_ref, d_target,300);

%% nearest neighbour ratio
matches = nearest_neighbour_ratio(d_ref, d_target, 0.5);

%% plot matches
%dh1 = max(size(It_sift,1)-size(Ir_sift,1),0) ;
%dh2 = max(size(Ir_sift,1)-size(It_sift,1),0) ;
%o = size(Ir_sift,2);
imagesc([padarray(uint8(Ir_rgb),dh1,'post') padarray(uint8(It_rgb),dh2,'post')]);
line([f_ref(1,matches(1,:));f_target(1,matches(2,:))+o],[f_ref(2,matches(1,:));f_target(2,matches(2,:))]) ;

% plot only subset of all matches
% perm = randperm(uint8(size(matches,2)/8));
% sel = perm(:);
% line([f_ref(1,matches(1,sel));f_target(1,matches(2,sel))+o],[f_ref(2,matches(1,sel));f_target(2,matches(2,sel))]) ;

% plot sift keypoints
% f_target(1,:) = f_target(1,:) + o;
% h1 = vl_plotframe(f_ref(:,:)) ;
% h2 = vl_plotframe(f_ref(:,:)) ;
% h3 = vl_plotframe(f_target(:,:)) ;
% h4 = vl_plotframe(f_target(:,:)) ;
% set(h1,'color','k','linewidth',3) ;
% set(h2,'color','y','linewidth',2) ;
% set(h3,'color','k','linewidth',3) ;
% set(h4,'color','y','linewidth',2) ;


%% detect matches with surf
% num_features = 293; %let's choose only strongest features
% features_surf_ref = detectSURFFeatures(Ir_surf);
% features_surf_ref = features_surf_ref.selectStrongest(num_features);
% features_surf_target = detectSURFFeatures(It_surf);
% features_surf_target = features_surf_target.selectStrongest(num_features);
% 
% [descriptor_surf_ref,vpts1] = extractFeatures(Ir_surf,features_surf_ref);
% [descriptor_surf_target,vpts2] = extractFeatures(It_surf,features_surf_target);
% descriptor_surf_ref = descriptor_surf_ref';
% descriptor_surf_target = descriptor_surf_target';
% matches = nearest_neighbour_ratio(descriptor_surf_ref, descriptor_surf_target);
% keypoints_location_ref = features_surf_ref.Location';
% keypoints_location_target = features_surf_target.Location';
% 
% dh1 = max(size(Ir_surf,1)-size(Ir_surf,1),0) ;
% dh2 = max(size(It_surf,1)-size(It_sift,1),0) ;
% o = size(Ir_sift,2);
% imagesc([padarray(uint8(Ir_rgb),dh1,'post') padarray(uint8(It_rgb),dh2,'post')]);
% line([keypoints_location_ref(1,matches(1,:));keypoints_location_target(1,matches(2,:))+o],[keypoints_location_ref(2,matches(1,:));keypoints_location_target(2,matches(2,:))]) ;



