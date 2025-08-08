function add_edificio(index, a, b, capa = control.current_layer){
	with control{
		var flag = true, base = false
		if in(index, 2) and not recurso[capa][# a, b]
			flag = false
		if flag and not bool_edificio[capa][# a, b]{
			var edificio = null_edificio
			edificio = {
				a : real(a),
				b : real(b),
				capa : capa,
				index : real(index),
				red : null_red,
				subsprite : 0
			}
			ds_grid_set(bool_edificio[capa], a, b, true)
			ds_grid_set(id_edificio[capa], a, b, edificio)
			var next_x = [-1, 0, 1, 0], next_y = [0, -1, 0, 1], temp_redes = ds_list_create()
			ds_list_add(temp_redes, null_red)
			ds_list_clear(temp_redes)
			for(var c = 0; c < 4; c++){
				var aa = a + next_x[c], bb = b + next_y[c]
				if aa >= 0 and bb >= 0 and aa < xsize and bb < ysize and bool_edificio[capa][# aa, bb] and not in(index, 0, 3){
					var temp_edificio = id_edificio[capa][# aa, bb]
					if in(temp_edificio.index, 0, 1, 3){
						temp_edificio.subsprite += power(2, (4 - c) mod 4)
						if not ds_list_contains(temp_redes, temp_edificio.red)
							ds_list_add(temp_redes, temp_edificio.red)
						if temp_edificio.index = 0
							base = true
					}
					if index = 1{
						edificio.subsprite += power(2, (6 - c) mod 4)
						if not ds_list_contains(temp_redes, temp_edificio.red)
							ds_list_add(temp_redes, temp_edificio.red)
					}
				}
			}
			if index = 3{
				if capa > 0{
					var temp_edificio = id_edificio[capa - 1][# a, b]
					if temp_edificio.index = 3 and not ds_list_contains(temp_redes, temp_edificio.red)
						ds_list_add(temp_redes, temp_edificio.red)
				}
				if capa < array_length(background) - 1{
					var temp_edificio = id_edificio[capa + 1][# a, b]
					if temp_edificio.index = 3 and not ds_list_contains(temp_redes, temp_edificio.red)
						ds_list_add(temp_redes, temp_edificio.red)
				}
			}
			var red = null_red
			if ds_list_empty(temp_redes){
				red = {
					edificios : ds_list_create(),
					base : base,
					produccion : [],
					consumo : []
				}
				repeat(array_length(recurso_nombre)){
					array_push(red.produccion, 0)
					array_push(red.consumo, 0)
				}
				ds_list_add(redes, red)
			}
			else{
				red = temp_redes[|0]
				if ds_list_size(temp_redes) > 1{
					for(var c = 1; c < ds_list_size(temp_redes); c++){
						var temp_red = temp_redes[|c]
						for(var d = 0; d < ds_list_size(temp_red.edificios); d++){
							var temp_edificio = temp_red.edificios[|d]
							temp_edificio.red = red
							ds_list_add(red.edificios, temp_edificio)
						}
						for(var d = 0; d < array_length(recurso_nombre); d++){
							red.produccion[d] += real(temp_red.produccion[d])
							red.consumo[d] += real(temp_red.consumo[d])
						}
						if temp_red.base
							base = true
						ds_list_remove(redes, temp_red)
						ds_list_destroy(temp_red.edificios)
					}
				}
			}
			ds_list_add(red.edificios, edificio)
			edificio.red = red
			if in(index, 2)
				red.produccion[capa]++
			if base
				red.base = true
			ds_list_destroy(temp_redes)
		}
	}
}