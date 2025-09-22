function get_boton(x1, y1, text){
	var width = string_width(text), height = string_height(text), color = draw_get_color(), halign = draw_get_halign()
	var desface = width / 2 * (halign = fa_right ? -2 : (halign = fa_center ? -1 : 0)), valign = draw_get_valign()
	var desface_y = height / 2 * (valign = fa_bottom ? -2 : (valign = fa_middle ? -1 : 0))
	draw_rectangle(x1 + desface - 4, y1 + desface_y - 4, x1 + desface + width + 4, y1 + desface_y + height + 4, false)
	draw_set_color(c_black)
	draw_rectangle(x1 + desface - 4, y1 + desface_y - 4, x1 + desface + width + 4, y1 + desface_y + height + 4, true)
	draw_text(x1, y1 + 4, text)
	draw_set_color(color)
	if mouse_x > x1 + desface and mouse_y > y1 + desface_y - 4 and mouse_x < x1 + desface + width and mouse_y < y1 + desface_y + height + 4{
		control.cursor = cr_handpoint
		if mouse_check_button_pressed(mb_left){
			mouse_clear(mb_left)
			return true
		}
	}
	return false
}