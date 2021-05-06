// important, put this at the top of every child of p3D's draw event
if (!draw_can_draw) exit;
x = lerp(x, get_projected_mouse_x(), 0.9);
y = lerp(y, get_projected_mouse_y(), 0.9);

draw_billboard_self();