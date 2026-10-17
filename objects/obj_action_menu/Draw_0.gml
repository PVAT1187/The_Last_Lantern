// configurates text
draw_set_font(fn_m6x11);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_gray);

// draw action texts in the second box
var numOfActions = array_length(actions);
for (var i = 0; i < numOfActions; ++i)
{
    var textX = x + textXOffset
    var textY = y + textBaseYOffset + i * textYSpacing;
    
    if (!isActive)
    {
        draw_set_colour(c_dkgray);
    }
    else
    {
        draw_set_colour((i == selectedActionIndex) ? c_yellow : c_gray);
    }
    
    draw_text(textX, textY, actions[i]);
}

draw_set_colour(c_gray);