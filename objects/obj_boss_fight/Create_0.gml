// boss
xOffset = 100;
yOffset = 190;

bossX = room_width / 2 - xOffset;
bossY = room_height / 2 - yOffset;
bossScale = 3;
bossState = "idle";

// boxes
boxY = 180;
boxHeight = 190;

firstBoxWidth = 450;

secondBoxX = 430;
secondBoxWidth = 210;

// health bars
width = 90;
height = 15;
startY = 30;

playerStartX = 15;
bossStartX = 510;

// action texts
textXOffset = 190;
textBaseYOffset = 55;
textYSpacing = 25;

// message text
textStartX = 40;
textStartY = 220;
textWrapWidth = firstBoxWidth - textStartX * 2;

actions = 
[
    "attack",
    "defense",
    "flee",
    "plea"
]

// boss fight: state functions
player = global.player.player;
boss = variable_clone(global.bosses.dracula);

combatants = [player, boss];

turn = 0;
selectedActionIndex = 0;
message = "";
waitTimeRemaining = 0;
waitTimeFrames = 60;

function SelectAction()
{
    var currentCombatant = combatants[turn];
    var target = combatants[1 - turn];
    
    if (currentCombatant == player)
    {
        selectedActionIndex += keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
     
        var numOfActions = array_length(actions);   
        if (selectedActionIndex > numOfActions - 1)
        {
            selectedActionIndex = 0;
        }
        if (selectedActionIndex < 0)
        {
            selectedActionIndex = numOfActions - 1;
        }
        
        if (keyboard_check_pressed(vk_enter))
        {
            var action = variable_struct_get(global.actions, actions[selectedActionIndex])
            
            if (player.candy < action.candyCost)
            {
                message = "Not enough candy to perform the action!";
            }
            else
            {
                BeginAction(currentCombatant, action, target);
            }
        }
    }
    else 
    {
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
    
    message = string(action.description, user.name) + " : " + string(damageDealt) + " damage dealt" ;
    
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