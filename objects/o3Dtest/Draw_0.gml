/// @description draw 3d models

// make sure you draw the models using a shader
switch shader_mode {
	default: case 0:
	shader_set(shdStack);
	break;
	case 1: // wobble
	shader_set(shdWobble);
	shader_set_uniform_f(wobble_time, current_time * 0.01);
	shader_set_uniform_f(wobble_intensity, 0.1);
	break;
	case 2: // phase
	shader_set(shdPhase);
	shader_set_uniform_f(phase_time, current_time * 0.01);
	break;
	case 3: // rainbow
	shader_set(shdRainbow);
	shader_set_uniform_f(rainbow_time, current_time * 0.01);
	break;
	case 4: // distort
	shader_set(shdDistort);
	shader_set_uniform_f(distort_time, current_time * 0.01);
	shader_set_uniform_f(distort_intensity, 0.01);
	break;
	case 5: // wave
	shader_set(shdWave);
	shader_set_uniform_f(wave_time, current_time * 0.01);
	shader_set_uniform_f(wave_intensity, 0.1);
	break;
}


with pDepth {
	event_perform(ev_draw, 0);
}
	
	shader_reset();

// IMPORTANT! reset world matrix and shader for other drawing
matrix_set(matrix_world, matrix_build_identity());