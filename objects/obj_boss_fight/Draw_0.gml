// configurate texts
draw_set_font(fn_m6x11);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_gray);

// draw boss
var bossSprite = variable_struct_get(boss.sprites, bossState);
draw_sprite_ext(bossSprite, 0, bossStartX, bossStartY, bossScale, bossScale, 0, c_white, 1);

// draw health bars
DrawBar(player.name, playerBarStartX, startY, width, height, player.hp, player.hpMax, c_blue);
DrawBar(boss.name, bossBarStartX, startY, width, height, boss.hp, boss.hpMax, c_red);

// draw candy bag and # of candies available
draw_sprite_ext(spr_candy_bag, 0, 0, candyBagStartY, 1, 1, 0, c_white, 1);
draw_text(numOfCandiesTextStartX, numOfCandiesTextStartY, player.candy);