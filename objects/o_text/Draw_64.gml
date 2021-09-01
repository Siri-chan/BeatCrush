NineSliceBoxStretched(i_txtboxbg, x1, y1, x2, y2, background_idx);
draw_set_font(txt_dialogue_bot); //set this when setting which girl
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(global.beatmap.textShadow); //bm specific txt shadow, maybe just determine between b/w

var txtYBuffer = 32; //these two should be specific as well
var txtShadowXDistance = 0.5;
var txtShadowYDistance = -1.75;

var print = string_copy(msg, 1, textProgress);
draw_text((x1 + x2)/2, y1 + txtYBuffer, print)
draw_set_color(global.beatmap.textColor); 
draw_text(((x1 + x2)/2) + txtShadowXDistance, y1 + txtYBuffer + txtShadowYDistance, print)