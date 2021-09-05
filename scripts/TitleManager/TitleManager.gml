function TitleManager_Initial(){
	var GAME_TITLES = ["- ", ""]
	global.title = "BeatCrush! " + GAME_TITLES[irandom(array_length(GAME_TITLES))];
}