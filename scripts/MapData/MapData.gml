//constant
#macro MAP_VER 3
function CreateBeatMapFromData(fileName, data){
	var errorCode = 0;
	if (data.notes == {} || data.txtbxes == {} || data.title == "" || data.songLoc == ""){
		return -1;
	}
	//actually write to file here
	var _json = json_stringify(data)
	SaveString(_json, "/songs/" + fileName)
	return errorCode;
}
function ProcessErrorCodes(return_val) {
	/*Error Codes for Function
		* Error Codes
	 * -1: NO MAP DATA
		* Success
	 *  0: successful, no warnings
		* Non-Fatal Warnings
	 *  1: File Path does not exist. Creating
	 */
	 var non_fatals = ["this will never be seen",]
	 var fatals = ["index 0"]
	 if(return_val > 0)
	 {
		show_debug_message(non_fatals[return_val])	 
		return;
	 }
	 if(return_val == 0)
	 { 
		return;
	 }	
	 show_debug_message(fatals[return_val*-1])
	 return;
}

function SaveString (_string, _filename) {
	var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
	buffer_write(_buffer, buffer_string, _string);
	buffer_save(_buffer, working_directory +  _filename);
	buffer_delete(_buffer);
}


function CreateDefaultMap(){
	var data = {
	version: MAP_VER,
	title: "test",
	artist: "nobody",
	mapper: "Siri",
	contributors: [],
	//only ogg is supported
	//also please use namespace style naing to prevent conflicts
	songLoc: "siri.default.ogg",
	approachRate: 5,
	textSpeed: 0.75,
	textColor: c_green,
	textShadow: c_black,
	notes: [
		{ position: 0, time: 2000, hitSnd: s_hit_none },
		{ position: 4, time: 4000, hitSnd: s_hit_none },
		{ position: 5, time: 4500, hitSnd: s_hit_none },
		{ position: 2, time: 3000, hitSnd: s_hit_clap },
		{ position: 1, time: 6000, hitSnd: s_hit_snare },
		{ position: 3, time: 8000, hitSnd: s_hit_none },
		{ position: 0, time: 8200, hitSnd: s_hit_none },
		{ position: 1, time: 9000, hitSnd: s_hit_none },
		{ position: 4, time: 9100, hitSnd: s_hit_none },
		{ position: 5, time: 9400, hitSnd: s_hit_none },
		{ position: 2, time: 10000, hitSnd: s_hit_none },
		{ position: 3, time: 11000, hitSnd: s_hit_none },
		{ position: 1, time: 11400, hitSnd: s_hit_none },
		{ position: 0, time: 14000, hitSnd: s_hit_none }
	],
	txtbxes: [
		{ text: "test", time: 7000, decision: []},
		//text timer ends when next text appears, add $notext for it to not display a textbox
		{ text: "$notext", time: 9500, decision: ["Yes", "No"]}
	]
	}
	ProcessErrorCodes(CreateBeatMapFromData("siri.default.beat", data));
	//write the ogg that needs to be there
	return;
}
function LoadString (_filename) {
	var _buffer = buffer_load(working_directory + _filename);
	var _string = buffer_read(_buffer, buffer_string);

	buffer_delete(_buffer);
	return _string;
}

function IndexAllBeatmaps(){
	files = []
	if !directory_exists(working_directory + "/songs/")
    {
		return "";
    }
	var file = file_find_first(working_directory + "/songs/*.beat", 0);
	for (i = 0; 0 > -1; i++){
		if(file == "") break;
		files[i] = file;
		file = file_find_next();
	}
	file_find_close();
	return files;
}