if (mouse_check_button_pressed(mb_left))
{
    var spriteRightBound = x + sprite_width / 2;
    var spriteLeftBound = x - sprite_width / 2;
    var spriteTopBound = y - sprite_height / 2;
    var spriteBottomBound = y + sprite_height / 2;
    
    if (mouse_x >= spriteLeftBound && mouse_x <= spriteRightBound && mouse_y >= spriteTopBound && mouse_y <= spriteBottomBound)
    {
        show_message("black cat found!");
    }
}