// draw boss
draw_sprite_ext(spr_boss_idle, 0, boss_x, boss_y, boss_scale, boss_scale, 0, c_white, 1);

// draw boxes
draw_sprite_stretched(spr_box, 0, 0, box_y, first_box_width, box_height);
draw_sprite_stretched(spr_box, 0, second_box_x, box_y, second_box_width, box_height);

// configurate texts
draw_set_font(fn_m6x11);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_gray);

// draw action texts
//draw_text(x + text_x_offset, y + 55, "ATTACK");
//draw_text(x + text_x_offset, y + 80, "DEFENSE");
//draw_text(x + text_x_offset, y + 105, "FLEE !!!");
//draw_text(x + text_x_offset, y + 130, "PLEA ???");

var numOfActions = array_length(actions);
for (var i = 0; i < numOfActions; ++i)
{
    var action = actions[i];
    var text_x = x + text_x_offset
    var text_y = y + text_base_y_offset + i * text_y_spacing;
    
    draw_text(text_x, text_y, action.name);
}