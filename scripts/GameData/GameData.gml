global.player =
{
    player:
    {
        name: "Player",
        hp: 10,
        hpMax: 10,
        candy: 10,
        candyMax: 20,
        strength: 2,
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
        strength: 5,
        sprites: { idle: spr_dracula_idle, attack: spr_dracula_attack, hit: spr_dracula_hit},
        actions: [],
        candyValue: 5,
        AIScript: function ()
        {
            
        }
    }
}

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
            with (target) hp = max(0, hp - damage);
        }
    },
    
    defense:
    {
        name: "DEFENSE",
        description: "{0} defends!",
        candyCost: 2,
        animation: "idle"
    },
    
    flee:
    {
        name: "FLEE",
        description: "{0} flees!!!",
        candyCost: 5,
        animation: "hit"
    },
    
    plea:
    {
        name: "PLEA",
        description: "{0} pleads???",
        candyCost: 0,
        animation: "hit"
    }
}   
    