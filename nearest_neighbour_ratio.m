function matches = nearest_neighbour_ratio(descriptor_ref,descriptor_target)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

    %find descriptors length
    [f_num1,descriptor_length_ref] = size(descriptor_ref);
    [f_num2,descriptor_length_target] = size(descriptor_target);
    euclideanDistance = zeros(descriptor_length_ref,descriptor_length_target);

    matches_tmp  = zeros(2,descriptor_length_ref);
    matches_counter = 0;
    for j = 1:descriptor_length_ref
        nearest_neigbour = -1;
        second_nearest_neighbour = -1;
        nearest_neaigbour_loc = -1;
        second_nearest_neighbour_loc = -1;
        for i = 1:descriptor_length_target
            euclideanDistance(j,i) = norm(double(descriptor_ref(:,j))-double(descriptor_target(:,i)), 2);
            if (nearest_neigbour < 0)
                nearest_neigbour = euclideanDistance(j,i);
                nearest_neaigbour_loc = i;
                second_nearest_neighbour = euclideanDistance(j,i);
                second_nearest_neighbour_loc = i;
            end
            if (euclideanDistance(j,i) < nearest_neigbour)
                nearest_neigbour = euclideanDistance(j,i);
                nearest_neaigbour_loc = i;
            elseif (euclideanDistance(j,i) < second_nearest_neighbour)
                second_nearest_neighbour = euclideanDistance(j,i);
                second_nearest_neighbour_loc = i;
            end
        end
        ratio = nearest_neigbour/second_nearest_neighbour;
        if ratio < 0.8  % match found 
            matches_counter = matches_counter + 1;
            matches_tmp(1,matches_counter) = j;
            matches_tmp(2,matches_counter) = nearest_neaigbour_loc;
        end
    end
    matches = matches_tmp(:,1:matches_counter);
end

