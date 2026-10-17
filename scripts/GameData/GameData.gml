#macro FIRST_BOX_WIDTH 450
#macro ACTION_MENU_START_OFFSET 7

global.actions =
{
    attack:
    {
        name: "ATTACK",
        description1: "{0} attacks!",
        description2: "Costs 1 candy.",
        candyCost: 1,
        animation: "attack",
        func: function(user, target)
        {
            var damage = ceil(user.strength + random_range(-user.strength * 0.25, user.strength * 0.25));
            var damageDealt = BossFightHPModifier(target, damage);
            return damageDealt;
        }
    },
    
    defense:
    {
        name: "DEFENSE",
        description1: "{0} defends!",
        description2: "Costs 2 candies.",
        candyCost: 2,
        animation: "idle",
        func: function(user, target)
        {
            user.isDefended = true;
            return 0;            
        }
    },
    
    flee:
    {
        name: "FLEE",
        description1: "{0} runs away!!!",
        description2: "Costs 3 candies, and there will be a chance of dropping more along the way.",
        candyCost: 3,
        animation: "hit",
        func: function(user, target)
        {
            if (user.hp <= user.hpMax / 2 && random(1) < 0.5)
            {
                user.isFled = true;
                user.candy = max(0, user.candy - irandom_range(1, global.actions.flee.candyCost));
            }
            return 0;
        }
    },
    
    plea:
    {
        name: "PLEA",
        description1: "{0} pleads for mercy???",
        description2: "Costs you nothing, and you think it is going to work!?",
        candyCost: 0,
        animation: "hit",
        func: function(user, target)
        {
            if (user.hp <= user.hpMax / 2 && random(1) < 0.4)
            {
                user.isSpared = true;
            }
            return 0;
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
        candy: 20,
        candyMax: 20,
        strength: 5,
        isDefended: false,
        isFled: false,
        isSpared: false,
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
        actions: [global.actions.attack, global.actions.defense], // flee and plea options later
        candyValue: 5,
        isDefended: false,
        AIScript: function()
        {
            var randomActionIndex = irandom(array_length(actions) - 1);
            var action = actions[randomActionIndex];
            return action;
        }
    }
}   