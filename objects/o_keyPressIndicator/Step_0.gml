/// @description Insert description here
// You can write your code in this editor
if(!opaque){
	image_alpha += 0.05;
	if(image_alpha >= 1.05){
		opaque = true;
	}
	return;
}
image_alpha -= 0.01;