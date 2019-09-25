function matches = find_matches(keypoints_ref, keypoints_target)
% compute mateches based on distance |x-x'|<2 && |y-y'|<2
    matches = 0;
    for feature1 = 1:size(keypoints_ref,2)
        for feature2 = 1:size(keypoints_target,2)
            if abs(keypoints_ref(1,feature1) - keypoints_target(1,feature2)) < 2 && abs(keypoints_ref(2,feature1) - keypoints_target(2,feature2)) < 2
                matches = matches + 1;
                keypoints_target(1,feature2) = 0;
                keypoints_target(2,feature2) = 0;
            end
        end
    end
end
