function draw_deslizante(x1, x2, y1, val_min, val_max, variable, index){
	draw_line(x1, y1, x2, y1)
	draw_circle(x1 + (x2 - x1) * (variable - val_min) / (val_max - val_min), y1, 5, false)
	if mouse_x > x1 - 5 and mouse_y > y1 - 5 and mouse_x < x2 + 5 and mouse_y < y1 + 5{
		control.cursor = cr_handpoint
		if mouse_check_button_pressed(mb_left)
			control.deslizante_index = index
	}
	if control.deslizante_index = index{
		control.cursor = cr_handpoint
		if mouse_check_button_released(mb_left)
			control.deslizante_index = 0
		return clamp(val_min + (val_max - val_min) * (mouse_x - x1) / (x2 - x1), val_min, val_max)
	}
	return variable
}