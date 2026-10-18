draw_set_font(fn_m6x11);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_gray);

// bowl
if (bowlTapTimeRemaining > 0)
{
    draw_sprite_ext(spr_bowl_tapping_1, 0, bowlStartX, 0, bowlScale, bowlScale, 0, c_white, 1);
}
else 
{
    draw_sprite_ext(spr_bowl_tapping, 0, bowlStartX, 0, bowlScale, bowlScale, 0, c_white, 1);
}

// keys list
var numOfKeys = array_length(keyList);
for (var i = 0; i < numOfKeys; ++i)
{
    draw_set_colour((i == 0) ? c_yellow : c_gray);
    draw_text(keyListStartX + i * keyListSpacing, keyListStartY, keyList[i]);
}

draw_set_colour(c_gray);

// timer
var gameTimeRemaining = max(0, ceil(gameTimeFrames / game_get_speed(gamespeed_fps)));
draw_text(timerTextStartPosition, timerTextStartPosition, "Time: " + string(gameTimeRemaining));

// error
draw_text(errorTextStartX, errorTextStartY, "Error: " + string(totalErrorMatches));
