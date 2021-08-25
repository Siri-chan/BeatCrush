switch(room){
	case rm_menu:
		draw_set_font(csans);
		draw_set_color(c_yellow);
		draw_text(room_width/2 - 50, room_height/2, "Arcade");
		draw_sprite(i_key_enter, 0, room_width/2 + 75, room_height/2)
	break;
	case rm_score:
		draw_set_font(csans);
		draw_set_color(c_yellow);
		draw_text(((room_width/9) * 8) - 150, (room_height/9) * 8, "Back to Menu");
		draw_sprite(i_key_enter, 0, room_width - 60 - 5, (room_height/9) * 8)
	break;
	default:
	instance_destroy();
	break;
}
