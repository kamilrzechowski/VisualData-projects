# VisualData-project1
Analysis and Search of Visual Data.
## Project 1. 

Matlab code for SIFT and SURF keypoints extraction and descriptror matching.

### Functions
**find_matches.m**  
find_matches - function, that find matches based on key_points distance |x-x'|<2 && |y-y'|<2   
input: keypoints_ref    
**fixed_treshold.m**  
fixed_treshold - function, that finds matches between two descriptors, based on fixed threshold distance    
**point_rotation.m**  
point_rotation - function, that takes vector of points and rotate them in umage space    
**nearest_neighbour.m**  
nearest_neighbour - function finds nearest neighbour, based on descriptor euclidean distance and asign found point as a match, if distance betwen those two points is smaller, than certain threshold    
**nearest_neighbour_ratio.m**  
nearest_neighbour_ratio - function checks euqlidean distance betwen all descriptors in reference and target image. Function compute ratio betwen closest and second closest distance descriptor. If ratio is belowe certain threshold (0.8 recomended), then both descriptors are marked as a match. Function return matrix of matches.
  
  
### Procedures
**Point3.m**  
Point3 - it's point 3 (task 3) from project descripton. Procedure compute fixed_treshold, nearest_neighbour and nearest_neighbour_ratio for SIFT algorithm.
