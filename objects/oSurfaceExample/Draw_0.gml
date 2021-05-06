/// @description 

if (!draw_can_draw) exit;

// draw surface in plane of 3d models
var surface_origin_x = 32;
var surface_origin_y = 32;
draw_surface_normal_ext(surface, x, y, 16 + 4*sin(current_time*0.01), surface_origin_x, surface_origin_y, 0, 0, image_angle, 1.0, 1.0, 1.0, c_white, 1.0);

// draw surface as a billboard
var surface_origin_x = 32;
var surface_origin_y = 64;
draw_surface_billboard_ext(surface, x, y, 0, surface_origin_x, surface_origin_y, 0, 0, image_angle, 1.0, 1.0, 1.0, c_white, 1.0);
