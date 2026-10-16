global.player =
{
    player:
    {
        name: "Player",
        hp: 20,
        hp_max: 20,
        mp: 25,
        mp_max: 25,
        strength: 2,
        actions: []
    }
}

global.bosses = 
{
    dracula:
    {
        name: "Dracula",
        hp: 10,
        hp_max: 10,
        strength: 5,
        sprites: { idle: spr_boss_idle, attack: spr_boss_attack, hit: spr_boss_hit},
        candy_value: 5,
        AI_script: function ()
        {
            
        }
    }
}   
    