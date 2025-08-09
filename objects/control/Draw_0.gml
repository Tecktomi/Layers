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
			if edificio.index = 1
				draw_sprite_ext(spr_camino_color, edificio.subsprite, a * 16, b * 16, 1, 1, 0, edificio.red.red_color, 1)
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
	var red = redes[|a], edificio_count = [], rss_eficiencia = [], temp_produccion = []
	if modo_hacker and ds_list_size(red.edificios) > 2{
		temp_text += $"Red {a}\n"
		for(var b = 0; b < array_length(recurso_nombre); b++)
			if red.produccion[b] > 0
				temp_text += $"  +{red.produccion[b]} {recurso_nombre[b]}\n"
		for(var b = 0; b < array_length(edificio_nombre); b++)
			array_push(edificio_count, 0)
		for(var c = 0; c < ds_list_size(red.edificios); c++){
			var temp_edificio = red.edificios[|c]
			edificio_count[temp_edificio.index]++
		}
		for(var b = 0; b < array_length(edificio_nombre); b++)
			if edificio_count[b] > 0
				temp_text += $"  {edificio_nombre[b]}: {edificio_count[b]}\n"
	}
	if red.consumo[0] > 0
		rss_eficiencia[0] = clamp(red.produccion[0] / red.consumo[0], 0, 1)
	else
		rss_eficiencia[0] = 1
	for(var b = 0; b < array_length(recurso_nombre); b++)
		array_push(temp_produccion, 0)
	temp_produccion[1] = rss_eficiencia[0] * 2 * red.edificio_count[8]
	temp_produccion[2] = rss_eficiencia[0] * 2 * red.edificio_count[9]
	for(var b = 1; b < array_length(recurso_nombre); b++)
		if red.consumo[b] > 0
			rss_eficiencia[b] = clamp((red.produccion[b] + temp_produccion[b]) / red.consumo[b], 0, 1)
		else
			rss_eficiencia[b] = 1
	red.produccion[3] = min(rss_eficiencia[0], rss_eficiencia[1]) * red.edificio_count[4]
	red.produccion[4] = min(rss_eficiencia[0], rss_eficiencia[2]) * red.edificio_count[5]
	red.produccion[5] = min(rss_eficiencia[1], rss_eficiencia[2]) * red.edificio_count[6]
	if red.base for(var b = 0; b < array_length(recurso_nombre); b++)
		rss[b] += max(red.produccion[b] + temp_produccion[b] - red.consumo[b], 0) / 300
	red.red_color = make_color_rgb(min(16 * (red.produccion[0] + temp_produccion[0] - red.consumo[0]), 255), min(16 * (red.produccion[1] + temp_produccion[1] - red.consumo[1]), 255), min(16 * (red.produccion[2] + temp_produccion[2] - red.consumo[2]), 255))
}
var mx = floor(mouse_x / 16), my = floor(mouse_y / 16)
//Información previa de red
if bool_edificio[current_layer][# mx, my]{
	var edificio = id_edificio[current_layer][# mx, my], red = edificio.red, temp_array = [], temp_produccion = [], rss_eficiencia = []
	for(var b = 0; b < array_length(recurso_nombre); b++){
		if red.consumo[b] > 0
			rss_eficiencia[b] = clamp(red.produccion[b] / red.consumo[b], 0, 1)
		else
			rss_eficiencia[b] = 1
		array_push(temp_produccion, 0)
	}
	temp_produccion[1] = rss_eficiencia[0] * 2 * red.edificio_count[8]
	temp_produccion[2] = rss_eficiencia[0] * 2 * red.edificio_count[9]
	for(var a = 0; a < array_length(recurso_nombre); a++){
		if red.produccion[a] + temp_produccion[a] > 0 or red.consumo[a] > 0{
			temp_text += recurso_nombre[a]
			if red.produccion[a] + temp_produccion[a] > 0
				temp_text += $" +{red.produccion[a] + temp_produccion[a]}"
			if red.consumo[a] > 0
				temp_text += $" -{red.consumo[a]}"
			temp_text += "\n"
		}
	}
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
draw_set_color(c_black)
draw_text(0, 0, temp_text)
if modo_hacker{
	draw_set_halign(fa_right)
	draw_text(room_width, 0, $"{floor(mouse_x / 16)}, {floor(mouse_y / 16)}")
	draw_set_halign(fa_left)
}
//Construir
if build_select > 0{
	if in(build_select, 4, 5, 6){
		if mouse_wheel_up()
			build_select = 4 + (build_select - 3) mod 3
		if mouse_wheel_down()
			build_select = 4 + (build_select - 2) mod 3
	}
	if in(build_select, 7, 8, 9)
		build_select = 7 + current_layer
	if mouse_check_button_pressed(mb_left){
		if in(build_select, 1, 2, 7, 8, 9){
			build_x = mx
			build_y = my
		}
		else{
			mouse_clear(mb_left)
			add_edificio(build_select, mx, my)
		}
	}
	if mouse_check_button_released(mb_left) and in(build_select, 1, 2, 7, 8, 9){
		if abs(build_x - mx) > abs(build_y - my){
			for(var a = min(build_x, mx); a <= max(build_x, mx); a++)
				add_edificio(build_select, a, build_y)
		}
		else for(var a = min(build_y, my); a <= max(build_y, my); a++)
			add_edificio(build_select, build_x, a)
	}
	if in(build_select, 1, 2, 7, 8, 9) and mouse_check_button(mb_left){
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
//Input teclado
if keyboard_check_pressed(vk_anykey){
	if keyboard_check_pressed(vk_up)
		current_layer = min(current_layer + 1, array_length(background) - 1)
	if keyboard_check_pressed(vk_down)
		current_layer = max(current_layer - 1, 0)
	if keyboard_check_pressed(ord(1))
		build_select = 1
	if keyboard_check_pressed(ord(2))
		build_select = 2
	if keyboard_check_pressed(ord(3))
		build_select = 4
	if keyboard_check_pressed(ord(4))
		build_select = 7
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
}
if mouse_check_button_pressed(mb_right) and bool_edificio[current_layer][# mx, my]{
	var edificio = id_edificio[current_layer][# mx, my]
	if not in(edificio.index, 0, 3)
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