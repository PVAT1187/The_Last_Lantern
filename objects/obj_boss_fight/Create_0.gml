// boss
bossX = room_width / 2 - 100;
bossY = room_height / 2 - 190;
bossScale = 3;
bossState = "idle";

// health bars
width = 90;
height = 15;
startY = 30;

playerStartX = 15;
bossStartX = 510;

// candy bag
candyBagStartY = 35;
numOfCandiesTextStartX = 50;
numOfCandiesTextStartY = 60;

// action menu
actionMenu = instance_create_layer(
    room_width / 2 - ACTION_MENU_START_OFFSET, 
    room_height / 2 - ACTION_MENU_START_OFFSET, 
    "Instances", 
    obj_action_menu
);
actionMenu.actions = 
[
    "ATTACK",
    "DEFENSE",
    "FLEE",
    "PLEA"
]

// message box
messageBox = instance_create_layer(
    room_width / 2 - ACTION_MENU_START_OFFSET, 
    room_height / 2 - ACTION_MENU_START_OFFSET,
    "Instances", 
    obj_draw_messages
);

// boss fight: state functions
player = global.player.player;
boss = variable_clone(global.bosses.dracula);

combatants = [player, boss];

turn = 0;
waitTimeRemaining = 0;
waitTimeFrames = 60;

function SelectAction()
{
    var currentCombatant = combatants[turn];
    var target = combatants[1 - turn];
    
    if (currentCombatant == player)
    {
        actionMenu.isActive = true;
        
        if (actionMenu.isActionChosen)
        {
            actionMenu.isActionChosen = false;
            
            var actionKey = string_lower(actionMenu.actions[actionMenu.selectedActionIndex]);
            var action = variable_struct_get(global.actions, actionKey);
            
            if (player.candy < action.candyCost)
            {
                messageBox.message = "Not enough candy to perform this action!";
            }
            else
            {
                BeginAction(currentCombatant, action, target);
            }
        }
    }
    else 
    {
        actionMenu.isActive = false;
        var bossAction = boss.AIScript();
        BeginAction(currentCombatant, bossAction, target);
    }
}

function BeginAction(user, action, target)
{   
    waitTimeRemaining = waitTimeFrames;
    
    if (user == player)
    {
        player.candy -= action.candyCost;
    }
    
    damageDealt = action.func(user, target);
    
    messageBox.message = string(action.description, user.name) + " : " + string(damageDealt) + " damage dealt" ;
    
    if (user == player && action == global.actions.attack)
    {
        bossState = "hit";
    }
    if (user == boss && (variable_struct_exists(boss.sprites, action.animation)))
    {
        bossState = action.animation;
    }
    
    state = PerformAction;
}

function PerformAction()
{
    --waitTimeRemaining;
    if (waitTimeRemaining == 0)
    {
        state = CheckVictory;
    }
}

function CheckVictory()
{
    //if (boss.hp <= 0)
    //{
    //    player.candy += boss.candyValue;
    //    state = EndBossFight;
    //}
    //else if (player.hp <= 0)
    //{
    //    state = EndBossFight;
    //}
    //else 
    //{
    //    state = ProgressTurn;
    //}
    
    state = ProgressTurn;
}

function ProgressTurn()
{
    turn = (turn + 1) % array_length(combatants);
    bossState = "idle";
    state = SelectAction;
}

function EndBossFight()
{
    
}

state = SelectAction;