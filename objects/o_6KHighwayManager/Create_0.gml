startTime = get_timer();
lastStep = startTime;
noteCount = 0;
score = 0;
combo = 1;
global.maxCombo = 1;
global.misses = 0;
global.perfects = 0;
global.goods = 0;
global.oks = 0;
if(file_exists(working_directory + "/songs/" + global.beatmap.songLoc)){
	global.bgm = audio_create_stream(working_directory + "/songs/" + global.beatmap.songLoc);
} else {
	global.bgm = bgm_default;
}
audio_play_sound(global.bgm, 1, false);
function CheckMapVersion(){
	if(global.beatmap.version != MAP_VER){
		if(global.beatmap.version < MAP_VER){
			//Back-Compatibility
			switch(global.beatmap.version){
				case 1:
					global.beatmap.artist = "Unknown Artist";
					global.beatmap.mapper = "Unknown Mapper";
					global.beatmap.contributors = [];
				case 2: 
					global.beatmap.textSpeed = 0.75;
					global.beatmap.textColor = c_green;
					global.beatmap.textShadow = c_black;
				break;
				default:
				throw("Beatmap is Not Compatible with Current Version of BeatCrush," + 
					"and Backwards Compatibility Checks Failed." +
					"Delete the Map and restart the Game to Regenerate the Deafult BeatMap Set," +
					"or Contact the Mapper to Update the Map.");
				break;
			}
			return;
		}
	}
}
CheckMapVersion();
function CheckText(){
	for(i = 0; i < array_length(global.beatmap.txtbxes); i++){
		if(global.beatmap.txtbxes[i].time >= 0) notesLeft = true;
		if (global.beatmap.txtbxes[i].time >= (get_timer() - startTime)/1000 || global.beatmap.txtbxes[i].time < 0){
			continue;
		}
		var txt = instance_create_layer(0, 0, "Instances", o_text);
		txt.msg = global.beatmap.txtbxes[i].text;
		txt.background_idx = 0;
		/*
		with (txt){
			
		} //*/
		global.beatmap.txtbxes[i].time = -1;
	} 
}
function HandleExistingText(){
	for(i = 0; i < instance_number(o_text)-1; i++){
		var tmp = instance_find(o_text, i);
		with(tmp){
			instance_destroy();
		}
	}
}

function CreateNewNotes(){
	for(i = 0; i < array_length(global.beatmap.notes); i++){
		if(global.beatmap.notes[i].time >= 0) notesLeft = true;
		if (global.beatmap.notes[i].time >= (get_timer() - startTime)/1000 || global.beatmap.notes[i].time < 0){
			continue;
		}
		var note = instance_create_layer(x + (global.beatmap.notes[i].position * 71.5), y, "Instances", o_note);
		note.position = global.beatmap.notes[i].position;
		note.hitSnd = global.beatmap.notes[i].hitSnd;
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
	if(!notesLeft && instance_number(o_note) < 1 && instance_number(o_text) < 1){
		//turn this into a proper function etc
		room = rm_score;
	}
}
//handle decisions (destroy on decision, add $if, etc)
function HandleInput(autoHandle = false){
	if(autoHandle){
		for(i = 0; i < instance_number(o_note); i++){
			var h = instance_find(o_note, i)
			if(h.y <= room_height - 1) { continue; }
			//h.image_blend = c_white
			CheckNoteY(h);
		}
	} 
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
			if (combo > global.maxCombo) global.maxCombo = combo
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
	global.misses++;
	//note is too early, vs note off screen
	if(h.y > 610){
		//play off-screen miss effect
		instance_create_layer(x + (h.position * 71.5), room_height, "Instances", o_miss2)
	} else {
		//play normal miss effect
	}
	// destroy note if off screen
	if(h.y > room_height){
		instance_destroy(h);
	}
	return;
}
function destroyNote(note_id, pts){
	if(pts != 50 && pts != 100 && pts != 150){ pts = 0; }
	switch(pts){
		case 0:
		global.misses++;
		//play miss fx
		break;
		case 50:
		//play 50pts fx
		global.oks++;
		break;
		case 100:
		//play 100pts fx
		global.goods++;
		break;
		case 150:
		//perfect fx
		global.perfects++;
		break;
		default:
		//throw error
		break;
	}
	with(note_id){
		audio_play_sound(hitSnd, 0, false);
		instance_destroy();	
	}
}