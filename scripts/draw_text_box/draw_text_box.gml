function draw_text_box(x, y, text, boton = false){
	text = string_trim(text)
	if text != ""{
		var width = string_width(text), height = string_height(text), color = draw_get_color()
		draw_set_color(c_black)
		draw_set_alpha(0.5)
		draw_rectangle(x, y, x + width + 8, y + height + 8, false)
		draw_set_alpha(1)
		draw_rectangle(x, y, x + width + 8, y + height + 8, true)
		draw_set_color(c_white)
		draw_text(x + 4, y + 4, text)
		draw_set_color(color)
		if boton and mouse_x > x and mouse_y > y and mouse_x < x + width + 8 and mouse_y < y + height + 8{
			control.cursor = cr_handpoint
			if mouse_check_button_pressed(mb_left){
				mouse_clear(mb_left)
				return true
			}
		}
	}
	return false
}