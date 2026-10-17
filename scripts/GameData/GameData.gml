#macro FIRST_BOX_WIDTH 450
#macro ACTION_MENU_START_OFFSET 7

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
        hp: 100,
        hpMax: 100,
        candy: 10,
        candyMax: 20,
        strength: 5,
        actions: []
    }
}

global.bosses = 
{
    dracula:
    {
        name: "Dracula",
        hp: 100,
        hpMax: 100,
        strength: 10,
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