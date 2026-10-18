function AddCandies(amount)
{
    var player = global.player.player;
    
    var oldNumOfCandies = player.candy;
    player.candy = clamp(player.candy + amount, 0, player.candyMax);
    
    var amountCandiesChanged = player.candy - oldNumOfCandies;
    return amountCandiesChanged;
}

function IsAllMinigamesPlayed()
{
    var minigames = variable_struct_get_names(global.minigames);
    
    var numOfMinigames = array_length(minigames);
    for (var i = 0; i < numOfMinigames; ++i)
    {
        var minigame = variable_struct_get(global.minigames, minigames[i]);
        
        if (!minigame.isPlayed)
        {
            return false;
        }
    }
    
    return true;
}