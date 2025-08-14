function add_edificio(index, a, b, capa = control.current_layer){
	with control{
		var flag = true, base = false
		if in(index, 8, 9, 14, 15, 16) and not recurso[capa][# a, b]
			flag = false
		if in(index, 8, 9) and capa = 2
			flag = false
		if not modo_hacker and not in(index, 0, 1, 2, 3, 4, 5, 6, 7, 9, 10) and rss[edificio_precio[index]] < 1
			flag = false
		if flag and not bool_edificio[capa][# a, b] and not micelio[capa][# a, b]{
			if not modo_hacker and not in(index, 0, 1, 2, 3, 4, 5, 6, 7, 10)
				rss[edificio_precio[index]]--
			var edificio = null_edificio
			edificio = {
				a : real(a),
				b : real(b),
				capa : capa,
				index : real(index),
				red : [],
				subsprite : 0,
				produccion : 0
			}
			repeat(array_length(recurso_nombre))
				array_push(edificio.red, null_red)
			ds_grid_set(bool_edificio[capa], a, b, true)
			ds_grid_set(id_edificio[capa], a, b, edificio)
			var next_x = [-1, 0, 1, 0], next_y = [0, -1, 0, 1], temp_redes = []
			repeat(array_length(recurso_nombre)){
				var temp_red_2 = ds_list_create()
				ds_list_add(temp_red_2, null_red)
				ds_list_clear(temp_red_2)
				array_push(temp_redes, temp_red_2)
			}
			//Detectar edificios colindantes
			for(var d = 0; d < array_length(recurso_nombre); d++)
				if edificio_colores[index, d] for(var c = 0; c < 4; c++){
					var aa = a + next_x[c], bb = b + next_y[c]
					if aa >= 0 and bb >= 0 and aa < xsize and bb < ysize and bool_edificio[capa][# aa, bb] and not in(index, 0, 10){
						var temp_edificio = id_edificio[capa][# aa, bb]
						if edificio_colores[temp_edificio.index, d]{
							if in(temp_edificio.index, 1, 2, 3, 4, 5, 6, 7){
								temp_edificio.subsprite += power(2, (4 - c) mod 4)
								if not ds_list_contains(temp_redes[d], temp_edificio.red[d])
									ds_list_add(temp_redes[d], temp_edificio.red[d])
							}
							if temp_edificio.index = 0
								base = true
							if in(index, 1, 2, 3, 4, 5, 6, 7){
								edificio.subsprite += power(2, (6 - c) mod 4)
								if not ds_list_contains(temp_redes[d], temp_edificio.red[d])
									ds_list_add(temp_redes[d], temp_edificio.red[d])
							}
						}
					}
				//Detectar conexiones por portales
				if index = 10{
					if capa > 0 and bool_edificio[capa - 1][# a, b]{
						var temp_edificio = id_edificio[capa - 1][# a, b]
						if temp_edificio.index = 10 and not ds_list_contains(temp_redes[d], temp_edificio.red[d])
							ds_list_add(temp_redes[d], temp_edificio.red[d])
					}
					if capa < array_length(background) - 1 and bool_edificio[capa + 1][# a, b]{
						var temp_edificio = id_edificio[capa + 1][# a, b]
						if temp_edificio.index = 10 and not ds_list_contains(temp_redes[d], temp_edificio.red[d])
							ds_list_add(temp_redes[d], temp_edificio.red[d])
					}
				}
			}
			var red = null_red
			//Crear red
			for(var d = array_length(recurso_nombre) - 1; d >= 0; d--)
				if edificio_colores[index, d]{
					if ds_list_empty(temp_redes[d]){
						red = {
							edificios : ds_list_create(),
							edificios_index : [],
							base : base,
							recurso : d,
							produccion : 0,
							consumo : 0,
							eficiencia : 0
						}
						repeat(array_length(edificio_nombre)){
							var temp_edificio_list = ds_list_create()
							ds_list_add(temp_edificio_list, null_edificio)
							ds_list_clear(temp_edificio_list)
							array_push(red.edificios_index, temp_edificio_list)
						}
						ds_list_add(redes, red)
						ds_list_add(redes_recurso[d], red)
					}
					else{
						red = temp_redes[d][|0]
						//Combinar redes
						if ds_list_size(temp_redes[d]) > 1{
							for(var c = 1; c < ds_list_size(temp_redes[d]); c++){
								var temp_red = temp_redes[d][|c]
								for(var e = 0; e < ds_list_size(temp_red.edificios); e++){
									var temp_edificio = temp_red.edificios[|e]
									temp_edificio.red[d] = red
									ds_list_add(red.edificios, temp_edificio)
									ds_list_add(red.edificios_index[temp_edificio.index], temp_edificio)
								}
								red.produccion += temp_red.produccion
								red.consumo += temp_red.consumo
								if temp_red.base
									base = true
								ds_list_remove(redes, temp_red)
								ds_list_remove(redes_recurso[d], temp_red)
								ds_list_destroy(temp_red.edificios)
							}
						}
					}
					ds_list_add(red.edificios, edificio)
					ds_list_add(red.edificios_index[edificio.index], edificio)
					edificio.red[d] = red
					if base
						red.base = true
					ds_list_destroy(temp_redes[d])
					flag_update_eficiencia = true
				}
			return true
		}
		return false
	}
}