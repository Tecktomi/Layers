function draw_sprite_uwu(sprite, subimage, x, y){
	draw_sprite(sprite, subimage, x, y)
	draw_rectangle(x, y, x + sprite_get_width(sprite) - 1, y + sprite_get_height(sprite) - 1, true)
	return [sprite_get_width(sprite), sprite_get_height(sprite)]
}