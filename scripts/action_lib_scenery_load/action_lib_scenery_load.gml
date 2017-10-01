/// action_lib_scenery_load(filename)
/// @arg filename

if (history_undo)
{
	with (history_data)
		history_destroy_loaded()
}
else
{
	var fn, hobj = null;
	
	if (history_redo)
		fn = history_data.filename
	else
	{
		fn = argument0
		hobj = history_set(action_lib_scenery_load)
	}
	
	var res = new_res(fn, "schematic");
	res.loaded = !res.replaced
	with (res)
		res_load()
		
	with (new(obj_template))
	{
		sortlist_add(app.lib_list, id)
		loaded = true
		type = "scenery"
		scenery = res
		scenery.count++
		block_tex = mc_res
		mc_res.count++
		temp_update_display_name()
		with (temp_animate())
			loaded = true
	}
	
	with (hobj)
	{
		filename = fn
		history_save_loaded()
	}
}

project_reset_loaded()
tl_update_list()
tl_update_matrix()
