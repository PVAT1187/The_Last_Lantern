function BossFightHPModifier(target, amount, isAlive)
{   
    if (isAlive && target.hp <= 0)
    {
        return 0;
    }
    
    var oldHP = target.hp;
    target.hp = clamp(target.hp - amount, 0, target.hpMax);
    var amountHPChanged = oldHP - target.hp;
    
    return amountHPChanged;
}