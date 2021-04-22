/// @description

// Inherit the parent event
event_inherited();

var skips = [0, 0, 0, 0] // useful for leaving out certain faces
image_xscale = 3; // useful for setting size of areas
image_yscale = 3;
var vertex_buffer = create_3d_wall_no_top(64, 64, 64, sprite_index, c_white, o3Dtest.format, skips);

with o3Dtest {
	load_other(other.sprite_index, vertex_buffer);
}