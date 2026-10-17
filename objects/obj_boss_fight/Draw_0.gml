// configurate texts
draw_set_font(fn_m6x11);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// draw boss
var bossSprite = variable_struct_get(boss.sprites, bossState);
draw_sprite_ext(bossSprite, 0, bossX, bossY, bossScale, bossScale, 0, c_white, 1);

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

// draw health bars
DrawHealthBar(player.name, playerStartX, startY, width, height, player.hp, player.hpMax, c_blue);
DrawHealthBar(boss.name, bossStartX, startY, width, height, boss.hp, boss.hpMax, c_red);

// draw boxes
draw_sprite_stretched(spr_box, 0, 0, boxY, firstBoxWidth, boxHeight);
draw_sprite_stretched(spr_box, 0, secondBoxX, boxY, secondBoxWidth, boxHeight);

// draw candy bag and # of candies available
draw_sprite_ext(spr_candy_bag, 0, 0, candyBagStartY, 1, 1, 0, c_white, 1);
draw_text(numOfCandiesTextStartX, numOfCandiesTextStartY, player.candy);

// draw action texts in the second box
var numOfActions = array_length(actions);
for (var i = 0; i < numOfActions; ++i)
{
    var action = variable_struct_get(global.actions, actions[i]);
    var textX = x + actionTextXOffset
    var textY = y + actionTextBaseYOffset + i * actionTextYSpacing;
    
    draw_set_colour((i == selectedActionIndex) ? c_yellow : c_gray);
    draw_text(textX, textY, action.name);
}

// draw message text in the first box
draw_set_colour(c_gray);
draw_text_ext(messageTextStartX, messageTextStartY, message, -1, messageTextWrapWidth);