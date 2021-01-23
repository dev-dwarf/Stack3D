// switch drawing mode
for (var i = 0; i < 9; i++) {
	if (keyboard_check_pressed(ord(string(i)))) {
		shader_mode = i;
	}
}

// Light settings
#region Move light

	lightHor += 2 * (
	keyboard_check(vk_right) -
	keyboard_check(vk_left));
	lightVer -= 2 * (
		keyboard_check(vk_up) -
		keyboard_check(vk_down));
	lightVer = clamp(lightVer, -80, 80);
	
#endregion

var dis = lengthdir_x(lightDist, lightVer),
	lx  = lengthdir_y(dis, lightHor),
	ly  = lengthdir_y(lightDist, lightVer),
	lz  = lengthdir_x(dis, lightHor);

set_light(
	[-lx, -ly, -lz],
	[ 0, 0, 0 ],
	[ 0, -1, 0 ]);