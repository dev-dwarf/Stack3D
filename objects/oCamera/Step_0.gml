/// @description

image_angle = -camera_angle;
image_alpha = distance_to_object(oPlayer)/200;

#region debug controls, ignore
camera_angle += (keyboard_check(vk_right) - keyboard_check(vk_left));
camera_angle = camera_angle mod 360

incline_angle -= 2 * (keyboard_check(vk_up) - keyboard_check(vk_down));
incline_angle = clamp(incline_angle, incline_minimum, incline_maximum);

camera_zoom += 0.1 * (mouse_wheel_up() - mouse_wheel_down());
camera_zoom = clamp(camera_zoom, 0.5, 3);
#endregion

x = lerp(x, oPlayer.x, camera_speed);
y = lerp(y, oPlayer.y, camera_speed);
