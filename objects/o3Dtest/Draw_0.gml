/// @description draw 3d models
#region Old Drawing method
	//// make sure you draw the models using a shader
	//switch shader_mode {
	//	default: case 0:
	//	shader_set(shdStack);
	//	break;
	//	case 1: // wobble
	//	shader_set(shdWobble);
	//	shader_set_uniform_f(wobble_time, current_time * 0.01);
	//	shader_set_uniform_f(wobble_intensity, 0.1);
	//	break;
	//	case 2: // phase
	//	shader_set(shdPhase);
	//	shader_set_uniform_f(phase_time, current_time * 0.01);
	//	break;
	//	case 3: // rainbow
	//	shader_set(shdRainbow);
	//	shader_set_uniform_f(rainbow_time, current_time * 0.01);
	//	break;
	//	case 4: // distort
	//	shader_set(shdDistort);
	//	shader_set_uniform_f(distort_time, current_time * 0.01);
	//	shader_set_uniform_f(distort_intensity, 0.01);
	//	break;
	//	case 5: // wave
	//	shader_set(shdWave);
	//	shader_set_uniform_f(wave_time, current_time * 0.01);
	//	shader_set_uniform_f(wave_intensity, 0.1);
	//	break;
	//}


	//with pDepth {
	//	event_perform(ev_draw, 0);
	//}
	
	// shader_reset();
#endregion

var cameraProj = matrix_get(matrix_projection),
	cameraView = matrix_get(matrix_view);

if (!surface_exists(surfShadowMap))
	surfShadowMap = surface_create(
		LIGHT_SIZE * 2, LIGHT_SIZE * 2);

gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
	
	surface_set_target(surfShadowMap);
		
		matrix_set(matrix_projection, lightProjMat);
		matrix_set(matrix_view, lightViewMat);
		
		shader_set(shd_shadow_mapping);
			shader_set_uniform_f_array(smap_LightForward,  lightForward);
			shader_set_uniform_f_array(smap_LightPosition, lightPosition);
			shader_set_uniform_f(      smap_LightLenght,   LIGHT_LENGTH);
			
			draw_clear(c_white);
			with (pDepth) event_perform(ev_draw, 0);
			
		shader_reset();
		
	surface_reset_target();
	
	matrix_set(matrix_projection, cameraProj);
	matrix_set(matrix_view, cameraView);
	
	shader_set(shd_directional_lighting);
		shader_set_uniform_f_array(dirl_LightForward,  lightForward);
		shader_set_uniform_f_array(dirl_LightRight,    lightRight);
		shader_set_uniform_f_array(dirl_LightUp,       lightUp);
		shader_set_uniform_f_array(dirl_LightPosition, lightPosition);
		shader_set_uniform_f(      dirl_LightSize,     LIGHT_SIZE);
		shader_set_uniform_f(      dirl_LightLenght,   LIGHT_LENGTH);
		var texShadowMap = surface_get_texture(surfShadowMap);
		texture_set_stage(         dirl_ShadowMap,     texShadowMap);

		with (pDepth) event_perform(ev_draw, 0);

	shader_reset();

gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);

matrix_set(matrix_world, matrix_build_identity());

// IMPORTANT! reset world matrix and shader for other drawing
matrix_set(matrix_world, matrix_build_identity());