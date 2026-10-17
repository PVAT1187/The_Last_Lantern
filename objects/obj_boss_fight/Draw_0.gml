// configurate texts
draw_set_font(fn_m6x11);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// draw boss
var bossSprite = variable_struct_get(boss.sprites, bossState);
draw_sprite_ext(bossSprite, 0, bossX, bossY, bossScale, bossScale, 0, c_white, 1);

// draw health bars
function DrawHealthBar(name, x, y, width, height, currentHP, maxHP, color)
{
    var offset = 25;
    
    var fill = clamp(currentHP / maxHP, 0, 1);
    
    draw_set_colour(c_dkgray);
    draw_rectangle(x, y, x + width, y + height, false);
    
    draw_set_colour(color);
    draw_text(x, y - offset, name);
    draw_rectangle(x, y, x + width * fill, y + height, false);
    
    draw_set_colour(c_white);
}

DrawHealthBar(player.name, playerStartX, startY, width, height, player.hp, player.hpMax, c_blue);
DrawHealthBar(boss.name, bossStartX, startY, width, height, boss.hp, boss.hpMax, c_red);

// draw candy bag and # of candies available
draw_sprite_ext(spr_candy_bag, 0, 0, candyBagStartY, 1, 1, 0, c_white, 1);
draw_text(numOfCandiesTextStartX, numOfCandiesTextStartY, player.candy);