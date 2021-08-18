/// @description Insert description here
// You can write your code in this editor
if(ReadBeatMapFromFile("default.beat") == false){
	data = {
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
