randomize()
xsize = 80
ysize = 40
build_select = 0
build_x = 0
build_y = 0
background = [undefined, undefined, undefined]
current_layer = 0
layer_color_background = [make_color_rgb(255, 127, 127), make_color_rgb(127, 255, 127), make_color_rgb(127, 127, 255)]
layer_color_recurso = [c_red, c_green, c_blue]
edificio_nombre = ["Base", "Camino", "Célula Roja", "Tunel"]
edificio_sprite = [spr_base, spr_camino, spr_roja, spr_tunel]
recurso_nombre = ["Rojo", "Verde", "Azul"]
for(var a = array_length(recurso_nombre) - 1; a >= 0; a--)
	rss[a] = 0
null_red = {
	edificios : [ds_list_create()],
	base : false,
	produccion : [0]
}
ds_list_add(null_red.edificios[0], [0, 0])
ds_list_clear(null_red.edificios[0])
array_pop(null_red.produccion)
redes = ds_list_create()
ds_list_add(redes, null_red)
ds_list_clear(redes)
for(var c = 0; c < array_length(background); c++){
	recurso[c] = ds_grid_create(xsize, ysize)
	ds_grid_clear(recurso[c], false)
	edificio[c] = ds_grid_create(xsize, ysize)
	ds_grid_clear(edificio[c], -1)
	edificio_subsprite[c] = ds_grid_create(xsize, ysize)
	ds_grid_clear(edificio_subsprite[c], 0)
	edificio_red[c] = ds_grid_create(xsize, ysize)
	ds_grid_clear(edificio_red[c], null_red)
	repeat(4){
		var a = irandom(xsize - 1), b = irandom(ysize - 1)
		repeat(20){
			a = clamp(a + irandom_range(-1, 1), 0, xsize - 1)
			b = clamp(b + irandom_range(-1, 1), 0, ysize - 1)
			ds_grid_set_region(recurso[c], max(a - 1, 0), max(b - 1, 0), min(a + 1, xsize - 1), min(b + 1, ysize - 1), true)
		}
	}
}
for(var a = floor(xsize / 2) - 1; a <= ceil(xsize / 2) + 1; a++)
	for(var b = floor(ysize / 2) - 1; b <= ceil(ysize / 2) + 1; b++)
		add_edificio(0, a, b)
repeat(4){
	var a = irandom(xsize - 1), b = irandom(ysize - 1)
	add_edificio(3, a, b, 0)
	add_edificio(3, a, b, 1)
	a = irandom(xsize - 1)
	b = irandom(ysize - 1)
	add_edificio(3, a, b, 1)
	add_edificio(3, a, b, 2)
}