x1 = room_width / 3 * 2;
y1 = room_height / 5 * 4;
x2 = room_width / 3 * 2;
y2 = room_height;

targetx1 = 450;
targetx2 = 1274;

lerpProgress = 0;
textProgress = 0;

dollarHandled = false;

msg = "no beat?"; 
background_idx = 0;
function HandleDollar(){
	show_debug_message(string_copy(msg, 1, 1));
	if(string_copy(msg, 1, 1) == "$"){
		show_debug_message(string_copy(msg, 2, string_length(msg)))
		switch(string_copy(msg, 2, string_length(msg))){
			case "notext":
				instance_destroy();
			break;
		}
	}
}