/// @description Insert description here
// You can write your code in this editor
draw_billboard_self();


if (!surface_exists(test_surface)) { test_surface = surface_create(50, 50); }
surface_set_target(test_surface);
draw_clear(c_red);
surface_reset_target();

draw_surface_billboard_ext(test_surface, x, y, z, 0, 0, 0, 1.0, 1.0, 1.0, c_white, 1.0);