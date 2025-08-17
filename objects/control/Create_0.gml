randomize()
cursor = cr_arrow
xsize = 80
ysize = 40
build_select = 0
build_x = 0
build_y = 0
micelio_inteligente = false
micelio_iteraciones = 10
modo_hacker = false
last_path = 1
flag_update_eficiencia = false
menu = 1
background = [undefined, undefined, undefined]
current_layer = 0
total_micelios = 3
total_portales = 4
valor_edificios = 2
deslizante_index = 0
layer_color_background = [make_color_rgb(255, 127, 127), make_color_rgb(127, 255, 127), make_color_rgb(127, 127, 255)]
layer_color_recurso = [c_red, c_green, c_blue]
edificio_nombre = []
edificio_sprite = []
edificio_precio = []
edificio_colores = []
recurso_nombre = ["Rojo", "Verde", "Azul", "Amarillo", "Magenta", "Cian", "Blanco"]
recurso_color = [c_red, c_green, c_blue, c_yellow, c_fuchsia, c_aqua, c_white]
for(var a = array_length(recurso_nombre) - 1; a >= 0; a--)
	rss[a] = 0
rss[0] = 10
function def_edificio (nombre, sprite = spr_base, precio = 0, colores = [0]){
	array_push(edificio_nombre, string(nombre))
	array_push(edificio_sprite, sprite)
	array_push(edificio_precio, precio)
	var temp_colores = [false, false, false, false, false, false, false, false]
	for(var a = 0; a < array_length(colores); a++)
		temp_colores[colores[a]] = true
	array_push(edificio_colores, temp_colores)
}
def_edificio("Base", spr_base, 0, [0, 1, 2, 3, 4, 5, 6])
def_edificio("Camino Rojo", spr_camino, 0, [0])
def_edificio("Camino Verde", spr_camino, 0, [1])
def_edificio("Camino Azul", spr_camino, 0, [2])
def_edificio("Camino Amarillo", spr_camino, 0, [3])
def_edificio("Camino Magenta", spr_camino, 0, [4])
def_edificio("Camino Cian", spr_camino, 0, [5])
def_edificio("Camino Blanco", spr_camino, 0, [6])
//8
def_edificio("Extractor Rojo", spr_extractor_rojo, 0, [0])
def_edificio("Extractor Verde", spr_extractor_verde, 0, [1])
def_edificio("Tunel", spr_tunel, 6, [0, 1, 2, 3, 4, 5, 6])
//11
def_edificio("Forja Amarilla", spr_forja_amarillo, 1, [0, 1, 3])
def_edificio("Forja Magenta", spr_forja_magenta, 2, [0, 2, 4])
def_edificio("Forja Cian", spr_forja_cian, 2, [1, 2, 5])
//14
def_edificio("Taladro Mejorado Rojo", spr_taladro_mejorado_rojo, 3, [0])
def_edificio("Taladro Mejorado Verde", spr_taladro_mejorado_verde, 3, [0, 1])
def_edificio("Taladro Mejorado Azul", spr_taladro_mejorado_azul, 3, [0, 2])
//17
def_edificio("Fábrica Blanca", spr_fabrica_blanca, 4, [3, 4, 5, 6])
def_edificio("Fábrica de Drones", spr_cian, 5, [5])
null_edificio = {
	a : 0,
	b : 0,
	capa : 0,
	index : 0,
	red : [],
	subsprite : 0,
	produccion : 0
}
null_red = {
	edificios : ds_list_create(),
	edificios_index : [],
	base : false,
	recurso : 0,
	produccion : 0,
	consumo : 0,
	eficiencia : 0
}
ds_list_add(null_red.edificios, null_edificio)
ds_list_clear(null_red.edificios)
var temp_edificios_list = ds_list_create()
ds_list_add(temp_edificios_list, null_edificio)
ds_list_clear(temp_edificios_list)
ds_list_destroy(temp_edificios_list)
array_push(null_red.edificios_index, temp_edificios_list)
array_pop(null_red.edificios_index)
redes = ds_list_create()
ds_list_add(redes, null_red)
ds_list_clear(redes)
redes_recurso = []
repeat(array_length(recurso_nombre)){
	var temp_red_list = ds_list_create()
	ds_list_add(temp_red_list, null_red)
	ds_list_clear(temp_red_list)
	array_push(redes_recurso, temp_red_list)
	array_push(null_edificio.red, null_red)
}
//Drones
null_dron = {
	a : 0,
	b : 0,
	capa : 0,
	live : 0,
	target_x : 0,
	target_y : 0,
	vel_x : 0,
	vel_y : 0
}
drones = []
repeat(array_length(background)){
	var temp_dron_list = ds_list_create()
	ds_list_add(temp_dron_list, null_dron)
	ds_list_clear(temp_dron_list)
	array_push(drones, temp_dron_list)
}
//Definición de mundo
for(var c = 0; c < array_length(background); c++){
	var temp_recurso = ds_grid_create(xsize, ysize)
	ds_grid_clear(temp_recurso, false)
	recurso[c] = temp_recurso
	var temp_bool_edificio = ds_grid_create(xsize, ysize)
	ds_grid_clear(temp_bool_edificio, false)
	bool_edificio[c] = temp_bool_edificio
	var temp_id_edificio = ds_grid_create(xsize, ysize)
	ds_grid_clear(temp_id_edificio, null_edificio)
	id_edificio[c] = temp_id_edificio
	var temp_micelio = ds_grid_create(xsize, ysize)
	ds_grid_clear(temp_micelio, 0)
	micelio[c] = temp_micelio
	var temp_micelio_subsprite = ds_grid_create(xsize, ysize)
	ds_grid_clear(temp_micelio_subsprite, 0)
	micelio_subsprite[c] = temp_micelio_subsprite
	var temp_micelio_tick = ds_grid_create(xsize, ysize)
	ds_grid_clear(temp_micelio_tick, 0)
	micelio_tick[c] = temp_micelio_tick
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