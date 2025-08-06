function add_edificio(index, a, b, capa = control.current_layer){
	with control{
		var flag = true, base = false
		if in(index, 2) and not recurso[capa][# a, b]
			flag = false
		if flag and edificio[capa][# a, b] = -1{
			ds_grid_set(edificio[capa], a, b, index)
			var next_x = [-1, 0, 1, 0], next_y = [0, -1, 0, 1], temp_redes = ds_list_create()
			for(var c = 0; c < 4; c++){
				var aa = a + next_x[c], bb = b + next_y[c]
				if aa >= 0 and bb >= 0 and aa < xsize and bb < ysize and in(edificio[capa][# aa, bb], 0, 1, 2, 3){
					if in(edificio[capa][# aa, bb], 0, 1, 3){
						edificio_subsprite[capa][# aa, bb] += power(2, (4 - c) mod 4)
						if not ds_list_contains(temp_redes, edificio_red[capa][# aa, bb])
							ds_list_add(temp_redes, edificio_red[capa][# aa, bb])
						if edificio[capa][# aa, bb] = 0
							base = true
					}
					if index = 1{
						edificio_subsprite[capa][# a, b] += power(2, (6 - c) mod 4)
						if not ds_list_contains(temp_redes, edificio_red[capa][# aa, bb])
							ds_list_add(temp_redes, edificio_red[capa][# aa, bb])
					}
				}
			}
			if index = 3{
				if capa > 0 and edificio[capa - 1][# a, b] and not ds_list_contains(temp_redes, edificio_red[capa - 1][# a, b])
					ds_list_add(temp_redes, edificio_red[capa - 1][# a, b])
				if capa < array_length(background) - 1 and edificio[capa + 1][# a, b] and not ds_list_contains(temp_redes, edificio_red[capa + 1][# a, b])
					ds_list_add(temp_redes, edificio_red[capa + 1][# a, b])
			}
			var red = null_red
			if ds_list_empty(temp_redes){
				red = {
					edificios : [],
					base : base,
					produccion : []
				}
				repeat(array_length(background))
					array_push(red.edificios, ds_list_create())
				repeat(array_length(recurso_nombre))
					array_push(red.produccion, 0)
				ds_list_add(redes, red)
			}
			else{
				red = temp_redes[|0]
				if ds_list_size(temp_redes) > 1{
					for(var c = 1; c < ds_list_size(temp_redes); c++){
						var temp_red = temp_redes[|c]
						for(var d = 0; d < array_length(background); d++)
							for(var e = 0; e < ds_list_size(temp_red.edificios[d]); e++){
								var temp_edificio = temp_red.edificios[d][|e]
								ds_grid_set(edificio_red[d], temp_edificio[0], temp_edificio[1], red)
								ds_list_add(red.edificios[d], temp_edificio)
							}
						for(var d = 0; d < array_length(recurso_nombre); d++)
							red.produccion[d] += temp_red.produccion[d]
						if temp_red.base
							base = true
						ds_list_remove(redes, temp_red)
						for(var d = 0; d < array_length(background); d++)
							ds_list_destroy(temp_red.edificios[d])
					}
				}
			}
			ds_list_add(red.edificios[capa], [a, b])
			ds_grid_set(edificio_red[capa], a, b, red)
			if in(index, 2)
				red.produccion[capa]++
			if base
				red.base = true
			ds_list_destroy(temp_redes)
		}
	}
}