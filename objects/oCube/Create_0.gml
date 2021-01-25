/// @description

// Inherit the parent event
event_inherited();

var vertex_buffer = create_3d_wall(64, 64, 64, sprite_index, c_white, o3Dtest.format);

with o3Dtest {
	load_other(other.sprite_index, vertex_buffer);
}