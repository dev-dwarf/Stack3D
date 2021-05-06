if !surface_exists(surface) {
	surface = surface_create(64, 64);	
}

surface_set_target(surface);
draw_clear(c_dkgray);
draw_sprite(sCoin, 0, 16, 0);
surface_reset_target();
