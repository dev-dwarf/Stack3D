/// @description
image_angle = -oCamera.camera_angle;


var move_dir = point_direction(0, 0, keyboard_check(ord("D"))-keyboard_check(ord("A")), keyboard_check(ord("S"))-keyboard_check(ord("W")));
var move_ = min(1, point_distance(0, 0, keyboard_check(ord("D"))-keyboard_check(ord("A")), keyboard_check(ord("S"))-keyboard_check(ord("W"))));

x += lengthdir_x(move_ * 2, move_dir+oCamera.camera_angle);
y += lengthdir_y(move_ * 2, move_dir+oCamera.camera_angle);

