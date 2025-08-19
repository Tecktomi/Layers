function delete_edificio(a, b, capa = control.current_layer){
	with control{
		background_edificio[capa] = undefined
		var edificio = id_edificio[capa][# a, b], index = edificio.index, flag = false
		ds_grid_set(bool_edificio[capa], a, b, false)
		ds_grid_set(id_edificio[capa], a, b, null_edificio)
		for(var c = 0; c < array_length(recurso_nombre); c++)
			if edificio_colores[edificio.index, c]{
				var red = edificio.red[c]
				ds_list_remove(red.edificios, edificio)
				ds_list_remove(red.edificios_index[index], edificio)
				if ds_list_empty(red.edificios){
					ds_list_destroy(red.edificios)
					ds_list_remove(redes, red)
					ds_list_remove(redes_recurso[red.recurso], red)
				}
				else
					flag = true
			}
		if not flag
			return
		//Colores Túneles
		if index = 10{
			if edificio.subsprite = 2{
				if capa = 0
					id_edificio[1][# a, b].subsprite = 3
				else if capa = 1
					id_edificio[0][# a, b].subsprite = 1
				background_edificio[0] = undefined
				background_edificio[1] = undefined
			}
			if edificio.subsprite = 4{
				if capa = 1
					id_edificio[2][# a, b].subsprite = 5
				else if capa = 2
					id_edificio[1][# a, b].subsprite = 3
				background_edificio[1] = undefined
				background_edificio[2] = undefined
			}
			if edificio.subsprite = 0{
				if capa = 0{
					id_edificio[1][# a, b].subsprite = 4
					id_edificio[2][# a, b].subsprite = 4
				}
				else if capa = 1{
					id_edificio[0][# a, b].subsprite = 1
					id_edificio[2][# a, b].subsprite = 5
				}
				else if capa = 2{
					id_edificio[0][# a, b].subsprite = 2
					id_edificio[1][# a, b].subsprite = 2
				}
				background_edificio[0] = undefined
				background_edificio[1] = undefined
				background_edificio[2] = undefined
			}
		}
		//Detectar edificios adyascentes
		var next_x = [-1, 0, 1, 0], next_y = [0, -1, 0, 1], next_edificios = ds_list_create(), grid_vecinos = ds_grid_create(xsize, ysize)
		ds_grid_clear(grid_vecinos, false)
		for(var d = 0; d < array_length(recurso_nombre); d++)
			if edificio_colores[edificio.index, d]{
				for(var c = 0; c < 4; c++){
					var aa = a + next_x[c], bb = b + next_y[c]
					if aa >= 0 and bb >= 0 and aa < xsize and bb < ysize and bool_edificio[capa][# aa, bb]{
						var temp_edificio = id_edificio[capa][# aa, bb]
						if edificio_colores[temp_edificio.index, d]{
							ds_list_add(next_edificios, temp_edificio)
							ds_grid_set(grid_vecinos, aa, bb, true)
							if in(temp_edificio.index, 1, 2, 3, 4, 5, 6, 7)
								temp_edificio.subsprite -= power(2, (4 - c) mod 4)
						}
					}
				}
			}
		//Rehacer redes
		for(var d = 0; d < array_length(recurso_nombre); d++)
			if edificio_colores[edificio.index, d] and ds_list_size(next_edificios) >= 2{
				var red = edificio.red[d]
				ds_list_remove(redes, red)
				ds_list_remove(redes_recurso[d], red)
				var visitado = []
				for(var c = 0; c < array_length(background); c++){
					visitado[c] = ds_grid_create(xsize, ysize)
					ds_grid_clear(visitado[c], false)
				}
				while not ds_list_empty(next_edificios){
					edificio = next_edificios[|0]
					var aa = edificio.a, bb = edificio.b, temp_capa = capa
					ds_list_delete(next_edificios, 0)
					ds_grid_set(grid_vecinos, aa, bb, false)
					var new_red = {
						edificios : ds_list_create(),
						edificios_index : [],
						base : false,
						recurso : d,
						produccion : 0,
						consumo : 0,
						eficiencia : 0
					}
					var queue = ds_queue_create()
					repeat(array_length(edificio_nombre)){
						var temp_edificio_list = ds_list_create()
						ds_list_add(temp_edificio_list, null_edificio)
						ds_list_clear(temp_edificio_list)
						array_push(new_red.edificios_index, temp_edificio_list)
					}
					ds_list_add(redes, new_red)
					ds_list_add(redes_recurso[d], new_red)
					ds_queue_enqueue(queue, real(aa))
					ds_queue_enqueue(queue, real(bb))
					ds_queue_enqueue(queue, real(temp_capa))
					ds_grid_set(visitado[temp_capa], aa, bb, true)
					while not ds_queue_empty(queue){
						aa = ds_queue_dequeue(queue)
						bb = ds_queue_dequeue(queue)
						temp_capa = ds_queue_dequeue(queue)
						edificio = id_edificio[temp_capa][# aa, bb]
						edificio.red[d] = new_red
						ds_list_add(new_red.edificios, edificio)
						ds_list_add(new_red.edificios_index[edificio.index], edificio)
						flag_update_eficiencia = true
						for(var c = 0; c < 4; c++){
							var aaa = aa + next_x[c], bbb = bb + next_y[c]
							if aaa >= 0 and bbb >= 0 and aaa < xsize and bbb < ysize and bool_edificio[temp_capa][# aaa, bbb] and not visitado[temp_capa][# aaa, bbb]{
								var temp_edificio = id_edificio[temp_capa][# aaa, bbb]
								if edificio_colores[temp_edificio.index, d] and (in(edificio.index, 1, 2, 3, 4, 5, 6, 7) or in(temp_edificio.index, 1, 2, 3, 4, 5, 6, 7)){
									ds_grid_set(visitado[temp_capa], aaa, bbb, true)
									if temp_edificio.index != 0{
										ds_queue_enqueue(queue, aaa)
										ds_queue_enqueue(queue, bbb)
										ds_queue_enqueue(queue, temp_capa)
									}
									else{
										new_red.base = true
										temp_edificio.red[d] = new_red
										ds_list_add(new_red.edificios, temp_edificio)
										ds_list_add(new_red.edificios_index[temp_edificio.index], temp_edificio)
									}
									if grid_vecinos[# aaa, bbb] and temp_edificio.capa = capa{
										ds_list_remove(next_edificios, temp_edificio)
										ds_grid_set(grid_vecinos, aaa, bbb, false)
									}
								}
							}
						}
						//Rehacer redes a travez de portales
						if in(edificio.index, 10){
							if temp_capa > 0 and bool_edificio[temp_capa - 1][# aa, bb] and not visitado[temp_capa - 1][# aa, bb] and id_edificio[temp_capa - 1][# aa, bb].index = 10{
								ds_queue_enqueue(queue, aa)
								ds_queue_enqueue(queue, bb)
								ds_queue_enqueue(queue, temp_capa - 1)
								ds_grid_set(visitado[temp_capa - 1], aa, bb, true)
							}
							if temp_capa < array_length(background) - 1 and bool_edificio[temp_capa + 1][# aa, bb] and not visitado[temp_capa + 1][# aa, bb] and id_edificio[temp_capa + 1][# aa, bb].index = 10{
								ds_queue_enqueue(queue, aa)
								ds_queue_enqueue(queue, bb)
								ds_queue_enqueue(queue, temp_capa + 1)
								ds_grid_set(visitado[temp_capa + 1], aa, bb, true)
							}
						}
					}
					ds_queue_destroy(queue)
				}
				for(var c = 0; c < array_length(background); c++)
					ds_grid_destroy(visitado[c])
			}
	}
}