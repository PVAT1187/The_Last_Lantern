function DrawBar(name, x, y, width, height, currentValue, maxValue, color)
{
    var offset = 25;
    
    var fill = clamp(currentValue / maxValue, 0, 1);
    
    draw_set_colour(c_dkgray);
    draw_rectangle(x, y, x + width, y + height, false);
    
    draw_set_colour(color);
    draw_text(x, y - offset, name);
    draw_rectangle(x, y, x + width * fill, y + height, false);
    
    draw_set_colour(c_white);
}