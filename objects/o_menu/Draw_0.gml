switch(room){
	case rm_menu:
		draw_set_font(csans);
		draw_set_halign(fa_left);
		draw_set_color(c_yellow);
		draw_text(room_width/2 - 50, room_height/2, "Arcade");
		draw_sprite(i_key_enter, 0, room_width/2 + 75, room_height/2)
	break;
	case rm_score:
		draw_set_font(csans);
		draw_set_color(c_aqua);
		draw_set_halign(fa_center);
		draw_text(room_width/3, (room_height/9) * 3, "Score: " + string(score));
		draw_text(room_width/3, (room_height/9) * 3.5, "Best Combo: " + string(global.maxCombo));
		draw_text(room_width/3, (room_height/9) * 4, "Perfect: " + string(global.perfects));
		draw_text(room_width/3, (room_height/9) * 4.5, "Good: " + string(global.goods));
		draw_text(room_width/3, (room_height/9) * 5, "OK: " + string(global.oks));
		draw_text(room_width/3, (room_height/9) * 5.5, "Misses: " + string(((array_length(global.beatmap.notes) - global.oks) - global.goods) - global.perfects)); //this is still super scuffed, better than using the real miss tracker lol
		draw_text(room_width/3, (room_height/9) * 6, "Accuracy: " + string(accuracy) + "%");
		draw_text(room_width/3, (room_height/9) * 6.5, "Score Percentage: " + string(scorePercent) + "%");
		draw_text(room_width/3, (room_height/9) * 7, "Max Score: " + string(maxScore));
		
		draw_set_halign(fa_left);
		draw_set_color(c_green);
		draw_text((room_width / 3) * 2, room_height / 2 - 25, "Rating: ");
		draw_set_font(csans_lrg);
	 	draw_text((room_width / 3) * 2, room_height / 2, letterRatings[GetLetterRating()]);
		draw_set_halign(fa_center);
		draw_set_font(csans);
		draw_set_color(c_yellow);
		draw_text(((room_width/9) * 8) - 150, (room_height/9) * 8, "Back to Menu");
		draw_sprite(i_key_enter, 0, room_width - 60 - 5, (room_height/9) * 8)
	break;
	default:
	instance_destroy();
	break;
}
