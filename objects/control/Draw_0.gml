//Actualizar fondo
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
//Dibujo de edificios y micelio
for(var a = 0; a < xsize; a++)
	for(var b = 0; b < ysize; b++){
		if bool_edificio[current_layer][# a, b]{
			var edificio = id_edificio[current_layer][# a, b]
			draw_sprite(edificio_sprite[edificio.index], edificio.subsprite, a * 16, b * 16)
			if in(edificio.index, 1, 2, 3, 4, 5, 6, 7)
				draw_sprite_ext(spr_camino_color, edificio.subsprite, a * 16, b * 16, 1, 1, 0, recurso_color[edificio.index - 1], 1)
		}
		else if micelio[current_layer][# a, b] = 1
			draw_sprite(spr_micelio_1, micelio_subsprite[current_layer][# a, b], a * 16, b * 16)
		else if micelio[current_layer][# a, b] = 2
			draw_sprite(spr_micelio_2, 0, a * 16, b * 16)
	}
//Mostrar recursos
var temp_text = ""
for(var a = 0; a < array_length(recurso_nombre); a++)
	if floor(rss[a]) >= 1{
		if rss[a] >= 1000
			temp_text += $"{recurso_nombre[a]}: {floor(rss[a] / 100) / 10}K\n"
		else
			temp_text += $"{recurso_nombre[a]}: {floor(rss[a])}\n"
	}
//Función de redes
for(var a = 0; a < ds_list_size(redes); a++){
	var red = redes[|a]
	if red.base
		rss[red.recurso] += max(red.recurso_produccion - red.recurso_consumo, 0) / 300
}
var mx = floor(mouse_x / 16), my = floor(mouse_y / 16)
//Información previa de red
if bool_edificio[current_layer][# mx, my]{
	var edificio = id_edificio[current_layer][# mx, my]
	temp_text += $"{edificio_nombre[edificio.index]}\n"
	if in(edificio.index, 11, 12, 13, 14, 15, 16)
		temp_text += $"Eficiencia: {100 * edificio.produccion}%\n"
	for(var d = 0; d < array_length(recurso_nombre); d++)
		if edificio_colores[edificio.index, d]{
			var red = edificio.red[d], temp_array = [], temp_produccion = [], rss_eficiencia = []
			temp_text += $"Red {recurso_nombre[d]}\n"
			if red.recurso_produccion > 0
				temp_text += $"  Produccion: {red.recurso_produccion}\n"
			if red.recurso_consumo > 0
				temp_text += $"  Consumo: {red.recurso_consumo}\n"
			repeat(array_length(edificio_nombre))
				array_push(temp_array, 0)
			for(var a = 0; a < ds_list_size(red.edificios); a++){
				var temp_edificio = red.edificios[|a]
				temp_array[temp_edificio.index]++
			}
			for(var a = 0; a < array_length(edificio_nombre); a++)
				if temp_array[a] > 0
					temp_text += $"  {edificio_nombre[a]}: {temp_array[a]}\n"
		}
}
draw_set_color(c_black)
draw_text(0, 0, temp_text)
if modo_hacker{
	draw_set_halign(fa_right)
	draw_text(room_width, 0, $"{floor(mouse_x / 16)}, {floor(mouse_y / 16)}")
	draw_set_halign(fa_left)
}
//Construir
if build_select > 0{
	if in(build_select, 1, 2, 3, 4, 5, 6, 7){
		if mouse_wheel_up()
			build_select = 1 + build_select mod 7
		if mouse_wheel_down()
			build_select = 1 + (build_select + 5) mod 7
		last_path = build_select
	}
	else if in(build_select, 8, 9) and current_layer < 2
		build_select = 8 + current_layer
	else if in(build_select, 11, 12, 13){
		if mouse_wheel_up()
			build_select = 11 + (build_select - 10) mod 3
		if mouse_wheel_down()
			build_select = 11 + (build_select - 9) mod 3
	}
	else if in(build_select, 14, 15, 16)
		build_select = 14 + current_layer
	if mouse_check_button_pressed(mb_left){
		if not in(build_select, 0, 10){
			build_x = mx
			build_y = my
		}
		else{
			mouse_clear(mb_left)
			add_edificio(build_select, mx, my)
		}
	}
	if mouse_check_button_released(mb_left) and not in(build_select, 0, 10){
		if abs(build_x - mx) > abs(build_y - my){
			for(var a = min(build_x, mx); a <= max(build_x, mx); a++)
				add_edificio(build_select, a, build_y)
		}
		else for(var a = min(build_y, my); a <= max(build_y, my); a++)
			add_edificio(build_select, build_x, a)
	}
	if not in(build_select, 0, 10) and mouse_check_button(mb_left){
		if abs(build_x - mx) > abs(build_y - my){
			for(var a = min(build_x, mx); a <= max(build_x, mx); a++)
				draw_sprite(edificio_sprite[build_select], 0, a * 16, build_y * 16)
		}
		else for(var a = min(build_y, my); a <= max(build_y, my); a++)
			draw_sprite(edificio_sprite[build_select], 0, build_x * 16, a * 16)
	}
	else{
		draw_sprite_ext(edificio_sprite[build_select], 0, mx * 16, my * 16, 1, 1, 0, c_white, 0.5)
		if in(build_select, 1, 2, 3, 4, 5, 6, 7){
			var color = [c_red, c_green, c_blue, c_yellow, c_fuchsia, c_aqua, c_white]
			draw_sprite_ext(spr_camino_color, 0, mx * 16, my * 16, 1, 1, 0, color[build_select - 1], 0.5)
		}
	}
	if mouse_check_button_pressed(mb_right){
		mouse_clear(mb_right)
		build_select = 0
	}
}
//Input teclado
if keyboard_check_pressed(vk_anykey){
	if keyboard_check_pressed(vk_up)
		current_layer = min(current_layer + 1, array_length(background) - 1)
	if keyboard_check_pressed(vk_down)
		current_layer = max(current_layer - 1, 0)
	if keyboard_check_pressed(ord(1))
		build_select = last_path
	if keyboard_check_pressed(ord(2))
		build_select = 8
	if keyboard_check_pressed(ord(3))
		build_select = 11
	if keyboard_check_pressed(ord(4))
		build_select = 14
	if keyboard_check_pressed(ord(5))
		build_select = 17
	if keyboard_check_pressed(vk_escape){
		if build_select = 0
			game_end()
		else
			build_select = 0
	}
	if string_ends_with(keyboard_string, "hacker"){
		keyboard_string = ""
		modo_hacker = not modo_hacker
	}
	if keyboard_check_pressed(vk_f4)
		window_set_fullscreen(not window_get_fullscreen())
	if string_ends_with(keyboard_string, "reset")
		game_restart()
}
if mouse_check_button_pressed(mb_right) and bool_edificio[current_layer][# mx, my]{
	var edificio = id_edificio[current_layer][# mx, my]
	if not in(edificio.index, 0, 10)
		delete_edificio(mx, my)
}
//Crecimiento de micelio
repeat(micelio_iteraciones * (1 + (keyboard_check(vk_space) * modo_hacker))){
	var a = irandom(xsize - 1), b = irandom(ysize - 1), capa = irandom(array_length(background) - 1)
	if modo_hacker and keyboard_check(vk_space){
		a = floor(mouse_x / 16)
		b = floor(mouse_y / 16)
		capa = current_layer
	}
	if micelio[capa][# a, b] = 1{
		var next_x = [-1, 0, 1, 0], next_y = [0, -1, 0, 1], flag = false, c = 0
		if not micelio_inteligente
			c = irandom(3)
		else{
			for(c = 0; c < 3; c++){
				var aa = a + next_x[c], bb = b + next_y[c]
				if aa >= 0 and bb >= 0 and aa < xsize and bb < ysize and micelio[capa][# aa, bb] < 1 and bool_edificio[capa][# aa, bb]{
					add_micelio(aa, bb, capa)
					flag = true
					break
				}
			}
			c = irandom(3)
		}
		if not flag{
			var aa = a + next_x[c], bb = b + next_y[c]
			add_micelio(aa, bb, capa)
		}
	}
}
//Tutorial
if tutorial{
	if tutorial_current = 0 and rss[0] >= 11
		tutorial_current++
	if tutorial_current = 1 and rss[1] >= 3
		tutorial_current++
	if tutorial_current = 2 and rss[3] >= 3
		tutorial_current++
	if tutorial_current = 3 and rss[2] >= 3
		tutorial_current++
	if tutorial_current = 4 and rss[4] >= 3 and rss[5] >= 3
		tutorial_current++
	if tutorial_current = 5 and rss[6] >= 3
		tutorial = false
	draw_set_halign(fa_center)
	draw_set_alpha(0.5)
	draw_text(room_width / 2, 20, tutorial_text[tutorial_current])
	draw_set_halign(fa_left)
	draw_set_alpha(1)
}