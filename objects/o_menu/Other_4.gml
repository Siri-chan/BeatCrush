letterRatings = ["F", "D", "C", "B", "A", "S", "S+", "SS", "SS+", "GODLIKE"];

function GetLetterRating(){
	var noteCount = array_length(global.beatmap.notes);
	//var noteCount = global.misses + global.oks + global.goods + global.perfects;
	var fakeCombo = 1;
	maxScore = 0;
	for(var i = 0; i < noteCount; i++){
		maxScore += 150 * fakeCombo
		fakeCombo++;
	}
		//all notes, full combo, all perfect
	accuracy = (((noteCount - global.misses) / noteCount) * 50) + 50 // also a percentage
	//maybe swap acc and score% around	
	if(score == maxScore && accuracy == 100) return 9;
	
	scorePercent = (score/maxScore) * 100;
	
	if(accuracy < 30 || scorePercent < 25){
		return 0;
	} 
	if(accuracy < 45){
		return 1;
	}
	if(accuracy < 60){
		return 2;	
	}
	if(accuracy < 70){
		return 3;	
	}
	if(accuracy < 85){
		return 4;		
	}
	if(accuracy > 95) { 
		if(scorePercent > 90){
			return 8;
		}
		return 7;
	}
	if(scorePercent > 90){
		return 6;	
	}
	return 5;
}

switch(room){
	case rm_score:
		if(GetLetterRating() == 0) {
			//make background red
		}
		var noteCount = array_length(global.beatmap.notes);
		maxScore = noteCount * (noteCount * 150);
			//all notes, full combo, all perfect
		scorePercent = (score/maxScore) * 100;
		accuracy = ((noteCount - global.misses) / noteCount) / 100 // also a percentage
	break;
	case rm_beatmap_idx:
		global.nxtMap = "";
		cur_pos = 0
		mapList = IndexAllBeatmaps()
	break;
	case rm_beatmap:
		window_set_caption(global.title + " | Now Playing: " + global.nxtMap);
	break;
	case rm_menu:
		window_set_caption(global.title);
	break;
	case rm_beatmap_info:
		function ReadBeatMapFromFile(fileName){
			if(fileName == ""){
				fileName = "nomap.beat"
			}
			show_debug_message("Loading %localappdata%/rhythm/songs/"+ fileName);
			//if (!file_exists("\\songs\\" + fileName)) return false;
			var _json = LoadString("/songs/" + fileName);
			var mapData = json_parse(_json);
			return mapData;
		}
		show_debug_message("Loading %localappdata%/rhythm/songs/"+ global.nxtMap);
		global.beatmap = ReadBeatMapFromFile(global.nxtMap);
		show_debug_message("Load %localappdata%/rhythm/songs/"+ global.nxtMap +" success");
	break;
}
