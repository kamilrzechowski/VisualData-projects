function rotated_keypoints = point_rotation(key_point_vector, angle, img_size_unrotated, img_size_roatated)
    %compute point coordinates after roatation, in image space
    %key_point_vector(1,:) - x coordinate in image space
    %key_point_vector(2,:) - y coordinate in image space
    %key_point_vector(:,i) - i-th point
    
    dim2 = size(key_point_vector,2);
    for feature = 1:dim2
        org_point = key_point_vector(1:2,feature); % arbitrarily selected
        %shift point to the center
        Xshift = org_point(1) - (img_size_unrotated(2)/2);
        Yshift = -(org_point(2) - (img_size_unrotated(1)/2));
        %rotatate point
        rotpoint = zeros(2);
        rotpoint(1) =  Xshift*cosd(-angle) + Yshift*sind(-angle);
        rotpoint(2) = -Xshift*sind(-angle) + Yshift*cosd(-angle);
        %shift point back
        rotated_keypoints(1,feature) = rotpoint(1) + (img_size_roatated(2)/2);
        rotated_keypoints(2,feature) = (img_size_roatated(1)/2) - rotpoint(2);
        %plot(translated_featureSurf(1,feature),translated_featureSurf(2,feature),'-s');
    end
end