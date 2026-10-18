#macro FIRST_BOX_WIDTH 450
#macro ACTION_MENU_START_OFFSET 7
#macro PROMP "\n[Enter]"

global.isAudioUnlocked = false;

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
        description2: "Costs 1 candy.",
        candyCost: 1,
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
        description2: "Costs 3 candies, can be dropping more along the way, who knows :)",
        candyCost: 3,
        animation: "hit",
        func: function(user, target)
        {
            if (user.hp <= user.hpMax / 2 && random(1) < 0.5)
            {
                user.isFled = true;
                var candiesDropped = min(user.candy, irandom_range(1, global.actions.flee.candyCost))
                user.candy -= candiesDropped;
                user.candyDropped = candiesDropped;
            }
            return 0;
        }
    },
    
    plea:
    {
        name: "PLEA",
        description1: "{0} pleads for mercy???",
        description2: "Costs you nothing, but bruh... seriously? You think it is going to work?",
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
        candy: 0,
        candyMax: 20,
        candyDropped: 0,
        strength: 5,
        isDefended: false,
        isFled: false,
        isSpared: false,
        isLost: false,
        actions: [global.actions.attack, global.actions.defense, global.actions.flee, global.actions.plea]
    }
}

global.bosses = 
{
    dracula:
    {
        name: "Dracula",
        hp: 30,
        hpMax: 30,
        strength: 10,
        sprites: { idle: spr_dracula_idle, attack: spr_dracula_attack, hit: spr_dracula_hit},
        actions: [ global.actions.attack, global.actions.defense ], // flee and plea options later
        candyValue: 6,
        sound: snd_8bit_unknown_planet,
        isDefended: false,
        isDefeated: false,
        AIScript: function()
        {
            var randomActionIndex = irandom(array_length(actions) - 1);
            var action = actions[randomActionIndex];
            return action;
        }
    },
    
    pumpkin:
    {
        name: "Hollow Reaper",
        hp: 40,
        hpMax: 40,
        strength: 12,
        sprites: { idle: spr_pumpkin_idle, attack: spr_pumpkin_attack, hit: spr_pumpkin_hit},
        actions: [ global.actions.attack, global.actions.defense ], // flee and plea options later
        candyValue: 8,
        sound: snd_Memoraphile___Spooky_Dungeon,
        isDefended: false,
        isDefeated: false,
        AIScript: function()
        {
            var randomActionIndex = irandom(array_length(actions) - 1);
            var action = actions[randomActionIndex];
            return action;
        }
    },
    
    scarecrow:
    {
        name: "Grimble",
        hp: 50,
        hpMax: 50,
        strength: 14,
        sprites: { idle: spr_scarecrow_idle, attack: spr_scarecrow_attack, hit: spr_scarecrow_hit},
        actions: [ global.actions.attack, global.actions.defense ], // flee and plea options later
        candyValue: 10,
        sound: snd_10__jester_theme,
        isDefended: false,
        isDefeated: false,
        AIScript: function()
        {
            var randomActionIndex = irandom(array_length(actions) - 1);
            var action = actions[randomActionIndex];
            return action;
        }
    }
}

global.minigames =
{
    bowl_tapping:
    {
        name: "BOWL TAPPING",
        description: "Tap the bowl as fast as you can!",
        room: rm_bowl_tapping,
        isPlayed: false
    },
    
    black_cat:
    {
        name: "BLACK CAT",
        description: "Find the black cat!",
        room: rm_black_cat,
        isPlayed: true
    },
    
    ouija_board:
    {
        name: "OUIJA BOARD",
        description: "Remember the keys!",
        room: rm_ouija_board,
        isPlayed: true
    }
}