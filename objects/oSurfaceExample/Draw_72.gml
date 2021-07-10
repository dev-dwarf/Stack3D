if !surface_exists(surface) {
	surface = surface_create(64, 64);	
}

surface_set_target(surface);
draw_clear(c_dkgray);
draw_sprite(sCoin, 0, 16, 0);
draw_set_halign(fa_left);
draw_text( 0, 0, "this side");
draw_text_transformed( 64, 16, "up", 1.0, 1.0, -90);

surface_reset_target();
