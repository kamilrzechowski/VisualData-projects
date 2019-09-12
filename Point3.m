%% load images
Ir_sift_rgb = imread("C:\Kamil\VCC-KTH\Visual data analysis\projects\Project\data1\obj1_5.JPG");
It_sift_rgb = imread("C:\Kamil\VCC-KTH\Visual data analysis\projects\Project\data1\obj1_t1.JPG");
Ir_sift = single(rgb2gray(Ir_sift_rgb));
It_sift = single(rgb2gray(It_sift_rgb));

%% apply sift
[f_ref, d_ref] = vl_sift(Ir_sift, 'PeakThresh', 16, 'edgethresh', 5) ;
[f_target, d_target] = vl_sift(It_sift, 'PeakThresh', 16, 'edgethresh', 5) ;

%find descriptors length
[f_num1,descriptor_length_ref] = size(d_ref);
[f_num2,descriptor_length_target] = size(d_target);

%% threshold matching
%matches = fixed_treshold(d_ref, d_target,4);

%% nearest neighobur
matches = nearest_neighbour(d_ref, d_target,300);

%% nearest neighbour ratio
%matches = nearest_neighbour_ratio(d_ref, d_target);

%% plot matches
dh1 = max(size(It_sift,1)-size(Ir_sift,1),0) ;
dh2 = max(size(Ir_sift,1)-size(It_sift,1),0) ;
o = size(Ir_sift,2);
imagesc([padarray(uint8(Ir_sift_rgb),dh1,'post') padarray(uint8(It_sift_rgb),dh2,'post')]);
line([f_ref(1,matches(1,:));f_target(1,matches(2,:))+o],[f_ref(2,matches(1,:));f_target(2,matches(2,:))]) ;



