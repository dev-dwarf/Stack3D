#region -------------------------- Macros 

	#macro X 0
	#macro Y 1
	#macro Z 2
	#macro U 0
	#macro V 1
	
#endregion
#region -------------------------- Math functions

	function normalize(vec){
		#region About
			///@param vector3
			
			/*
				This function normalizes a vector3
			*/
			
		#endregion
		
		var vx = vec[X], vy = vec[Y], vz = vec[Z];
		mag = sqrt(vx*vx + vy*vy + vz*vz);
		vec[@ X] = vx / mag;
		vec[@ Y] = vy / mag;
		vec[@ Z] = vz / mag;
		
	}
	function cross_product(a, b, result){
		#region About
			///@param vector a
			///@param vector b
			///@param vector result
			
			/*
				This function will create the cross product of 2 vectors for the resulting vector
			*/
		#endregion
		
		var ax=a[X], ay=a[Y], az=a[Z],
		bx=b[X], by=b[Y], bz=b[Z];
		
		result[@X] = ay * bz - az * by;
		result[@Y] = az * bx - ax * bz;
		result[@Z] = ax * by - ay * bx;
	}

#endregion
#region -------------------------- Vertex functions

	function create_vertex_format() {
		#region About
	
			/*		create vertex format

			creates a basic vertex format for use by the GPU

			*/
	
		#endregion
	
		vertex_format_begin();
	
		vertex_format_add_position_3d();	// Add 3D position info
		vertex_format_add_color();			// Color info
		vertex_format_add_texcoord();		// Texture coordinate info
	
		// Return the format
		return vertex_format_end();
	}
	function vertex_triangle_color(_vBuff, _color, _alpha, p1, p2, p3, tex1, tex2, tex3) {
		#region About
			///@param vertex_buffer
			///@param color
			///@param alpha
			///@param point1_array
			///@param point2_array
			///@param point3_array
			///@param texture1_array
			///@param texture2_array
			///@param texture3_array
			
			/*
				This function will create a vertex triangle at the designated points with the 
				designated texture coordinates			
			*/
			
		#endregion
		vertex_position_3d(_vBuff, p1[X],     p1[Y],     p1[Z]);
		vertex_color(      _vBuff, _color,     _alpha);
		vertex_texcoord(   _vBuff, tex1[U],         tex1[V]);
		
		vertex_position_3d(_vBuff, p2[X],     p2[Y],     p2[Z]);
		vertex_color(      _vBuff, _color,     _alpha);
		vertex_texcoord(   _vBuff, tex2[U],         tex2[V]);
		
		vertex_position_3d(_vBuff, p3[X],     p3[Y],     p3[Z]);
		vertex_color(      _vBuff, _color,     _alpha);
		vertex_texcoord(   _vBuff, tex3[U],         tex3[V]);
		}

