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
		draw_text(room_width/3, (room_height/9) * 3.5, "Best Combo: " + string(global.maxCombo - 1));
		draw_text(room_width/3, (room_height/9) * 4, "Perfect: " + string(global.perfects));
		draw_text(room_width/3, (room_height/9) * 4.5, "Good: " + string(global.goods));
		draw_text(room_width/3, (room_height/9) * 5, "OK: " + string(global.oks));
		draw_text(room_width/3, (room_height/9) * 5.5, "Misses: " + string(((array_length(global.beatmap.notes) - global.oks) - global.goods) - global.perfects)); //this is still super scuffed, better than using the real miss tracker lol
		draw_text(room_width/3, (room_height/9) * 6, "Accuracy: " + string(accuracy) + "%");
		draw_text(room_width/3, (room_height/9) * 6.5, "Score Percentage: (currently broken) " + string(scorePercent) + "%");
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
		draw_sprite(i_key_enter, 0, room_width - 100, (room_height/9) * 8)
	break;
	case rm_beatmap_idx:
		/*
		for(i = 0; i < array_length(mapList); i++){
			show_debug_message(mapList[i]);
		}
		*/
		var len = array_length(mapList);
		if(len == 1){
			global.nxtMap = mapList[0];
			//return;
		}
		var pg = floor(cur_pos/10)
		draw_set_font(csans);
		draw_set_color(c_blue);
		draw_set_halign(fa_center);
		if(mapList[(pg * 10)] == ""){
			cur_pos--;
			return;
		}
		/*
		draw_text(room_width/3, (room_height/15) * 3.5, mapList[(pg * 10)]);
		if(mapList[1 + (pg * 10)] != ""){
		draw_text(room_width/3, (room_height/15) * 4, mapList[1 + (pg * 10)]);
		if(mapList[1 + (pg * 10)] != ""){
		draw_text(room_width/3, (room_height/15) * 4.5, mapList[2 + (pg * 10)]);
		if(mapList[1 + (pg * 10)] != ""){
		draw_text(room_width/3, (room_height/15) * 5, mapList[3 + (pg * 10)]);
		if(mapList[1 + (pg * 10)] != ""){
		draw_text(room_width/3, (room_height/15) * 5.5, mapList[4 + (pg * 10)]);
		if(mapList[1 + (pg * 10)] != ""){
		draw_text(room_width/3, (room_height/15) * 6, mapList[5 + (pg * 10)]);
		if(mapList[1 + (pg * 10)] != ""){
		draw_text(room_width/3, (room_height/15) * 6.5, mapList[6 + (pg * 10)]);
		if(mapList[1 + (pg * 10)] != ""){
		draw_text(room_width/3, (room_height/15) * 7, mapList[7 + (pg * 10)]);
		if(mapList[1 + (pg * 10)] != ""){
		draw_text(room_width/3, (room_height/15) * 7.5, mapList[8 + (pg * 10)]);
		if(mapList[1 + (pg * 10)] != ""){
		draw_text(room_width/3, (room_height/15) * 8, mapList[9 + (pg * 10)]);
		}}}}}}}}} //i should *probably* do this in a for loop
		*/
		for(i = 0; i < 10; i++){
			try{
				if(mapList[i + (pg * 10)] != ""){
					if(cur_pos % 10 == i) draw_set_color(c_yellow) else draw_set_color(c_blue)
					draw_text(room_width/2, (room_height/15) * ((i * 0.75) + 3.5), mapList[i + (pg * 10)]);
					//eventually draw this to the side with info preview live update
				}
			} catch (e){
				break;
			}
		}
		draw_set_color(c_blue)
		draw_set_halign(fa_left);
		draw_text(room_width/2, (room_height/15) * ((i * 0.75) + 3.5), "Page: " + string(pg + 1) + "/" + string(floor(len/10) + 1));
		global.nxtMap = mapList[cur_pos];
	break;
	case rm_beatmap_info:
		draw_set_font(csans);
		draw_set_color(c_red);
		draw_set_halign(fa_center)
		if(global.beatmap.version != MAP_VER){
			draw_text(room_width / 2, room_height / 10,
				"Beatmap Version does not match current version {" + string(MAP_VER) + "} of BeatCrush. " +
				"Attempting Backwards compatability.");
			if(global.beatmap.version < MAP_VER){
				//Back-Compatibility
				switch(global.beatmap.version){
					case 1:
						global.beatmap.artist = "Unknown Artist";
						global.beatmap.mapper = "Unknown Mapper";
						global.beatmap.contributors = [""];
					case 2: 
						global.beatmap.textSpeed = 0.75;
						global.beatmap.textColor = c_green;
						global.beatmap.textShadow = c_black;
					break;
					default:
					draw_text(room_width / 2, room_height / 10 * 9,
						"Beatmap is Not Compatible with Current Version of BeatCrush," + 
						"and Backwards Compatibility Checks Failed." +
						"Delete the Map and restart the Game to Regenerate the Deafult BeatMap Set," +
						"or Contact the Mapper to Update the Map.");
					break;
				}
				return;
			}
			draw_text(room_width / 2, room_height / 10 * 9,"Beatmap is Written in a Newer Version of BeatCrush. " + 
					"Check for Updates, or Change the Beatmap Version in the *.beat file." +
					"The Second Method may cause Issues and for the map to not play as intended."+
					"and I am not liable if such an issue occurs.");
		}
		draw_set_color(c_blue);
		draw_set_halign(fa_center);
		draw_text(room_width/2, room_height / 10 * 3, "Song: " + global.beatmap.title)
		draw_text(room_width/2, room_height / 10 * 4, "Artist: " + global.beatmap.artist)
		draw_text(room_width/2, room_height / 10 * 5, "Mapper: " + global.beatmap.mapper)
		draw_text(room_width/2, room_height / 10 * 6, "Approach Rate: " + string(global.beatmap.approachRate))	
		draw_set_halign(fa_left);
		draw_text(12, room_height / 10 * 7, "Contributors: ")
		for(i = 0; i < array_length(global.beatmap.contributors); i++){
			draw_text(room_width/2, room_height / 10 * 7 + (i * 0.5), global.beatmap.contributors[i])	
		}
		draw_set_color(c_blue)
		draw_set_halign(fa_right);
		draw_text(((room_width - 60) - 10), (room_height/9) * 8, "Begin ");
		draw_sprite(i_key_enter, 0, room_width - 60 - 5, (room_height/9) * 8)
	break;
	default:
	instance_destroy();
	break;
}
