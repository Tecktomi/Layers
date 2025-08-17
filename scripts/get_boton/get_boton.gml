function get_boton(x1, y1, text){
	var width = string_width(text), height = string_height(text)
	draw_rectangle(x1 - width / 2 - 4, y1, x1 + width / 2 + 4, y1 + height + 8, false)
	draw_set_color(c_black)
	draw_rectangle(x1 - width / 2 - 4, y1, x1 + width / 2 + 4, y1 + height + 8, true)
	draw_text(x1, y1 + 4, text)
	if mouse_x > x1 - width / 2 and mouse_y > y1 and mouse_x < x1 + width / 2 and mouse_y < y1 + height + 8{
		control.cursor = cr_handpoint
		if mouse_check_button_pressed(mb_left){
			mouse_clear(mb_left)
			return true
		}
	}
	return false
}