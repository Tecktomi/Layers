randomize()
xsize = 80
ysize = 40
build_select = 0
build_x = 0
build_y = 0
micelio_inteligente = false
micelio_iteraciones = 10
modo_hacker = false
background = [undefined, undefined, undefined]
current_layer = 0
layer_color_background = [make_color_rgb(255, 127, 127), make_color_rgb(127, 255, 127), make_color_rgb(127, 127, 255)]
layer_color_recurso = [c_red, c_green, c_blue]
edificio_nombre = ["Base", "Camino", "Extractor", "Tunel", "Forja"]
edificio_sprite = [spr_base, spr_camino, spr_roja, spr_tunel, spr_azul]
edificio_precio = [-1, -1, 0, -1, 1]
recurso_nombre = ["Rojo", "Verde", "Azul"]
for(var a = array_length(recurso_nombre) - 1; a >= 0; a--)
	rss[a] = 0
null_edificio = {
	a : 0,
	b : 0,
	capa : 0,
	index : 0,
	red : undefined,
	subsprite : 0
}
null_red = {
	edificios : ds_list_create(),
	base : false,
	produccion : [0],
	consumo : [0]
}
ds_list_add(null_red.edificios, null_edificio)
ds_list_clear(null_red.edificios)
array_pop(null_red.produccion)
array_pop(null_red.consumo)
redes = ds_list_create()
ds_list_add(redes, null_red)
ds_list_clear(redes)
null_edificio.red = null_red
//Definición de mundo
for(var c = 0; c < array_length(background); c++){
	recurso[c] = ds_grid_create(xsize, ysize)
	ds_grid_clear(recurso[c], false)
	bool_edificio[c] = ds_grid_create(xsize, ysize)
	ds_grid_clear(bool_edificio[c], false)
	id_edificio[c] = ds_grid_create(xsize, ysize)
	ds_grid_clear(id_edificio[c], null_edificio)
	micelio[c] = ds_grid_create(xsize, ysize)
	ds_grid_clear(micelio[c], 0)
	micelio_subsprite[c] = ds_grid_create(xsize, ysize)
	ds_grid_clear(micelio_subsprite[c], 0)
	//Recursos
	repeat(4){
		var a = irandom(xsize - 1), b = irandom(ysize - 1)
		repeat(20){
			a = clamp(a + irandom_range(-1, 1), 0, xsize - 1)
			b = clamp(b + irandom_range(-1, 1), 0, ysize - 1)
			ds_grid_set_region(recurso[c], max(a - 1, 0), max(b - 1, 0), min(a + 1, xsize - 1), min(b + 1, ysize - 1), true)
		}
	}
}
//Base
for(var a = floor(xsize / 2) - 1; a <= ceil(xsize / 2) + 1; a++)
	for(var b = floor(ysize / 2) - 1; b <= ceil(ysize / 2) + 1; b++)
		add_edificio(0, a, b)
//Portales
repeat(4){
	do
		var a = irandom(xsize - 1), b = irandom(ysize - 1)
	until not bool_edificio[0][# a, b] and not bool_edificio[1][# a, b]
	add_edificio(3, a, b, 0)
	add_edificio(3, a, b, 1)
	do{
		a = irandom(xsize - 1)
		b = irandom(ysize - 1)
	}
	until not bool_edificio[1][# a, b] and not bool_edificio[2][# a, b]
	add_edificio(3, a, b, 1)
	add_edificio(3, a, b, 2)
}
//Micelios iniciales
repeat(1){
	do
		var a = irandom_range(1, xsize - 2), b = irandom_range(1, ysize - 2), capa = irandom(array_length(background) - 1)
	until not bool_edificio[capa][# a, b]
	ds_grid_set(micelio[capa], a, b, 2)
	ds_grid_set(micelio[capa], a + 1, b, 1)
	ds_grid_set(micelio_subsprite[capa], a + 1, b, 4)
	ds_grid_set(micelio[capa], a, b + 1, 1)
	ds_grid_set(micelio_subsprite[capa], a, b + 1, 2)
	ds_grid_set(micelio[capa], a - 1, b, 1)
	ds_grid_set(micelio_subsprite[capa], a - 1, b, 1)
	ds_grid_set(micelio[capa], a, b - 1, 1)
	ds_grid_set(micelio_subsprite[capa], a, b - 1, 8)
}