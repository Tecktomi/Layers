cursor = cr_arrow
if menu > 0{
	draw_set_color(layer_color_background[0])
	draw_rectangle(0, 0, xsize * 16, ysize * 16, false)
	draw_set_color(c_black)
	if menu = 1{
		draw_set_halign(fa_center)
		draw_set_font(letra_titulo)
		draw_text(room_width / 2, 100, "L A Y E R S")
		draw_set_color(layer_color_recurso[0])
		if get_boton(room_width / 2, 190, "Jugar")
			menu = 13
		if get_boton(room_width / 2, 250, "Editor"){
			menu = 12
		}
		draw_set_font(letra)
		draw_set_halign(fa_left)
		if get_boton(20, 20, "Salir") or keyboard_check_pressed(vk_escape)
			game_end()
		draw_set_color(layer_color_recurso[0])
		draw_set_halign(fa_center)
		draw_set_font(letra_titulo)
		if get_boton(room_width / 2, 520, "¿Cómo jugar?")
			menu = 2
		draw_set_font(letra)
		draw_set_color(c_black)
		draw_set_valign(fa_bottom)
		draw_set_halign(fa_left)
		draw_text(0, room_height, "21-09-2025")
		draw_set_halign(fa_right)
		draw_text(room_width, room_height, "Por Tomás Ramdohr")
		draw_set_valign(fa_top)
		draw_set_halign(fa_left)
	}
	else if menu < 10{
		draw_set_halign(fa_left)
		draw_set_font(letra_titulo)
		draw_text(20, 20, "¿Cómo Jugar?")
		draw_set_font(letra)
		var ypos = 60, xpos = 40
		if menu = 2{
			draw_text(xpos, ypos, "Extracción Básica")
			ypos += 20
			var temp_complex = draw_sprite_uwu(spr_tutorial_1, 0, 40, ypos)
			draw_text(40 + temp_complex[0] + 5, ypos, 
				"Construye Extractores sobre las zonas de recursos con \"2\".\n" +
				"Conecta los Extractores a la Base con Caminos con \"1\".\n" +
				"Los Extractores producirán recurso Rojo.")
			ypos += temp_complex[1] + 10
			temp_complex = draw_sprite_uwu(spr_tutorial_2, 0, 40, ypos)
			xpos += temp_complex[0] + 5
			var temp_complex_2 = draw_sprite_uwu(spr_tutorial_3, 0, xpos, ypos)
			draw_text(xpos + temp_complex_2[0] + 5, ypos,
				"Muévete entre capas usando las Flechas Arriba y Abajo.\n" +
				"Conecta Caminos entre capas a traves de los Túneles multicolores.\n" +
				"Produce recurso Verde construyendo Extractores en esa capa.")
			ypos += temp_complex[1] + 10
			temp_complex = draw_sprite_uwu(spr_tutorial_11, 0, 40, ypos)
			draw_text(40 + temp_complex[0] + 5, ypos,
				"Para mover distintos recursos se necesitan distintos Caminos.\n" +
				"Cambia entre Caminos usando la Rueda del Mouse.\n" +
				"Los Caminos solo se conectarán a los edificios que procesen su color.")
		}
		else if menu = 3{
			draw_text(xpos, ypos, "Primeras Fábricas")
			ypos += 20
			var temp_complex = draw_sprite_uwu(spr_tutorial_4, 0, 40, ypos)
			draw_text(40 + temp_complex[0] + 5, ypos, 
				"Construye Mezcladoras Amarillas para producir recurso Amarillo.\n" +
				"Este edificio necesita un suministro constante de Rojo y Verde.")
			ypos += temp_complex[1] + 10
			temp_complex = draw_sprite_uwu(spr_tutorial_5, 0, 40, ypos)
			xpos += temp_complex[0] + 5
			temp_complex = draw_sprite_uwu(spr_tutorial_7, 0, xpos, ypos)
			draw_text(xpos + temp_complex[0] + 5, ypos, 
				"Construye mejores Extractores para producir recurso Azul.\n" +
				"Estos Extractores requiere suministro constante de Rojo para producir.\n" +
				"Recuerda utilizar Caminos del color apropiado para cada recurso.")
			ypos += temp_complex[1] + 10
		}
		else if menu = 4{
			draw_text(xpos, ypos, "Fábrica Avanzadas")
			ypos += 20
			var temp_complex = draw_sprite_uwu(spr_tutorial_8, 0, 40, ypos)
			draw_text(40 + temp_complex[0] + 5, ypos, 
				"Produce recursos Magenta y Cian en sus Mezcladoras respectivas.\n" +
				"El Magenta se fabrica con Rojo y Azul y el Cian con Verde y Azul.")
			ypos += temp_complex[1] + 10
			temp_complex = draw_sprite_uwu(spr_tutorial_9, 0, 40, ypos)
			draw_text(40 + temp_complex[0] + 5, ypos,
				"Construye una Fábrica de Blanco presionando \"5\".\n" +
				"Produce recurso Blanco mezclando Amarillo, Magenta y Cian.")
			ypos += temp_complex[1] + 10
			temp_complex = draw_sprite_uwu(spr_tutorial_12, 0, 40, ypos)
			draw_text(40 + temp_complex[0] + 5, ypos,
				"Crea o elimina Túneles multicolores con recurso Blanco presionando \"7\".\n" +
				"Si construyes dos Túneles en la misma posición en distintas capas, se conectarán.\n" +
				"Los Túneles además sirven como cruce de Caminos aunque no estén conectados a otro Túnel.")
		}
		else if menu = 5{
			draw_text(xpos, ypos, "Defensa y Ataque")
			ypos += 20
			var temp_complex = draw_sprite_uwu(spr_tutorial_13, 0, 40, ypos)
			draw_text(40 + temp_complex[0] + 5, ypos, 
				"¡Cuidado con el Micelio que está creciendo!\n" +
				"El Micelio crece lento pero seguro devorando todo a su paso.\n" +
				"Puede atravezar Túneles e invadir otras capas.\n" +
				"Si llegas hasta la Base, perderás.")
			ypos += temp_complex[1] + 10
			temp_complex = draw_sprite_uwu(spr_tutorial_10, 0, 40, ypos)
			draw_text(40 + temp_complex[0] + 5, ypos, 
				"Para defenderte construye una Fábrica de Drones con \"6\".\n" +
				"Esta consume recurso Cian para producir Drones si hay Micelio cerca.\n" +
				"Los Drones volarán hasta el Micelio más cercano y lo destruirán.")
		}
		draw_set_halign(fa_center)
		draw_set_color(layer_color_recurso[0])
		if menu > 2 and get_boton(room_width / 2 - 100, room_height - 100, "Anterior")
			menu--
		if menu < 5 and get_boton(room_width / 2 + 100, room_height - 100, "Siguiente")
			menu++
		if get_boton(room_width / 2, room_height - 60, "Volver") or keyboard_check_pressed(vk_escape)
			menu = 1
	}
	//Derrota
	else if menu = 10{
		draw_set_halign(fa_center)
		draw_set_font(letra_titulo)
		draw_text(room_width / 2, 100, $"Has Perdido\n\nEl micelio ha llegado a la base\nTiempo: {floor(tiempo)} segundos\nMicelio destruido: {micelio_muerto}\nEdificios construidos: {edificios_construidos}")
		draw_set_halign(fa_center)
		draw_set_color(layer_color_recurso[0])
		if get_boton(room_width / 2, room_height - 60, "Volver") or keyboard_check_pressed(vk_escape)
			game_restart()
		
	}
	//Victoria
	else if menu = 11{
		draw_set_halign(fa_center)
		draw_set_font(letra_titulo)
		draw_text(room_width / 2, 100, $"Has Ganado\n\nHas destruido todo el micelio\nTiempo: {floor(tiempo)} segundos\nMicelio destruido: {micelio_muerto}\nEdificios construidos: {edificios_construidos}")
		draw_set_halign(fa_center)
		draw_set_color(layer_color_recurso[0])
		if get_boton(room_width / 2, room_height - 120, "Continuar Jugando")
			menu = 0
		if get_boton(room_width / 2, room_height - 60, "Salir") or keyboard_check_pressed(vk_escape)
			game_restart()
	}
	//Editor
	else if menu = 12{
		if keyboard_check_pressed(vk_up)
			current_layer = min(current_layer + 1, array_length(background) - 1)
		if keyboard_check_pressed(vk_down)
			current_layer = max(current_layer - 1, 0)
		var mx = clamp(floor(mouse_x / 16), 0, xsize - 1), my = clamp(floor(mouse_y / 16), 0, ysize - 1)
		if mouse_check_button_pressed(mb_left)
			delete_bool = not recurso[current_layer][# mx, my]
		if mouse_check_button(mb_left)
			ds_grid_set(recurso[current_layer], mx, my, delete_bool)
		if mouse_check_button_pressed(mb_right) and not recurso[current_layer][# mx, my]
			ds_grid_set(bool_edificio[current_layer], mx, my, not bool_edificio[current_layer][# mx, my])
		draw_set_color(layer_color_background[current_layer])
		draw_rectangle(0, 0, xsize * 16, ysize * 16, false)
		draw_set_color(layer_color_recurso[current_layer])
		for(var a = 0; a < xsize; a++)
			for(var b = 0; b < ysize; b++)
				if recurso[current_layer][# a, b]
					draw_rectangle(a * 16, b * 16, a * 16 + 15, b * 16 + 15, false)
				else if bool_edificio[current_layer][# a, b]
					draw_circle(a * 16 + 8, b * 16 + 8, 8, false)
		draw_set_color(layer_color_recurso[0])
		if get_boton(20, 20, "Volver") or keyboard_check_pressed(vk_escape){
			for(var c = 0; c < array_length(background); c++)
				ds_grid_clear(bool_edificio[c], false)
		for(var a = floor(xsize / 2) - 1; a <= ceil(xsize / 2) + 1; a++)
			for(var b = floor(ysize / 2) - 1; b <= ceil(ysize / 2) + 1; b++)
				ds_grid_set(bool_edificio[0], a, b, true)
			menu = 1
		}
		if get_boton(20, 50, "Guardar") or (keyboard_check(vk_lcontrol) and keyboard_check_pressed(ord("G"))){
			var file = get_save_filename("*.txt", game_save_id + "save.txt")
			if file != ""{
				ini_open(file)
				for(var c = 0; c < array_length(background); c++)
					for(var a = 0; a < xsize; a++)
						for(var b = 0; b < ysize; b++){
							if recurso[c][# a, b]
								ini_write_string($"rss{c}", $"{a},{b}", "Y")
							else
								ini_key_delete($"rss{c}", $"{a},{b}")
							if bool_edificio[c][# a, b]
								ini_write_string($"edificios{c}", $"{a},{b}", "Y")
							else
								ini_key_delete($"edificios{c}", $"{a},{b}")
						}
				ini_close()
			}
		}
		if get_boton(20, 80, "Cargar") or (keyboard_check(vk_lcontrol) and keyboard_check_pressed(ord("A")))
			cargar_escenario()
	}
	//Prejugar
	else if menu = 13{
		draw_set_color(layer_color_recurso[0])
		draw_set_halign(fa_left)
		if get_boton(20, 20, "Volver") or keyboard_check_pressed(vk_escape)
			menu = 1
		draw_set_halign(fa_center)
		draw_set_font(letra_titulo)
		if get_boton(room_width / 2, 190, "Cargar Escenario"){
			draw_set_halign(fa_left)
			menu = 0
			image_index = 0
			micelio_muerto = 0
			edificios_construidos = 0
			delete_bool = false
			cargar_escenario()
		}
		if get_boton(room_width / 2, 250, "Mapa Aleatorio"){
			draw_set_halign(fa_left)
			menu = 0
			image_index = 0
			micelio_muerto = 0
			edificios_construidos = 0
			delete_bool = false
			//Portales
			repeat(total_portales){
				do var a = irandom_range(1, xsize - 2), b = irandom_range(1, ysize - 2)
				until not bool_edificio[0][# a, b] and not bool_edificio[1][# a, b]
				add_edificio(10, a, b, 0)
				add_edificio(10, a, b, 1)
				do {a = irandom_range(1, xsize - 2); b = irandom_range(1, ysize - 2)}
				until not bool_edificio[1][# a, b] and not bool_edificio[2][# a, b]
				add_edificio(10, a, b, 1)
				add_edificio(10, a, b, 2)
			}
			//Micelios iniciales
			repeat(total_micelios){
				do var a = irandom_range(1, xsize - 2), b = irandom_range(1, ysize - 2), capa = irandom_range(1, array_length(background) - 1)
				until not bool_edificio[capa][# a, b]
				add_micelio(a, b, capa)
				var next_x = [-1, 0, 1, 0], next_y = [0, -1, 0, 1]
				for(var c = 0; c < 4; c++)
					add_micelio(a + next_x[c], b + next_y[c], capa)
			}
			//Recursos
			for(var c = 0; c < array_length(background); c++)
				repeat(total_betas){
					var a = irandom_range(4, xsize - 5), b = irandom_range(4, ysize - 5)
					repeat(tamano_betas){
						a = clamp(a + irandom_range(-1, 1), 1, xsize - 2)
						b = clamp(b + irandom_range(-1, 1), 1, ysize - 2)
						ds_grid_set_region(recurso[c], a - 1, b - 1, a + 1, b + 1, true)
					}
				}
		}
		draw_set_font(letra)
		draw_set_color(c_black)
		draw_text(room_width / 2, 320, $"Micelio inicial: {total_micelios}")
		total_micelios = round(draw_deslizante(room_width / 2 - 100, room_width / 2 + 100, 340, 1, 5, round(total_micelios), 1))
		draw_text(room_width / 2, 350, $"Túneles por Capa: {total_portales}")
		total_portales = round(draw_deslizante(room_width / 2 - 100, room_width / 2 + 100, 370, 1, 5, round(total_portales), 2))
		draw_text(room_width / 2, 380, $"Velocidad Micelio: {micelio_iteraciones}")
		micelio_iteraciones = round(draw_deslizante(room_width / 2 - 100, room_width / 2 + 100, 400, 4, 30, round(micelio_iteraciones), 3))
		draw_text(room_width / 2, 410, $"Precio Edificios: {valor_edificios}")
		valor_edificios = round(draw_deslizante(room_width / 2 - 100, room_width / 2 + 100, 430, 1, 5, round(valor_edificios), 4))
		draw_text(room_width / 2, 440, $"Depósitos de Recursos: {total_betas}")
		total_betas = round(draw_deslizante(room_width / 2 - 100, room_width / 2 + 100, 460, 1, 6, round(total_betas), 5))
		draw_text(room_width / 2, 470, $"Tamaño de Depósitos de Recursos: {tamano_betas}")
		tamano_betas = round(draw_deslizante(room_width / 2 - 100, room_width / 2 + 100, 490, 10, 40, round(tamano_betas), 6))
	}
	window_set_cursor(cursor)
	exit
}
//Actualizar fondo
if background[current_layer] = undefined{
	var surf = surface_create(xsize * 16, ysize * 16)
	surface_set_target(surf)
	draw_set_color(layer_color_background[current_layer])
	draw_rectangle(0, 0, xsize * 16, ysize * 16, false)
	draw_set_color(layer_color_recurso[current_layer])
	for(var a = 0; a < xsize; a++)
		for(var b = 0; b < ysize; b++)
			if recurso[current_layer][# a, b]
				draw_rectangle(a * 16, b * 16, a * 16 + 15, b * 16 + 15, false)
	background[current_layer] = sprite_create_from_surface(surf, 0, 0, xsize * 16, ysize * 16, false, false, 0, 0)
	surface_reset_target()
	surface_free(surf)
}
draw_sprite_stretched(background[current_layer], 0, -camx, -camy, xsize * 16, ysize * 16)
//Dibujo de edificios y micelio
if background_edificio[current_layer] = undefined{
	var surf = surface_create(xsize * 16, ysize * 16)
	surface_set_target(surf)
	for(var a = 0; a < xsize; a++)
		for(var b = 0; b < ysize; b++){
			if bool_edificio[current_layer][# a, b]{
				var edificio = id_edificio[current_layer][# a, b]
				draw_sprite(edificio_sprite[edificio.index], edificio.subsprite, a * 16, b * 16)
				if in(edificio.index, 1, 2, 3, 4, 5, 6, 7)
					draw_sprite_ext(spr_camino_color, edificio.subsprite, a * 16, b * 16, 1, 1, 0, recurso_color[edificio.index - 1], 1)
				else if in(edificio.index, 19, 20, 21, 22, 23, 24, 25)
					draw_sprite_ext(spr_infinito, edificio.subsprite, a * 16, b * 16, 1, 1, 0, recurso_color[edificio.index - 19], 1)
			}
			else if micelio[current_layer][# a, b] = 1
				draw_sprite(spr_micelio_1, micelio_subsprite[current_layer][# a, b], a * 16, b * 16)
			else if micelio[current_layer][# a, b] = 2
				draw_sprite(spr_micelio_2, 0, a * 16, b * 16)
		}
	background_edificio[current_layer] = sprite_create_from_surface(surf, 0, 0, xsize * 16, ysize * 16, false, false, 0, 0)
	surface_reset_target()
	surface_free(surf)
}
draw_sprite_stretched(background_edificio[current_layer], 0, -camx, -camy, xsize * 16, ysize * 16)
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
	//Producción para el núcleo
	if red.base
		rss[red.recurso] += max(red.produccion - red.consumo, 0) / 300
	//Fábricas de Drones
	if red.recurso = 1
		for(var b = 0; b < ds_list_size(red.edificios_index[18]); b++){
			var temp_edificio = red.edificios_index[18][|b]
			temp_edificio.produccion += red.eficiencia
			if temp_edificio.produccion >= 200{
				var xx = temp_edificio.a, yy = temp_edificio.b, capa = temp_edificio.capa
				temp_edificio.produccion -= 200
				var coord = buscar_micelio(xx, yy, capa)
				if coord[0] >= 0{
					var target_x = coord[0], target_y = coord[1], dis = sqrt(sqr(xx - target_x) + sqr(yy - target_y))
					var new_dron = {
						a : xx * 16,
						b : yy * 16,
						capa : capa,
						live : 8 * dis,
						target_x : target_x,
						target_y : target_y,
						vel_x : 2 * (target_x - xx) / dis,
						vel_y : 2 * (target_y - yy) / dis
					}
					ds_list_add(drones[temp_edificio.capa], new_dron)
				}
			}
		}
}
//Función drones
for(var a = 0; a < array_length(background); a++)
	for(var b = 0; b < ds_list_size(drones[a]); b++){
		var dron = drones[a][|b], aa = dron.a, bb = dron.b
		dron.a += dron.vel_x
		dron.b += dron.vel_y
		dron.live--
		if dron.live <= 0{
			delete_micelio(dron.target_x, dron.target_y, dron.capa)
			ds_list_remove(drones[a], dron)
			b--
		}
		if current_layer = a
			draw_sprite(spr_dron, 0, aa - camx, bb - camy)
	}
var mx = clamp(floor((mouse_x + camx) / 16), 0, xsize - 1), my = clamp(floor((mouse_y + camy) / 16), 0, ysize - 1)
//Información previa de red
if bool_edificio[current_layer][# mx, my]{
	var edificio = id_edificio[current_layer][# mx, my]
	temp_text += $"{edificio_nombre[edificio.index]}\n"
	if in(edificio.index, 11, 12, 13, 15, 16, 17)
		temp_text += $"Eficiencia: {floor(100 * edificio.produccion)}%\n"
	else if in(edificio.index, 18)
		temp_text += $"Producción: {floor(edificio.produccion / 2)}%\n"
	for(var d = 0; d < array_length(recurso_nombre); d++)
		if edificio_colores[edificio.index, d]{
			var red = edificio.red[d], temp_array = [], temp_produccion = [], rss_eficiencia = []
			temp_text += $"Red {recurso_nombre[d]}\n"
			if red.produccion > 0 or red.consumo > 0{
				temp_text += $"  Producción: {red.produccion} - {red.consumo} = {red.produccion > red.consumo ? "+" : ""}{red.produccion - red.consumo}\n"
				temp_text += $"  Eficiencia: {floor(100 * red.eficiencia)}%\n"
			}
			repeat(array_length(edificio_nombre))
				array_push(temp_array, 0)
			for(var a = 0; a < ds_list_size(red.edificios); a++){
				var temp_edificio = red.edificios[|a]
				temp_array[temp_edificio.index]++
			}
			for(var a = 0; a < array_length(edificio_nombre); a++)
				if temp_array[a] > 0
					temp_text += $"    {edificio_nombre[a]}: {temp_array[a]}\n"
		}
	if mouse_check_button_pressed(mb_left) and edificio.index = 10{
		if edificio.subsprite = 2{
			current_layer = 1 - current_layer
			mouse_clear(mb_left)
		}
		if edificio.subsprite = 4{
			current_layer = 3 - current_layer
			mouse_clear(mb_left)
		}
	}
}
draw_text_box(0, 0, temp_text)
if modo_hacker{
	draw_set_halign(fa_right)
	draw_text(room_width, 0, $"{floor(mouse_x / 16)}, {floor(mouse_y / 16)}")
	draw_set_halign(fa_left)
}
//Construir
if build_select > 0{
	var fail_text = $"{edificio_nombre[build_select]}\n{edificio_descripcion[build_select]}\n\n"
	if in(build_select, 1, 2, 3, 4, 5, 6, 7){
		if mouse_wheel_up()
			build_select = 1 + build_select mod 7
		if mouse_wheel_down()
			build_select = 1 + (build_select + 5) mod 7
		last_path = build_select
		draw_set_alpha(0.5)
		var c = 2 * pi / array_length(rss)
		for(var a = 0; a < array_length(rss); a++){
			var b = a * c
			draw_set_color(recurso_color[a])
			draw_triangle(room_width - 60, 60, room_width - 60 + 50 * cos(b), 60 - 50 * sin(b), room_width - 60 + 50 * cos(b + c), 60 - 50 * sin(b + c), false)
		}
		draw_set_alpha(1)
		draw_set_color(c_black)
		var b = (build_select - 1) * c
		draw_triangle(room_width - 60, 60, room_width - 60 + 50 * cos(b), 60 - 50 * sin(b), room_width - 60 + 50 * cos(b + c), 60 - 50 * sin(b + c), true)
	}
	else if in(build_select, 8, 9){
		if current_layer < 2{
			build_select = 8 + current_layer
			if not recurso[current_layer][# mx, my]
				fail_text += "Terreno inválido\n"
		}
		else
			fail_text += "Necesitas un mejor extractor\n"
	}
	else if in(build_select, 11, 12, 13){
		if mouse_wheel_up()
			build_select = 11 + (build_select - 10) mod 3
		if mouse_wheel_down()
			build_select = 11 + (build_select - 9) mod 3
	}
	else if in(build_select, 14, 15, 16){
		build_select = 14 + current_layer
		if not recurso[current_layer][# mx, my]
			fail_text += "Terreno inválido\n"
	}
	else if in(build_select, 18, 26){
		if mouse_wheel_up() or mouse_wheel_down()
			build_select = 44 - build_select
	}
	else if in(build_select, 19, 20, 21, 22, 23, 24, 25){
		if mouse_wheel_up()
			build_select = 19 + (build_select + 3) mod 7
		if mouse_wheel_down()
			build_select = 19 + (build_select + 1) mod 7
	}
	else if in(build_select, 27, 28, 29){
		if mouse_wheel_up()
			build_select = 27 + (build_select + 1) mod 3
		if mouse_wheel_down()
			build_select = 27 + (build_select - 1) mod 3
	}
	if rss[edificio_precio[build_select]] <= valor_edificios and not in(build_select, 1, 2, 3, 4, 5, 6, 7) and not modo_hacker
		fail_text += $"Insuficiente {recurso_nombre[edificio_precio[build_select]]}\n"
	if bool_edificio[current_layer][# mx, my]
		fail_text += "Terreno utilizado\n"
	if micelio[current_layer][# mx, my] > 0
		fail_text += "No se puede construir sobre Micelio\n"
	draw_text_box((mx + 2) * 16 - camx, my * 16 - camy, fail_text)
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
		if in(build_select, 1, 2, 3, 4, 5, 6, 7){
			if abs(build_x - mx) > abs(build_y - my){
				for(var a = min(build_x, mx); a <= max(build_x, mx); a++){
					draw_sprite(spr_camino, 0, a * 16 - camx, build_y * 16 - camy)
					draw_sprite_ext(spr_camino_color, 5, a * 16 - camx, build_y * 16 - camy, 1, 1, 0, recurso_color[build_select - 1], 1)
				}
			}
			else for(var a = min(build_y, my); a <= max(build_y, my); a++){
				draw_sprite(spr_camino, 0, build_x * 16 - camx, a * 16 - camy)
				draw_sprite_ext(spr_camino_color, 10, build_x * 16 - camx, a * 16 - camy, 1, 1, 0, recurso_color[build_select - 1], 1)
			}
		}
		else{
			if abs(build_x - mx) > abs(build_y - my){
				for(var a = min(build_x, mx); a <= max(build_x, mx); a++)
					draw_sprite(edificio_sprite[build_select], 0, a * 16 - camx, build_y * 16 - camy)
			}
			else for(var a = min(build_y, my); a <= max(build_y, my); a++)
				draw_sprite(edificio_sprite[build_select], 0, build_x * 16 - camx, a * 16 - camy)
		}
	}
	else{
		draw_sprite_ext(edificio_sprite[build_select], 0, mx * 16 - camx, my * 16 - camy, 1, 1, 0, c_white, 0.5)
		if in(build_select, 1, 2, 3, 4, 5, 6, 7)
			draw_sprite_ext(spr_camino_color, 0, mx * 16 - camx, my * 16 - camy, 1, 1, 0, recurso_color[build_select - 1], 0.5)
		else if in(build_select, 19, 20, 21, 22, 23, 24, 25)
			draw_sprite_ext(spr_infinito, 0, mx * 16 - camx, my * 16 - camy, 1, 1, 0, recurso_color[build_select - 19], 0.5)
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
	if keyboard_check_pressed(ord(6))
		build_select = 18
	if keyboard_check_pressed(ord(7))
		build_select = 10
	if keyboard_check_pressed(ord(8))
		build_select = 27
	if keyboard_check_pressed(ord(9)) and modo_hacker
		build_select = 19
	if keyboard_check_pressed(vk_escape){
		if build_select = 0
			game_restart()
		else
			build_select = 0
	}
	if string_ends_with(keyboard_string, "hacker"){
		keyboard_string = ""
		modo_hacker = not modo_hacker
		micelio_iteraciones = 10
	}
	if keyboard_check_pressed(vk_f4)
		window_set_fullscreen(not window_get_fullscreen())
}
if mouse_check_button_pressed(mb_right){
	delete_bool = true
	delete_x = mx
	delete_y =  my
	if modo_hacker and micelio[current_layer][# mx, my] > 0
		delete_micelio(mx, my, current_layer)
}
if delete_bool{
	var minx = min(delete_x, mx), miny = min(delete_y, my), maxx = max(delete_x, mx), maxy = max(delete_y, my)
	draw_set_color(c_black)
	draw_set_alpha(0.5)
	draw_rectangle(minx * 16 - camx, miny * 16 - camy, (maxx + 1) * 16 - camx, (maxy + 1) * 16 - camy, false)
	draw_set_alpha(1)
	draw_rectangle(minx * 16 - camx, miny * 16 - camy, (maxx + 1) * 16 - camx, (maxy + 1) * 16 - camy, true)
	if mouse_check_button_released(mb_right){
		delete_bool = false
		for(var a = minx; a <= maxx; a++)
			for(var b = miny; b <= maxy; b++)
				if bool_edificio[current_layer][# a, b]{
					var edificio= id_edificio[current_layer][# a, b]
					if not in(edificio.index, 0, 10)  or (rss[6] >= valor_edificios and edificio.index = 10) or modo_hacker{
						if edificio.index = 10 and not modo_hacker
							rss[6] -= valor_edificios
						delete_edificio(a, b)
					}
				}
	}
	if mouse_check_button_pressed(mb_left)
		delete_bool = false
}
//Crecimiento de micelio
repeat(micelio_iteraciones){
	var a = irandom(xsize - 1), b = irandom(ysize - 1), capa = irandom(array_length(background) - 1)
	if modo_hacker and keyboard_check(vk_space){
		a = floor(mouse_x / 16)
		b = floor(mouse_y / 16)
		capa = current_layer
	}
	if micelio[capa][# a, b] = 1 and micelio_subsprite[capa][# a, b] < 15{
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
if flag_update_eficiencia{
	flag_update_eficiencia = false
	update_eficiencia()
}
for(var a = 0; a < array_length(background); a++)
	if bool_refresh_layer[a]{
		refresh_layer(a)
		bool_refresh_layer[a] = false
	}
window_set_cursor(cursor)