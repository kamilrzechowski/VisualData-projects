function matches = fixed_treshold(descriptor_ref, descriptor_target, matches_limit)
    % threshold matching
    % matches_limit = limit of matches for one point in reference image
    %
    % find descriptors length
    [f_num1,descriptor_length_ref] = size(descriptor_ref);
    [f_num2,descriptor_length_terget] = size(descriptor_target);

    matches = []; %= zeros(1 + matches_limit,descriptor_length_ref); %1st place ref keypoint, 2nd,3rd... matching keypoints in target image
    treshold = 300;
    euclideanDistance = zeros(descriptor_length_ref,descriptor_length_terget);
    matches_count = 0;
    for j = 1:descriptor_length_ref
        matches_limit_count = 0;
        for i = 1:descriptor_length_terget
                euclideanDistance(j,i) = norm(double(descriptor_ref(:,j))-double(descriptor_target(:,i)), 2);
                if (euclideanDistance(j,i) < treshold) && (matches_limit_count < matches_limit) 
                   matches_limit_count = matches_limit_count + 1;
                   matches_count = matches_count + 1;
                   %new_row = [j i];
                   %matches = [matches; new_row];
                   matches(1,matches_count) = j;
                   matches(2,matches_count) = i;    
                end
                %euclideanDist2 = sqrt(sum((double(d_ref(:,1)) -double(d_target(:,1))).^2));
        end
    end
end