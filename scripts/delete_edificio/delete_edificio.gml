function delete_edificio(a, b, capa = control.current_layer){
	with control{
		var edificio = id_edificio[capa][# a, b]
		ds_grid_set(bool_edificio[capa], a, b, false)
		ds_grid_set(id_edificio[capa], a, b, null_edificio)
		var red = edificio.red
		ds_list_remove(red.edificios, edificio)
		if ds_list_empty(red.edificios){
			ds_list_destroy(red.edificios)
			ds_list_remove(redes, red)
			return
		}
		var next_x = [-1, 0, 1, 0], next_y = [0, -1, 0, 1], next_edificios = ds_list_create(), grid_vecinos = ds_grid_create(xsize, ysize)
		ds_grid_clear(grid_vecinos, false)
		for(var c = 0; c < 4; c++){
			var aa = a + next_x[c], bb = b + next_y[c]
			if aa >= 0 and bb >= 0 and aa < xsize and bb < ysize and bool_edificio[capa][# aa, bb]{
				var temp_edificio = id_edificio[capa][# aa, bb]
				ds_list_add(next_edificios, temp_edificio)
				ds_grid_set(grid_vecinos, aa, bb, true)
				if in(temp_edificio.index, 1)
					temp_edificio.subsprite -= power(2, (4 - c) mod 4)
			}
		}
		//Rehacer redes
		if ds_list_size(next_edificios) >= 2{
			ds_list_remove(redes, red)
			var visitado = []
			for(var c = 0; c < array_length(background); c++){
				visitado[c] = ds_grid_create(xsize, ysize)
				ds_grid_clear(visitado[c], false)
			}
			while not ds_list_empty(next_edificios){
				edificio = next_edificios[|0]
				var aa = edificio.a, bb = edificio.b, temp_capa = capa
				show_debug_message($"A: {aa}, {bb}, {temp_capa}")
				ds_list_delete(next_edificios, 0)
				ds_grid_set(grid_vecinos, aa, bb, false)
				var new_red = {
					edificios : ds_list_create(),
					base : false,
					produccion : [],
					consumo : []
				}
				var queue = ds_queue_create()
				repeat(array_length(recurso_nombre)){
					array_push(new_red.produccion, 0)
					array_push(new_red.consumo, 0)
				}
				ds_list_add(redes, new_red)
				ds_queue_enqueue(queue, real(aa))
				ds_queue_enqueue(queue, real(bb))
				ds_queue_enqueue(queue, real(temp_capa))
				ds_grid_set(visitado[temp_capa], aa, bb, true)
				while not ds_queue_empty(queue){
					aa = ds_queue_dequeue(queue)
					bb = ds_queue_dequeue(queue)
					show_debug_message($"  B: {aa}, {bb}, {temp_capa}")
					temp_capa = ds_queue_dequeue(queue)
					edificio = id_edificio[temp_capa][# aa, bb]
					edificio.red = new_red
					ds_list_add(new_red.edificios, edificio)
					if in(edificio.index, 2)
						new_red.produccion[edificio.capa]++
					for(var c = 0; c < 4; c++){
						var aaa = aa + next_x[c], bbb = bb + next_y[c]
						show_debug_message($"    C: {aaa}, {bbb}, {temp_capa}")
						if aaa >= 0 and bbb >= 0 and aaa < xsize and bbb < ysize and bool_edificio[temp_capa][# aaa, bbb]{
							if not visitado[temp_capa][# aaa, bbb]{
								ds_grid_set(visitado[temp_capa], aaa, bbb, true)
								var temp_edificio = id_edificio[temp_capa][# aaa, bbb]
								if temp_edificio.index != 0{
									ds_queue_enqueue(queue, aaa)
									ds_queue_enqueue(queue, bbb)
									ds_queue_enqueue(queue, temp_capa)
								}
								else{
									new_red.base = true
									temp_edificio.red = new_red
									ds_list_add(new_red.edificios, temp_edificio)
								}
								if grid_vecinos[# aaa, bbb]{
									ds_list_remove(next_edificios, temp_edificio)
									ds_grid_set(grid_vecinos, aaa, bbb, false)
								}
							}
						}
					}
					if in(edificio.index, 3){
						if temp_capa > 0 and bool_edificio[temp_capa - 1][# aa, bb] and not visitado[temp_capa - 1][# aa, bb]{
							ds_queue_enqueue(queue, aa)
							ds_queue_enqueue(queue, bb)
							ds_queue_enqueue(queue, temp_capa - 1)
							ds_grid_set(visitado[temp_capa - 1], aa, bb, true)
						}
						if temp_capa < array_length(background) - 1 and bool_edificio[temp_capa + 1][# aa, bb] and not visitado[temp_capa + 1][# aa, bb]{
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