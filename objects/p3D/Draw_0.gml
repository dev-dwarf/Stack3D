/// @description draw 3d model

// important, put this at the top of every child of p3D's draw event
if (!draw_can_draw) exit;

if (draw_buffer == noone and draw_texture == noone) reload_buffer_and_texture();
if (is_undefined(draw_buffer) or is_undefined(draw_texture)) exit;
draw_stack_self(draw_buffer, draw_texture);