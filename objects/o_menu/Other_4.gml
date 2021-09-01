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
	accuracy = ((noteCount - global.misses) / noteCount) * 100 // also a percentage
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
}
