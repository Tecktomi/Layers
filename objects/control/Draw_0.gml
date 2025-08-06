for(var c = 0; c < array_length(background); c++){
	if background[c] = undefined{
		var surf = surface_create(xsize * 16, ysize * 16)
		surface_set_target(surf)
		draw_set_color(layer_color_background[c])
		draw_rectangle(0, 0, xsize * 16, ysize * 16, false)
		draw_set_color(layer_color_recurso[c])
		for(var a = 0; a < xsize; a++)
			for(var b = 0; b < ysize; b++)
				if recurso[c][# a, b]
					draw_rectangle(a * 16, b * 16, a * 16 + 15, b * 16 + 15, false)
		background[c] = sprite_create_from_surface(surf, 0, 0, xsize * 16, ysize * 16, false, false, 0, 0)
		surface_reset_target()
		surface_free(surf)
	}
}
draw_sprite(background[current_layer], 0, 0, 0)
for(var a = 0; a < xsize; a++)
	for(var b = 0; b < ysize; b++)
		if edificio[current_layer][# a, b] != -1
			draw_sprite(edificio_sprite[edificio[current_layer][# a, b]], edificio_subsprite[current_layer][# a, b], a * 16, b * 16)
var temp_text = ""
for(var a = 0; a < array_length(recurso_nombre); a++)
	if floor(rss[a]) >= 1{
		if rss[a] >= 1000
			temp_text += $"{recurso_nombre[a]}: {floor(rss[a] / 100) / 10}K\n"
		else
			temp_text += $"{recurso_nombre[a]}: {floor(rss[a])}\n"
	}
for(var a = 0; a < ds_list_size(redes); a++){
	var red = redes[|a], edificio_count = []
	temp_text += $"Red {a}\n"
	for(var b = 0; b < array_length(recurso_nombre); b++)
		if red.produccion[b] > 0
			temp_text += $"  +{red.produccion[b]} {recurso_nombre[b]}\n"
	for(var b = 0; b < array_length(edificio_nombre); b++)
		array_push(edificio_count, 0)
	for(var b = 0; b < array_length(background); b++)
		for(var c = 0; c < ds_list_size(red.edificios[b]); c++){
			var temp_edificio = red.edificios[b][|c]
			edificio_count[edificio[b][# temp_edificio[0], temp_edificio[1]]]++
		}
	for(var b = 0; b < array_length(edificio_nombre); b++)
		if edificio_count[b] > 0
			temp_text += $"  {edificio_nombre[b]}: {edificio_count[b]}\n"
	if red.base for(var b = 0; b < array_length(recurso_nombre); b++)
		rss[b] += red.produccion[b] / 300
}
draw_set_color(c_black)
draw_text(0, 0, temp_text)
if keyboard_check_pressed(vk_up)
	current_layer = min(current_layer + 1, array_length(background) - 1)
if keyboard_check_pressed(vk_down)
	current_layer = max(current_layer - 1, 0)
if keyboard_check_pressed(ord(1))
	build_select = 1
if keyboard_check_pressed(ord(2))
	build_select = 2
if build_select > 0{
	var mx = floor(mouse_x / 16), my = floor(mouse_y / 16)
	if mouse_check_button_pressed(mb_left){
		if in(build_select, 1){
			build_x = mx
			build_y = my
		}
		else{
			mouse_clear(mb_left)
			add_edificio(build_select, mx, my)
		}
	}
	if mouse_check_button_released(mb_left) and in(build_select, 1){
		if abs(build_x - mx) > abs(build_y - my){
			for(var a = min(build_x, mx); a <= max(build_x, mx); a++)
				add_edificio(build_select, a, build_y)
		}
		else for(var a = min(build_y, my); a <= max(build_y, my); a++)
			add_edificio(build_select, build_x, a)
	}
	if in(build_select, 1) and mouse_check_button(mb_left){
		if abs(build_x - mx) > abs(build_y - my){
			for(var a = min(build_x, mx); a <= max(build_x, mx); a++)
				draw_sprite(edificio_sprite[build_select], 0, a * 16, build_y * 16)
		}
		else for(var a = min(build_y, my); a <= max(build_y, my); a++)
			draw_sprite(edificio_sprite[build_select], 0, build_x * 16, a * 16)
	}
	else
		draw_sprite_ext(edificio_sprite[build_select], 0, mx * 16, my * 16, 1, 1, 0, c_white, 0.5)
	if mouse_check_button_pressed(mb_right){
		mouse_clear(mb_right)
		build_select = 0
	}
}
if keyboard_check_pressed(vk_escape){
	if build_select = 0
		game_end()
	else
		build_select = 0
}