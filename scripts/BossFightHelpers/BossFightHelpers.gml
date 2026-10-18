function BossFightHPModifier(target, amount)
{   
    if (target.hp <= 0)
    {
        return 0;
    }
    
    if (target.isDefended)
    {
        amount = ceil(amount / 2);
    }
    
    var oldHP = target.hp;
    target.hp = clamp(target.hp - amount, 0, target.hpMax);
    var amountHPChanged = oldHP - target.hp;
    
    return amountHPChanged;
}

function GetAvailableBosses()
{
    var bosses = variable_struct_get_names(global.bosses);
    var availableBosses = [];
    
    var numOfBosses = array_length(bosses);
    for (var i = 0; i < numOfBosses; ++i)
    {
        var currentBoss = variable_struct_get(global.bosses, bosses[i]);
        
        if (!currentBoss.isDefeated)
        {
            array_push(availableBosses, currentBoss);
        }
    }
    
    return availableBosses;
}