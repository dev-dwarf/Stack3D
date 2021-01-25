// switch drawing mode -- ignore
for (var i = 0; i < 9; i++) {
	if (keyboard_check_pressed(ord(string(i)))) {
		shader_mode = i;
	}
}
