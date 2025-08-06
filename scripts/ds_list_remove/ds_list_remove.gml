function ds_list_remove(lista, elemento){
	var a = ds_list_find_index(lista, elemento)
	if a = -1
		show_error($"ds_list_remove({lista}, {elemento})", true)
	else
		ds_list_delete(lista, a)
}