// paths
draw_sprite_ext(spr_path_left, 0, leftPathStartX, pathStartY, pathScale, pathScale, 0, c_white, 1);
draw_sprite_ext(spr_path_straight, 0, straightPathStartX, pathStartY, pathScale, pathScale, 0, c_white, 1);
draw_sprite_ext(spr_path_right, 0, rightPathStartX, pathStartY, pathScale, pathScale, 0, c_white, 1);

// candy bag and picked candy
draw_sprite_ext(spr_candy_bag, 0, candyBagStartX, candyBagStartY, candyBagScale, candyBagScale, 0, c_white, 1);

if (pickedCandyShown)
{
    draw_sprite_ext(candies[pickedCandyIndex].sprite, 0, pickedCandyStartX, pickedCandyStartY, candyBagScale, candyBagScale, 0, c_white, 1);
}