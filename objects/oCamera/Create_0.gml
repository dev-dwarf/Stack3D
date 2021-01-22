/// @description
default_camera_width  = 256;
default_camera_height = 144;

camera_angle = 0;
camera_speed = 0.1;
camera_zoom  = 1; // zoom level

// recommend tweaking this
z_distance = 1000;

// set up gpu
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
// leads to an interesting glitchy effect
//gpu_set_cullmode(cull_counterclockwise)

// another interesting technique that really highlights the voxels in the models
//gpu_set_tex_filter(true)

// tilt from z axis, where a value of 0 would be directly top down.
incline_angle = 45;
incline_minimum = 15;
incline_maximum = 75;

camera_width  = default_camera_width ;
camera_height = default_camera_height;

billboard_matrix = -1;

camera = view_camera[0];

// ENSURE PIXEL PERFECT
surface_resize(application_surface, camera_width*2, camera_height*2);