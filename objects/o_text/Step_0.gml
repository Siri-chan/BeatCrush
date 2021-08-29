lerpProgress += (1-lerpProgress) / 50; //TODO BM specific lerp speed
textProgress += global.beatmap.textSpeed;
x1 = lerp(x1, targetx1, lerpProgress);
x2 = lerp(x2, targetx2, lerpProgress);
/*
if(keyboard_check_pressed(vk_space)){ //testinput for now, instntiate from manager, then call a function from elsewhere in future
	var msgLength = string_length(msg)
	if(textProgress >= msgLength){
		instance_destroy();	
	}
	//no dialogue fastforward in a timing based game
}
*/
if(!dollarHandled){
	HandleDollar();
	dollarHandled = true;
}