function refresh_layer(capa){
	with control{
		if background_edificio[capa] != undefined{
			sprite_delete(background_edificio[capa])
			background_edificio[capa] = undefined
		}
		if minimapa_sprite[capa] != undefined{
			sprite_delete(minimapa_sprite[capa])
			minimapa_sprite[capa] = undefined
		}
	}
}