randomize()
xsize = 80
ysize = 40
build_select = 0
build_x = 0
build_y = 0
micelio_inteligente = false
micelio_iteraciones = 10
modo_hacker = false
last_path = 1
background = [undefined, undefined, undefined]
current_layer = 0
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
def_edificio("Tunel", spr_tunel, 7, [0, 1, 2, 3, 4, 5, 6])
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
	produccion : [0],
	consumo : [0],
	red_color : c_black,
	recurso : 0,
	recurso_produccion : 0,
	recurso_consumo : 0
}
ds_list_add(null_red.edificios, null_edificio)
ds_list_clear(null_red.edificios)
var temp_edificios_list = ds_list_create()
ds_list_add(temp_edificios_list, null_edificio)
ds_list_clear(temp_edificios_list)
ds_list_destroy(temp_edificios_list)
array_push(null_red.edificios_index, temp_edificios_list)
array_pop(null_red.edificios_index)
array_pop(null_red.produccion)
array_pop(null_red.consumo)
redes = ds_list_create()
ds_list_add(redes, null_red)
ds_list_clear(redes)
repeat(array_length(recurso_nombre))
	array_push(null_edificio.red, null_red)
#region tutorial
tutorial = true
tutorial_current = 0
tutorial_text = [
	"Bienvenidx a LAYERS, un juego de fábricas un poco distinto\n\n" +
	"Lo primero que debes aprender es a construir extractores y caminos\n" +
	"Presiona 2 para construir un extractor, luego haz clic en algún terreno con recurso Rojo\n" +
	"Ahora presiona 1 y construye un camino que conecte el extractor con la base blanca del centro\n" +
	"Esto generará constantemente recurso Rojo. Mientras más extractores conectados, más producirás.",
	
	"Ahora que sabes extraer Rojo, vamos a movernos a otra capa\n" +
	"Usando la flechas Arriba y Abajo puedes moverte entre las tres capas que hay\n" +
	"Las capas se conectan por medio de los portales multicolor, al conectar un camino a uno de estos, los recursos se mueven entre ellas\n" +
	"Es importante tener en cuenta que cada tipo de recurso necesita su propio camino, puedes alternar el tipo de camino con la rueda del mouse\n" +
	"Construye extractores en la capa Verde y conctamos a la base a travez de un portal.",
	
	"Genial, ahora estás produciendo rojo y verde, lo siguiente es aprender a mezclarlos\n" +
	"Presiona 3 para construir una mezcladora Amarilla\n" +
	"Este edificio necesita que le llegue un flujo de Rojo y Verde para emprezar a producir Amarillo.",
	
	"Lo siguiente son los extractores avanzados, puedes construirlos presionando 4\n" +
	"Estos permiten extraer Azul y son más rápidos, pero necesitan un suministro de Rojo\n" +
	"Construye uno de estos para empezar a extraer Azul.",
	
	"Ahora que tienes los 3 colores básicos, puedes hacer las otras mezcladoras\n" +
	"Alterna usando la rueda del mouse para construir una mezcladora Cian y una Magenta.",
	
	"Por último, usando Amarillo, Cian y Magenta puedes producir Blanco\n" +
	"Presiona 5 para construir la fábrica Blanca definitiva."
]
#endregion
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
	do var a = irandom(xsize - 1), b = irandom(ysize - 1)
	until not bool_edificio[0][# a, b] and not bool_edificio[1][# a, b]
	add_edificio(10, a, b, 0)
	add_edificio(10, a, b, 1)
	do{
		a = irandom(xsize - 1)
		b = irandom(ysize - 1)
	}
	until not bool_edificio[1][# a, b] and not bool_edificio[2][# a, b]
	add_edificio(10, a, b, 1)
	add_edificio(10, a, b, 2)
}
//Micelios iniciales
repeat(5){
	do var a = irandom_range(1, xsize - 2), b = irandom_range(1, ysize - 2), capa = irandom_range(1, array_length(background) - 1)
	until not bool_edificio[capa][# a, b]
	add_micelio(a, b, capa)
	var next_x = [-1, 0, 1, 0], next_y = [0, -1, 0, 1]
	for(var c = 0; c < 4; c++)
		add_micelio(a + next_x[c], b + next_y[c], capa)
}