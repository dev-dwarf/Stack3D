/// @description do depth sorting
//if (!ds_exists(depth_grid, ds_type_grid)) exit;

//// loop through all the instances

//for (var i = 0; i < ds_grid_height(depth_grid); i++) {
//	var inst = depth_grid[# 0, i];
	
//	if (is_undefined(inst) or !instance_exists(inst)) { // remove invalid entries from the list
//		ds_grid_delete_row(depth_grid, i);
//		continue;
//	}
	
//	var new_depth = compute_3d_depth(inst.x, inst.y, inst.z);
	
//	depth_grid[# 1, i] = new_depth;
//}

//ds_grid_sort(depth_grid, 1, false); // sort grid, so that instances are draw in the correct order

// switch drawing mode
for (var i = 0; i < 9; i++) {
	if (keyboard_check_pressed(ord(string(i)))) {
		shader_mode = i;
	}
}