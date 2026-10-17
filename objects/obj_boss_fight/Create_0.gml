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
currentAction = -1;
waitTimeRemaining = 0;
waitTimeFrames = 60;

function SelectAction()
{
    var currentCombatant = combatants[turn];
    var target = combatants[1 - turn];
    
    // Todo: add a action menu selections here, and check for plater's available candies with action's candyCost

    BeginAction(currentCombatant, global.actions.attack, target);
}

function BeginAction(user, action, target)
{
    currentUser = user;
    currentAction = action;
    currentTarget = target;
    
    waitTimeRemaining = waitTimeFrames;

    if (user == player)
    {
        player.candy -= action.candyCost;
    }
    
    currentAction.func(currentUser, currentTarget);
    
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