/// @description build camera matrices


// creates a matrix, focused at (0,0,0), with the correct inclined angle for sprite stacking
var view_matrix = matrix_build_lookat( 0, z_distance*dsin(incline_angle), -z_distance*dcos(incline_angle), 0, 0, 0, 0, 1, 0);

// creates a rotation matrix and applies it to the view_matrix,
// to adjust the camera angle. this is equivalent to camera_set_view_angle(view_camera[0], camera_angle) in normal games
var rotation_matrix = matrix_build(0, 0, 0, 0, 0, camera_angle, 1, 1, 1);
view_matrix = matrix_multiply(rotation_matrix, view_matrix);

// create a translation matrix and applies it to the view_matrix.
// This moves the position of the view to the camera object.
var translation_matrix = matrix_build(-x, -y, -z, 0, 0, 0, 1, 1, 1);
view_matrix = matrix_multiply(translation_matrix, view_matrix);

// creates the projection matrix, and applies the zoom level to it.
var proj_matrix = matrix_build_projection_ortho(256/camera_zoom, 144/camera_zoom, 1.0, 32000.0);

// perspective camera leads to some funky things!
//var proj_matrix = matrix_build_projection_perspective(256/camera_zoom, 144/camera_zoom, 1.0, 32000.0);
//var proj_matrix = matrix_build_projection_perspective_fov(144/camera_zoom, 16/9, 1.0, 32000.0);


camera_set_view_mat(camera, view_matrix);
camera_set_proj_mat(camera, proj_matrix);
camera_apply(camera);

// build matrix for billboarding

// for cylindrical billboarding -- i prefered this, with a slight tilt, so that the billboarded sprites are still somewhat affected by the camera angle
//var tilt_matrix = matrix_build(0, 0, 0, -45, 0, -camera_angle, 1.0, 1.0, 1.0);
var tilt_matrix = matrix_build(0, 0, 0, -90, 0, -camera_angle, 1.0, 1.0, 1.0);

// for spherical billboarding uncomment
//var tilt_matrix = matrix_build(0, 0, 0, -incline_angle, 0, -camera_angle, 1.0, 1.0, 1.0);
billboard_matrix = tilt_matrix;

#region // orthographic mouse code from flyingsaucerinvasion https://forum.yoyogames.com/index.php?threads/mouse-position-in-orthographic-3d-game.70919/
//view and projection matrices:
//position of camera:
var _cx = x;
var _cy = y;
var _cz = z;

//direction of mouse vector:  (in ortho projection, always along z axis)
var _dx = view_matrix[2];
var _dy = view_matrix[6];
var _dz = view_matrix[10];

//mouse xy position in windows's space:
var _mx = (2*window_mouse_get_x()/window_get_width() -1)/proj_matrix[0];
var _my = (2*window_mouse_get_y()/window_get_height()-1)/proj_matrix[5];

//starting point of mouse vector:
var _sx = _cx + view_matrix[0]*_mx + view_matrix[1]*_my;
var _sy = _cy + view_matrix[4]*_mx + view_matrix[5]*_my;
var _sz = _cz + view_matrix[8]*_mx + view_matrix[9]*_my;

if(_dz != 0) {    //make sure mouse vector is not parallel to ground
    var _t = _sz / - _dz;
    //x,y posiiotn of mouse vector intersection with flat plane at z = 0
    projected_mouse_x = _sx + _dx * _t;
    projected_mouse_y = _sy + _dy * _t;
}
#endregion	
