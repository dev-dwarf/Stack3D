/// @description
z = 0;

x_tilt = 0;
y_tilt = 0;

image_zscale = image_xscale;

with o3Dtest {
	if (depth_grid != -1) { // increase grid size
		var height = ds_grid_height(depth_grid);
		ds_grid_resize(depth_grid, 2, height+1);
		depth_grid[# 0, height] = other.id;
		depth_grid[# 1, height] = other.y;
		
	} else {  // if grid doesnt exist create first row
		var height = 1;
		depth_grid = ds_grid_create(2, 1);
		depth_grid[# 0, 0] = other.id;
		depth_grid[# 1, 0] = other.y;
	}		
}

visible = false; // we dont want the object drawing itself