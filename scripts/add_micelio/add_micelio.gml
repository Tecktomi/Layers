function add_micelio(a, b, capa, portal = false){
	with control{
		var next_x = [-1, 0, 1, 0], next_y = [0, -1, 0, 1]
		if a >= 0 and b >= 0 and a < xsize and b < ysize and micelio[capa][# a, b] < 1 and (image_index = 0 or (image_index - micelio_tick[capa][# a, b]) / 60 > 10){
			//Destruir edificios
			if bool_edificio[capa][# a, b]{
				var edificio = id_edificio[capa][# a, b]
				if edificio.index = 0{
					show_message("Has Perdido\\El Micelio ha llegado a la base")
					game_restart()
				}
				//Mover micelio a travez de portales
				if not portal and edificio.index = 10{
					if capa > 0 and bool_edificio[capa - 1][# a, b] and id_edificio[capa - 1][# a, b].index = 10
						for(var c = 0; c <= 3; c++)
							add_micelio(a + next_x[c], b + next_y[c], capa - 1, true)
					if capa < array_length(background) - 1 and bool_edificio[capa + 1][# a, b] and id_edificio[capa + 1][# a, b].index = 10
						for(var c = 0; c <= 3; c++)
							add_micelio(a + next_x[c], b + next_y[c], capa + 1, true)
				}
				if edificio.index != 10
					delete_edificio(a, b, capa)
			}
			//Crecer micelio
			if id_edificio[capa][# a, b].index != 10{
				ds_grid_add(micelio[capa], a, b, 1)
				ds_grid_set(micelio_tick[capa], a, b, image_index)
				if micelio[capa][# a, b] = 1
					for(var c = 0; c <= 3; c++){
						var aa = a + next_x[c], bb = b + next_y[c]
						if aa >= 0 and bb >= 0 and aa < xsize and bb < ysize and micelio[capa][# aa, bb] > 0{
							ds_grid_add(micelio_subsprite[capa], a, b, power(2, (6 - c) mod 4))
							ds_grid_add(micelio_subsprite[capa], aa, bb, power(2, (4 - c) mod 4))
						}
					}
			}
		}
	}
}