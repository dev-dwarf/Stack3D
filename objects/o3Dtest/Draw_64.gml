// @description draw surface to screen
draw_surface_stretched(drawing_surface, 0, 0, surface_get_width(application_surface), surface_get_height(application_surface));

/// @description demo text -- ignore
draw_set_font(Font1);
draw_set_halign(fa_right);

var w = display_get_gui_width();
draw_text(w-4, 4, "Stack3D demo:");
draw_text(w-4, 24, "Use WASD to move, click and drag to rotate");