#endregion
#region -------------------------- Draw functions

	function load_stack_sprite(sprite_index, layer_count, vertex_format, fidelity) {
		#region About
		
			/*			load_stack_sprite

			loads a sprite stack model into memory

			sprite_index	--> sprite to use, (assumed to be just 1 image, no subimages)
			sprite_texture  --> texture of the sprite index. you will need this later to draw the model, 
								so it's better to fetch outside this function
			layer_count		--> the number of z-layers in the model
			vertex_format	--> previously made vertex format
			fidelity		--> the amount of repeated layers to create. (improves appearance of scaling and rotation)
		
			*/
		
		#endregion
	
		// create the buffer
		var vertex_buffer = vertex_create_buffer();
	
		// get the texture and its UVs, so that we can build the model
		var uvs = sprite_get_uvs(sprite_index, 0);
	
		show_debug_message(string(uvs));

		// begin construction of the model
		vertex_begin(vertex_buffer, vertex_format);

		var layer_size = 1/layer_count;
		var z_step = 1/fidelity;
	
		// width and height of any given layer
		var w = sprite_get_width(sprite_index)/2;
		var h = (sprite_get_height(sprite_index)/layer_count)/2;
	
		for (var i = 0; i < layer_count; i += z_step) {
			var texture_frame = floor(layer_count-i-1);
			var z_scale = 1;
		
			// tilt the planes to enhance the 3d effect somewhat
			var offsets = array_create(4, 0);
			if fidelity >= 4 {
				offsets[(i * fidelity mod 4)] = 1/2;
				offsets[((i * fidelity + 2) mod 4)] = 1/2;
			}
		
			#region About drawing triangles
				// _____	constructing 1st triangle
				// \   |
				//  \  |
				//   \ |
				//    \|
			
				// |\		constructing 2nd triangle
				// | \
				// |  \
				// |___\
		
				/*
					each triangle is made up of 3 points, which each have a position,
					color, and texcoord with the given format.
			
					texcoord y position is calculated as the coordinate of the top of the img, plus
					the amount of frames so far. texture_frame is floored so that duplicated layers
					do not end up drawing middle portions of the image.
				*/
			#endregion
		
			// First triangle
			vertex_triangle_color(vertex_buffer, c_white, 1.0,
				[-w, -h, -i*z_scale + offsets[0]],
				[w, -h, -i*z_scale + offsets[1]],
				[w, h, -i*z_scale + offsets[2]],
				[uvs[0], uvs[1] + (uvs[3]-uvs[1])*texture_frame*layer_size],
				[uvs[2], uvs[1] + (uvs[3]-uvs[1])*texture_frame*layer_size],
				[uvs[2], uvs[1] + (uvs[3]-uvs[1])*(texture_frame+1)*layer_size]
			);
		
			// Second triangle
			vertex_triangle_color(vertex_buffer, c_white, 1.0,
				[-w, -h, -i*z_scale + offsets[0]],
				[-w, h, -i*z_scale + offsets[3]],
				[w, h, -i*z_scale + offsets[2]],
				[uvs[0], uvs[1] + (uvs[3]-uvs[1])*texture_frame*layer_size],
				[uvs[0], uvs[1] + (uvs[3]-uvs[1])*(texture_frame+1)*layer_size],
				[uvs[2], uvs[1] + (uvs[3]-uvs[1])*(texture_frame+1)*layer_size]
			);
		
		}

		// end construction of the model
		vertex_end(vertex_buffer);
	
		return vertex_buffer;
	}
	function draw_stack_self(vertex_buffer, texture) {
		#region About
		
			/*			draw stack self 

			draws a the instances stack sprite model (ONLY USE IN DRAW EVENTS)

			important notes: 
			1. you will have to manually reset the world matrix after drawing. Look at o3Dtest for an example.
			2. the instance calling this needs a few variables built into it (z, x_tilt, y_tilt, image_zscale)

			vertex_buffer	--> the vertex buffer containing the 3d model to draw
			texture			--> the texture to apply to the model

			*/
		
		#endregion
		
		var inst_matrix = matrix_build( x, y, -z, x_tilt, y_tilt, image_angle, image_xscale, image_yscale, image_zscale);
		matrix_set(matrix_world, inst_matrix);
		vertex_submit(vertex_buffer, pr_trianglelist, texture);
	}
	function draw_stack_sprite_ext(vertex_buffer, texture, x, y, z, x_angle, y_angle, z_angle, x_scale, y_scale, z_scale) {
		#region About
	
			/*		draw stack sprite ext

			draws a stack sprite model (ONLY USE IN DRAW EVENTS)

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

			*/
		#endregion
		
		var inst_matrix = matrix_build( x, y, -z, x_angle, y_angle, z_angle, x_scale, y_scale, z_scale);
		matrix_set(matrix_world, inst_matrix);
		vertex_submit(vertex_buffer, pr_trianglelist, texture);
	}
	function draw_billboard_self() {
		#region About
			/*		 draw billboard self 

			draws a billboarded sprite

			important notes: 
			1. you will have to manually reset the world matrix after drawing. Look at o3Dtest for an example.
		
			*/
		#endregion
		
		var inst_matrix = matrix_build( x, y, -z, x_tilt, y_tilt, 0, 1.0, 1.0, image_zscale);
		matrix_set(matrix_world, matrix_multiply(oCamera.billboard_matrix, inst_matrix));
		draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, 0, image_blend, image_alpha);
	}
	function draw_billboard_ext(sprite_index, image_index, x, y, z, x_tilt, y_tilt, angle, image_xscale, image_yscale, image_zscale, image_blend, image_alpha) {
		#region About
			/*			 draw billboard ext

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
		
			*/
		#endregion
	
		var inst_matrix = matrix_build( x, y, -z, x_tilt, y_tilt, 0, 1.0, 1.0, image_zscale);
		matrix_set(matrix_world, matrix_multiply(oCamera.billboard_matrix, inst_matrix));
		draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, 0, image_blend, image_alpha);
	}
	function draw_normal_self() {
		#region About
			/*		 draw normal self

			draws a "normal" sprite

			important notes: 
			1. you will have to manually reset the world matrix after drawing. Look at o3Dtest for an example.
			
			*/
		#endregion
		
		var inst_matrix = matrix_build( x, y, -z, x_tilt, y_tilt, 0, 1.0, 1.0, image_zscale);
		matrix_set(matrix_world, inst_matrix);
		draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, 0, image_blend, image_alpha);
	}
	function draw_normal_ext(sprite_index, image_index, x, y, z, x_tilt, y_tilt, angle, image_xscale, image_yscale, image_zscale, image_blend, image_alpha) {
		#region About
			
			/*			 draw normal ext 

			draws a "normal" sprite

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
			
			*/
		#endregion
		
		var inst_matrix = matrix_build( x, y, -z, x_tilt, y_tilt, 0, 1.0, 1.0, image_zscale);
		matrix_set(matrix_world, inst_matrix);
		draw_sprite_ext(sprite_index, image_index, 0, 0, image_xscale, image_yscale, 0, image_blend, image_alpha);
	}

#endregion
#region -------------------------- Mouse functions


	function get_projected_mouse_x() {
		#region About
			/*   get_projected_mouse_x 

			Gets the projected x position of the mouse in 3d space. This value is calculated in oCamera's Draw Begin Event

			*/
		#endregion
		return oCamera.projected_mouse_x;
	}
	function get_projected_mouse_y() {
		#region About
		/*			get_projected_mouse_y 

		Gets the projected y position of the mouse in 3d space. This value is calculated in oCamera's Draw Begin Event

		*/
		#endregion
		return oCamera.projected_mouse_y;
	}
	
#endregion