function cargar_escenario(){
	with control{
		var file = get_open_filename("*.txt", game_save_id + "save.txt")
		if file != ""{
			ini_open(file)
			for(var c = 0; c < array_length(background); c++)
				for(var a = 0; a < xsize; a++)
					for(var b = 0; b < ysize; b++){
						ds_grid_set(recurso[c], a, b, ini_key_exists($"rss{c}", $"{a},{b}"))
						if ini_key_exists($"edificios{c}", $"{a},{b}")
							add_edificio(10, a, b, c)
					}
			ini_close()
		}
	}
}