function matches = nearest_neighbour(descriptor_ref, descriptor_target, threshold)
% nearest neighbour matching
%function finds nearest neighbour, based on descriptor euclidean distance
%and asign found point as a match, if distance betwen those two points is
%smaller, than certain threshold
    %find descriptors length
    [f_num1,descriptor_length_ref] = size(descriptor_ref);
    [f_num2,descriptor_length_terget] = size(descriptor_target);

    %iterate through descriptor and find matches

    euclideanDistance = zeros(descriptor_length_ref,descriptor_length_terget);
    matches_tmp = zeros(3,descriptor_length_ref); %ref descriptor, target descriptor, distance

    position = 0;
    for j = 1:descriptor_length_ref
        nearest_neaigbour = -1;
        nearest_neaigbour_loc = -1;
        for i = 1:descriptor_length_terget
            euclideanDistance(j,i) = norm(double(descriptor_ref(:,j))-double(descriptor_target(:,i)), 2);
            if (nearest_neaigbour < 0)
                nearest_neaigbour = euclideanDistance(j,i);
                nearest_neaigbour_loc = i;
            end
            if (euclideanDistance(j,i) < nearest_neaigbour)
                nearest_neaigbour = euclideanDistance(j,i);
                nearest_neaigbour_loc = i;
            end
            %euclideanDist2 = sqrt(sum((double(d_ref(:,1)) -double(d_target(:,1))).^2));
        end
        if (nearest_neaigbour < threshold)
            position = position + 1;
            matches_tmp(1,position) = j;
            matches_tmp(2,position) = nearest_neaigbour_loc;
            matches_tmp(3,position) = nearest_neaigbour;
        end
    end
    
    matches = matches_tmp(:,1:position);
end