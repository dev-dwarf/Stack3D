/// @description build camera matrices


// creates a matrix, focused at (0,0,0), with the correct inclined angle for sprite stacking
var view_matrix = matrix_build_lookat( 0, z_distance*dsin(incline_angle), -z_distance*dcos(incline_angle), 0, 0, 0, 0, 1, 0);

// creates a rotation matrix and applies it to the view_matrix,
// to adjust the camera angle. this is equivalent to camera_set_view_angle(view_camera[0], camera_angle) in normal games
var rotation_matrix = matrix_build(0, 0, 0, 0, 0, camera_angle, 1, 1, 1);
view_matrix = matrix_multiply(rotation_matrix, view_matrix);

// create a translation matrix and applies it to the view_matrix.
// This moves the position of the view to the camera object.
var translation_matrix = matrix_build(-x, -y, 0, 0, 0, 0, 1, 1, 1);
view_matrix = matrix_multiply(translation_matrix, view_matrix);

// creates the projection matrix, and applies the zoom level to it.
var proj_matrix = matrix_build_projection_ortho(256/camera_zoom, 144/camera_zoom, 1.0, 32000.0);

camera_set_view_mat(camera, view_matrix);
camera_set_proj_mat(camera, proj_matrix);
camera_apply(camera);

// build matrix for billboarding

// for cylindrical billboarding -- i prefered this, with a slight tilt, so that the billboarded sprites are still somewhat affected by the camera angle
var tilt_matrix = matrix_build(0, 0, 0, -45, 0, -camera_angle, 1.0, 1.0, 1.0);

// for spherical billboarding uncomment
//var tilt_matrix = matrix_build(0, 0, 0, -incline_angle, 0, -camera_angle, 1.0, 1.0, 1.0);

billboard_matrix = tilt_matrix;
