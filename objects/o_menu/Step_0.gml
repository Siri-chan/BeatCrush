if(keyboard_check_pressed(vk_return) || keyboard_check_pressed(vk_enter)){
	switch(room){
		case rm_menu:
			room = rm_beatmap_idx;
		break;
		case rm_score:
			audio_stop_sound(global.bgm);
			room = rm_menu;
		break;
		case rm_beatmap_idx:
			//eventually take to map info screen
			room = rm_beatmap;
		break;
	}
}
if(room == rm_beatmap_idx){
	if(keyboard_check_pressed(vk_up)){
		cur_pos--;
	} else if(keyboard_check_pressed(vk_down)){
		cur_pos++;
	}
	if(cur_pos < 0) { 
		cur_pos = array_length(mapList) - 1;
	} else if(cur_pos >= array_length(mapList)){ 
		cur_pos = 0; 
	}
}