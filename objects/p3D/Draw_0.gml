/// @description draw 3d model
if (draw_buffer == noone and draw_texture == noone) reload_buffer_and_texture();
if (is_undefined(draw_buffer) or is_undefined(draw_texture)) exit;
draw_stack_self(draw_buffer, draw_texture);