function AddCandies(amount)
{
    var player = global.player.player;
    player.candy = clamp(player.candy + amount, 0, player.candyMax);
}