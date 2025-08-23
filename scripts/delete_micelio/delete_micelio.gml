function delete_micelio(a, b, capa){
	with control{
		bool_refresh_layer[capa] = true
		if micelio[capa][# a, b] > 0{
			var next_x = [-1, 0, 1, 0], next_y = [0, -1, 0, 1]
			ds_grid_set(micelio[capa], a, b, 0)
			ds_grid_set(micelio_subsprite[capa], a, b, 0)
			ds_grid_set(micelio_tick[capa], a, b, 0)
			for(var c = 0; c < 4; c++){
				var aa = a + next_x[c], bb = b + next_y[c]
				if aa >= 0 and bb >= 0 and aa < xsize and bb < ysize and micelio[capa][# aa, bb] > 0
					ds_grid_add(micelio_subsprite[capa], aa, bb, -(power(2, (4 - c) mod 4)))
			}
			micelio_muerto++
			for(var c = array_length(background) - 1; c >= 0; c--)
				for(var d = 0; d < xsize; d++)
					for(var e = 0; e < ysize; e++)
						if micelio[c][# d, e] > 0{
							return
						}
			menu = 11
			tiempo = image_index / 60
		}
	}
}