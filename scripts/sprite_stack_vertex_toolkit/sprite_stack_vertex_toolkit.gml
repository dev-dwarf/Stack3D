/*######### create vertex format ##########\\

creates a basic vertex format for use by the GPU

\\#######################################*/
function create_vertex_format() {
	vertex_format_begin();
	
	vertex_format_add_position_3d();	// Add 3D position info
	vertex_format_add_color();
	vertex_format_add_texcoord();		// Texture coordinate info
	
	// Return the format
	return vertex_format_end();
}


/*######### load stacked sprite #########\\

loads a sprite stacked model into memory

sprite_index	--> sprite to use, (assumed to be just 1 image, no subimages)
sprite_texture  --> texture of the sprite index. you will need this later to draw the model, 
					so it's better to fetch outside this function
layer_count		--> the number of z-layers in the model
vertex_format	--> previously made vertex format
fidelity		--> the amount of repeated layers to create. (improves appearance of scaling and rotation)
\\#######################################*/

function load_stacked_sprite(sprite_index, layer_count, vertex_format, fidelity) {
	
	// create the buffer
	var vertex_buffer = vertex_create_buffer();
	
	// get the texture and its UVs, so that we can build the model
	var uvs = sprite_get_uvs(sprite_index, 0);
	
	show_debug_message(string(uvs));

	// begin construction of the model
	vertex_begin(vertex_buffer, vertex_format);

	var layer_size = 1/layer_count;
	
	// width and height of any given layer
	var w = sprite_get_width(sprite_index)/2;
	var h = (sprite_get_height(sprite_index)/layer_count)/2;
	
	for (var i = 0; i < layer_count; i += 1/fidelity) {
		var texture_frame = floor(layer_count-i-1);
		var z_scale = 1;
		
		// _____	construct 1st triangle
		// \   |
		//  \  |
		//   \ |
		//    \|
		#region first triangle
		/*
			each triangle is made up of 3 points, which each have a position,
			color, and texcoord with the given format.
		*/
		vertex_position_3d(vertex_buffer, -w, -h, -i*z_scale);
		vertex_color(vertex_buffer, c_white, 1.0);
		
		/* 
			texcoord y position is calculated as the coordinate of the top of the img, plus
			the amount of frames so far. texture_frame is floored so that duplicated layers
			do not end up drawing middle portions of the image.
		*/
		vertex_texcoord(vertex_buffer, uvs[0], uvs[1] + (uvs[3]-uvs[1])*texture_frame*layer_size);

		vertex_position_3d(vertex_buffer, w, -h, -i*z_scale);
		vertex_color(vertex_buffer, c_white, 1.0);
		vertex_texcoord(vertex_buffer, uvs[2], uvs[1] + (uvs[3]-uvs[1])*texture_frame*layer_size);
	
		vertex_position_3d(vertex_buffer, w, h, -i*z_scale);
		vertex_color(vertex_buffer, c_white, 1.0);
		vertex_texcoord(vertex_buffer, uvs[2], uvs[1] + (uvs[3]-uvs[1])*(texture_frame+1)*layer_size);
		#endregion
	
		// |\		construct 2nd triangle
		// | \
		// |  \
		// |___\

		#region second triangle
		vertex_position_3d(vertex_buffer, -w, -h, -i*z_scale);
		vertex_color(vertex_buffer, c_white, 1.0);
		vertex_texcoord(vertex_buffer, uvs[0], uvs[1] + (uvs[3]-uvs[1])*texture_frame*layer_size);

		vertex_position_3d(vertex_buffer, -w, h, -i*z_scale);
		vertex_color(vertex_buffer, c_white, 1.0);
		vertex_texcoord(vertex_buffer, uvs[0], uvs[1] + (uvs[3]-uvs[1])*(texture_frame+1)*layer_size);

		vertex_position_3d(vertex_buffer, w, h, -i*z_scale);
		vertex_color(vertex_buffer, c_white, 1.0);
		vertex_texcoord(vertex_buffer, uvs[2], uvs[1] + (uvs[3]-uvs[1])*(texture_frame+1)*layer_size);
		#endregion

	}

	// end construction of the model
	vertex_end(vertex_buffer);
	
	return vertex_buffer;
}
	
	
/*######### draw stacked self #########\\

draws a the instances stacked sprite model (ONLY USE IN DRAW EVENTS)

important notes: 
1. you will have to manually reset the world matrix after drawing. Look at o3Dtest for an example.
2. the instance calling this needs a few variables built into it (z, x_tilt, y_tilt, image_zscale)

vertex_buffer	--> the vertex buffer containing the 3d model to draw
texture			--> the texture to apply to the model

\\#######################################*/
function draw_stacked_self(vertex_buffer, texture) {
	// builds a matrix that accounts for the objects position, angle(s), and scale
	var inst_matrix = matrix_build( x, y, z, x_tilt, y_tilt, image_angle, image_xscale, image_yscale, image_zscale);
	
	// sets the world matrix to this matrix
	matrix_set(matrix_world, inst_matrix);

	// submits the model to the gpu for drawing
	vertex_submit(vertex_buffer, pr_trianglelist, texture);
}
	

