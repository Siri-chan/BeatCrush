//default mapdata looks like this
/*
	var data = {
	title: "test",
	//only ogg is supported
	songLoc: "song.ogg",
	approachRate: 3.5,
	notes: [
		{ position: 0, time: 2000 },
		{ position: 4, time: 4000 }
	],
	dialogue: [
		{ text: "test", time: 7000, decision: [] }
	]
	}
*/
function CreateBeatMapFromData(fileName, data){
	var errorCode = 0;
	if (data.notes == {} || data.dialogue == {} || data.title == "" || data.songLoc == ""){
		return -1;
	}
	//actually write to file here
	var _json = json_stringify(data)
	SaveString(_json, "\\songs\\" + fileName)
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
function ReadBeatMapFromFile(fileName){
	if(fileName == ""){
		fileName = "nomap.beat"
	}
	//if (!file_exists("\\songs\\" + fileName)) return false;
	var _json = LoadString("\\songs\\" + fileName);
	var mapData = json_parse(_json);
	return mapData;
}

function SaveString (_string, _filename) {
	var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
	buffer_write(_buffer, buffer_string, _string);
	buffer_save(_buffer, working_directory +  _filename);
	buffer_delete(_buffer);
}


function CreateDefaultMap(){
	var data = {
	title: "test",
	//only ogg is supported
	songLoc: "song.ogg",
	approachRate: 5,
	notes: [
		{ position: 0, time: 2000 },
		{ position: 4, time: 4000 },
		{ position: 5, time: 4500 },
		{ position: 2, time: 3000 },
		{ position: 1, time: 6000 },
		{ position: 3, time: 8000 },
		{ position: 0, time: 8200 },
		{ position: 1, time: 9000 },
		{ position: 4, time: 9100 },
		{ position: 5, time: 9400 },
		{ position: 2, time: 10000 },
		{ position: 3, time: 11000 },
		{ position: 1, time: 11400 },
		{ position: 0, time: 14000 }
	],
	dialogue: [
		{ text: "test", time: 7000, decision: [] }
	]
	}
	ProcessErrorCodes(CreateBeatMapFromData("default.beat", data));
	return;
}
function LoadString (_filename) {
	var _buffer = buffer_load(working_directory + _filename);
	var _string = buffer_read(_buffer, buffer_string);

	buffer_delete(_buffer);
	return _string;
}
