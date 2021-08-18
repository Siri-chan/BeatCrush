
for(i = 0; i < array_length(global.beatmap.notes); i++){
	if (global.beatmap.notes[i].time >= (get_timer() - startTime)/1000){
		continue;
	}
	var note = instance_create_layer(x + (global.beatmap.notes[i].position * 71.5), y, "Instances", o_note);
	note.position = global.beatmap.notes[i].position;
	with (note){
		var colors = [c_fuchsia, c_yellow, c_green, c_red, c_blue, c_orange];
		image_blend = colors[position];	
	}
} 

lastStep = get_timer()