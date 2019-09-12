# VisualData-project1
Analysis and Search of Visual Data.
## Project 1. 

Matlab code for SIFT and SURF keypoints extraction and descriptror matching.

### Functions
** find_matches **
find_matches - function, that find matches based on key_points distance |x-x'|<2 && |y-y'|<2   
input: keypoints_ref
** fixed_treshold **
fixed_treshold - function, that find matches between two descriptors, based on fixed threshold distance  
** point_rotation **
point_rotation - function, that take vector of points and rotate them in umage space  
** nearest_neighbour **  
nearest_neighbour - function finds nearest neighbour, based on descriptor euclidean distance and asign found point as a match, if distance betwen those two points is smaller, than certain threshold  
** nearest_neighbour_ratio **  
nearest_neighbour_ratio - function check euqlidean distance betwen all descriptors in reference and target image. Function compute ratio betwen closest and second closest distance descriptor. If ratio is belowe certain threshold (0.8 recomended), then both descriptors are marked as a match. Function return matrix of matches.
