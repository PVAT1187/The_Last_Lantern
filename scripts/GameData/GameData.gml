global.actions =
{
    attack:
    {
        name: "ATTACK",
        description: "{0} attacks!",
        candyCost: 1,
        animation: "attack",
        func: function(user, target)
        {
            var damage = ceil(user.strength + random_range(-user.strength * 0.25, user.strength * 0.25));
            var damageDealt = BossFightHPModifier(target, damage, 1);
            return damageDealt;
        }
    },
    
    defense:
    {
        name: "DEFENSE",
        description: "{0} defends!",
        candyCost: 2,
        animation: "idle",
        func: function()
        {
            
        }
    },
    
    flee:
    {
        name: "FLEE",
        description: "{0} runs away!!!",
        candyCost: 5,
        animation: "hit",
        func: function()
        {
            
        }
    },
    
    plea:
    {
        name: "PLEA",
        description: "{0} pleads for mercy???",
        candyCost: 0,
        animation: "hit",
        func: function()
        {
            
        }
    }
}

global.player =
{
    player:
    {
        name: "Player",
        hp: 10,
        hpMax: 10,
        candy: 10,
        candyMax: 20,
        strength: 1,
        actions: []
    }
}

global.bosses = 
{
    dracula:
    {
        name: "Dracula",
        hp: 20,
        hpMax: 20,
        strength: 2,
        sprites: { idle: spr_dracula_idle, attack: spr_dracula_attack, hit: spr_dracula_hit},
        actions: [global.actions.attack, global.actions.defense, global.actions.flee, global.actions.plea],
        candyValue: 5,
        AIScript: function()
        {
            var randomActionIndex = irandom(array_length(actions) - 1);
            var action = actions[randomActionIndex];
            return action;
        }
    }
}   