/// @description

// Inherit the parent event
event_inherited();

wall_faces = [0, 0, 1, 0] // useful for leaving out certain faces
image_xscale = 3; // useful for setting size of areas
image_yscale = 3;
var vertex_buffer = create_3d_wall_no_top(64, 64, 64, sprite_index, c_white, o3Dtest.format, wall_faces);

draw_metadata = string(wall_faces);

with o3Dtest {
	load_other(other.sprite_index, vertex_buffer, other.draw_metadata);
}