//mapdata looks like this
/*
data = {
	title: load_file[0],
	songLoc: load_file[1],
	notes: [
		{ position: (0-6), time: (in ms) },
		{ position: (0-6), time: (in ms) }
	],
	dialogue: [
		{ text: "", time: (in ms), decision: ["yes", "no"] (leave empty for no decision)}
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
	/*
	var load_file
	var file = file_text_open_read(fileName);
	var i = 0;
	while(!file_text_eof(file)){
		load_file[i++] = file_text_read_string(file);
	    file_text_readln(file);
	}
	file_text_close(file);
	i = 2;
	var tmpList = []
	while(array_length_1d(load_file) > i){
		 tmpList [i-2] = load_file[i]
		 i++
	}
	mapData =
	{
		title: load_file[0]
		songLoc: load_file[1]
		notes: tmpList
	}
*/
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
	notes: [
		{ position: 0, time: 2000 },
		{ position: 4, time: 4000 }
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