/*######### draw stacked sprite ext #########\\

draws a stacked sprite model (ONLY USE IN DRAW EVENTS)

important notes: 
1. you will have to manually reset the world matrix after drawing. Look at o3Dtest for an example.

vertex_buffer	--> the vertex buffer containing the 3d model to draw
texture			--> the texture to apply to the model
x				--> x coord to draw at
y				--> y coord to draw at
z				--> z coord to draw at
x_angle			--> x angle to tilt the model
y_angle			--> y angle to tilt the model
z_angle			--> z angle (used in a similar way to image_angle in 2d games)
x_scale			--> scale to apply along x axis of model
y_scale			--> scale to apply along y axis of model
z_scale			--> scale to apply along z axis of model

\\#######################################*/
function draw_stacked_sprite_ext(vertex_buffer, texture, x, y, z, x_angle, y_angle, z_angle, x_scale, y_scale, z_scale) {
	// builds a matrix that accounts for the passed-in position, angle(s), and scale
	var inst_matrix = matrix_build( x, y, z, x_angle, y_angle, z_angle, x_scale, y_scale, z_scale);
	
	// sets the world matrix to this matrix
	matrix_set(matrix_world, inst_matrix);

	// submits the model to the gpu for drawing
	vertex_submit(vertex_buffer, pr_trianglelist, texture);
}

/*######### draw billboard self #########\\

draws a billboarded sprite

important notes: 
1. you will have to manually reset the world matrix after drawing. Look at o3Dtest for an example.
\\#######################################*/
function draw_billboard_self() {
	var inst_matrix = matrix_build( x, y, z, x_tilt, y_tilt, 0, image_xscale, image_yscale, image_zscale);
	
	matrix_set(matrix_world, matrix_multiply(oCamera.billboard_matrix, inst_matrix));
	
	draw_sprite_ext(sprite_index, image_index, 0, 0, 1.0, 1.0, 0, image_blend, image_alpha);
}

/*######### draw billboard ext #########\\

draws a billboarded sprite

important notes: 
1. you will have to manually reset the world matrix after drawing. Look at o3Dtest for an example.

sprite_index	--> sprite to use
image_index		--> image to use
x				--> x coord to draw at
y				--> y coord to draw at
z				--> z coord to draw at
x_tilt			--> x angle to tilt the model
y_tilt			--> y angle to tilt the model
angle			--> z angle (used in a similar way to image_angle in 2d games)
image_xscale	--> scale to apply along x axis of model
image_yscale	--> scale to apply along y axis of model
image_zscale	--> scale to apply along z axis of model
image_blend		--> image_blend of the sprite
image_alpha		--> image_alpha of the sprite
\\#######################################*/
function draw_billboard_ext(sprite_index, image_index, x, y, z, x_tilt, y_tilt, angle, image_xscale, image_yscale, image_zscale, image_blend, image_alpha) {
	var inst_matrix = matrix_build( x, y, z, x_tilt, y_tilt, 0, image_xscale, image_yscale, image_zscale);
	
	matrix_set(matrix_world, matrix_multiply(oCamera.billboard_matrix, inst_matrix));
	
	draw_sprite_ext(sprite_index, image_index, 0, 0, 1.0, 1.0, 0, image_blend, image_alpha);
}