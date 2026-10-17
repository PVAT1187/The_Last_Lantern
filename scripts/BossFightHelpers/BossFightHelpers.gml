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