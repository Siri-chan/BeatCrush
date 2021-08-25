global.beatmap = ReadBeatMapFromFile("default.beat");
startTime = get_timer();
lastStep = startTime;
noteCount = 0;
score = 0;
combo = 1;

function CreateNewNotes(){
for(i = 0; i < array_length(global.beatmap.notes); i++){
	if (global.beatmap.notes[i].time >= (get_timer() - startTime)/1000 || global.beatmap.notes[i].time < 0){
		continue;
	}
	var note = instance_create_layer(x + (global.beatmap.notes[i].position * 71.5), y, "Instances", o_note);
	note.position = global.beatmap.notes[i].position;
	with (note){
		var colors = [c_fuchsia, c_yellow, c_green, c_red, c_blue, c_orange];
		image_blend = colors[position];	
	}
	//TODO hold notes
	//if(global.beatmap.notes[i].holdTime*fps <= 0){
		//negative time shouldnt be redrawn
	global.beatmap.notes[i].time = -1;
	/*} else {
		global.beatmap.notes[i].holdTime-=fps;
	}*/
} 
}
function HandleInput(){
	if (keyboard_check_pressed(ord("Q"))) {
	instance_create_layer(x, 614, "Instances", o_keyPressIndicator)
		for(i = 0; i < instance_number(o_note); i++){
			var h = instance_find(o_note, i)
			if(h.position != 0) { continue; }
			//h.image_blend = c_white
			CheckNoteY(h);
		}
	}
	if (keyboard_check_pressed(ord("W"))){ //these cant be else if bc we handle nore than 1 input per step
		instance_create_layer(x + (71.5), 614, "Instances", o_keyPressIndicator)
		for(i = 0; i < instance_number(o_note); i++){			
			var h = instance_find(o_note, i)
			if(h.position != 1) { continue; }
			//h.image_blend = c_white
			CheckNoteY(h);
		}
	} if (keyboard_check_pressed(ord("E"))){
		instance_create_layer(x + (2 * 71.5), 614, "Instances", o_keyPressIndicator)
		for(i = 0; i < instance_number(o_note); i++){
			var h = instance_find(o_note, i)
			if(h.position != 2) { continue; }
			//h.image_blend = c_white
			CheckNoteY(h);
		}
	} if(keyboard_check_pressed(ord("I"))){
		instance_create_layer(x + (3 * 71.5), 614, "Instances", o_keyPressIndicator)
		for(i = 0; i < instance_number(o_note); i++){
			var h = instance_find(o_note, i)
			if(h.position != 3) { continue; }
			//h.image_blend = c_white
			CheckNoteY(h);
		}
	} if(keyboard_check_pressed(ord("O"))){
		instance_create_layer(x + (4 * 71.5), 614, "Instances", o_keyPressIndicator)
		for(i = 0; i < instance_number(o_note); i++){
			var h = instance_find(o_note, i)
			if(h.position != 4) { continue; }
			//h.image_blend = c_white
			CheckNoteY(h);
		}
	} if (keyboard_check_pressed(ord("P"))){
		instance_create_layer(x + (5 * 71.5), 614, "Instances", o_keyPressIndicator)
		for(i = 0; i < instance_number(o_note); i++){
			var h = instance_find(o_note, i)
			if(h.position != 5) { continue; }
			//h.image_blend = c_white
			CheckNoteY(h);
			//else
		}
	}
}
function CheckNoteY(h){
	var points = 0;
	//miss but destroy note
	if(h.y >= 400 - h.sprite_yoffset && h.y <= 700 - h.sprite_yoffset){
		//50pts
		if(h.y >= 575 - h.sprite_yoffset && h.y <= 675){
			points = 50
			//ihtsound
			//100pts
			if(h.y >= 575- h.sprite_yoffset && h.y <= 675 - h.sprite_yoffset){
				points = 100
				//perfect
				if(h.y >= 609 && h.y <= 638 - h.sprite_yoffset){
					points = 150
					//give score based on note pos
					//increase combo
				}
			}
			score += points * combo
			combo++;
		} else {
			combo = 1
		}
		destroyNote(h, points)
		return;
	}
	//miss without destroying note
	//grab 0pts case from destroyNote()
	//break combo
	combo = 1;
	//miss sound
	//play same miss effect
	return;
}
function destroyNote(note_id, pts){
	if(pts != 50 || pts !=  100 || pts != 150){ pts = 0; }
	switch(pts){
		case 0:
		//play miss fx
		break;
		case 50:
		//play 50pts fx
		break;
		case 100:
		//play 100pts fx
		break;
		case 150:
		
		break;
		default:
		//throw error
		break;
	}
	with(note_id){
		instance_destroy();	
	}
}