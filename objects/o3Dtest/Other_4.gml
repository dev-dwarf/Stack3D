/// @description SPAWN INSTANCES FOR A STRESS TEST
repeat(150) {
	//with 
	instance_create_layer(irandom(room_width*2)*choose(-1,1), irandom(room_width*2)*choose(-1,1), layer, choose(oCup, oCoin, oBillboard)) //{
	//	image_angle = irandom(360);
	//	image_xscale = random_range(0.8, 1.2);
	//	image_yscale = image_xscale;
	//	image_zscale = image_xscale;
	//	x_tilt		= random_range(-90, 90);
	//	y_tilt		= random_range(-90, 90);
	//	//z			= irandom_range(0, 120);
	//}
}