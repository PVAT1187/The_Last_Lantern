function RestartGame()
{
    var player = global.player.player;
    player.hp = player.hpMax;
    player.candy = 0;
    player.isLost = false;
    player.isFled = false;
    player.isSpared = false;
    player.isDefended = false;
    player.candyDropped = 0;
    
    var bosses = variable_struct_get_names(global.bosses);
    var numOfBosses = array_length(bosses);
    
    for (var i = 0; i < numOfBosses; ++i)
    {
        variable_struct_get(global.bosses, bosses[i]).isDefeated = false;
    } 
    
    global.minigames.bowl_tapping.isPlayed = false;
    global.isFestivalIntroPlayed = false;
}