if(keyboard_check_pressed(vk_return) || keyboard_check_pressed(vk_enter)){
	switch(room){
		case rm_menu:
			room = rm_beatmap;
		break;
		case rm_score:
			room = rm_menu;
		break;
	}
}