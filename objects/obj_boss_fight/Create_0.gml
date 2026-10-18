// boss
bossScale = 3;
bossState = "idle";
bossStartX = room_width / 2 - 100;
bossStartY = room_height / 2 - 190;

// health bars
width = 90;
height = 15;
startY = 30;

playerBarStartX = 15;
bossBarStartX = 510;

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

// boxes
boxes = instance_create_layer(0, 0, "Instances", obj_draw_boxes);

// state functions
player = global.player.player;

// random boss
var availableBosses = GetAvailableBosses();

if (array_length(availableBosses) == 0)
{
    room_goto(rm_ending_scene);
    exit;
}

chosenBoss = availableBosses[irandom(array_length(availableBosses) - 1)];
boss = variable_clone(chosenBoss);

combatants = [player, boss];

turn = 0;
offset = 30;
waitTimeRemaining = 0;
waitTimeFrames = 90;

isBossIntroPlayed = false;
isBossFightEnded = false;

// keep these fresh every battle
player.hp = player.hpMax;
player.isDefended = false;
player.isFled = false;
player.isSpared = false;

function BossIntro()
{
    actionMenu.isActive = false;
    
    if (!isBossIntroPlayed)
    {
        isBossIntroPlayed = true;
        messageBox.message = "You have encountered " + boss.name + "! Ready to take actions.";
        waitTimeRemaining = waitTimeFrames + offset;
    }
    
    --waitTimeRemaining;
    if (waitTimeRemaining == 0)
    {
        state = SelectAction;
    }
}

function SelectAction()
{
    var currentCombatant = combatants[turn];
    var target = combatants[1 - turn];
    
    if (currentCombatant == player)
    {
        if (player.candy == 0)
        {
            player.hp = 0;
            state = EndBossFight;
            return;
        }
        
        actionMenu.isActive = true;
        
        var actionKey = string_lower(actionMenu.actions[actionMenu.selectedActionIndex]);
        var action = variable_struct_get(global.actions, actionKey);
        
        if (waitTimeRemaining > 0)
        {
            --waitTimeRemaining;
        }
        else 
        {
            messageBox.message = string(action.description2);
        }
        
        if (actionMenu.isActionChosen)
        {
            actionMenu.isActionChosen = false;
            
            if (player.candy < action.candyCost)
            {
                waitTimeRemaining = waitTimeFrames + offset;
                messageBox.message = "Not enough candies to perform this action!";
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
        player.candy = max(0, player.candy - action.candyCost);
    }
    
    damageDealt = action.func(user, target);
    
    messageBox.message = string(action.description1, user.name); 
    
    switch (action) 
    {
        case global.actions.attack:
            messageBox.message += " : " + string(damageDealt) + " damage dealt";
            break;
        case global.actions.flee:
            messageBox.message += (!player.isFled) ?  "\nYou cannot get away! You wished for all of this `_'" : "";
            break;
        case global.actions.plea:
            messageBox.message += (!player.isSpared) ? "\n" + boss.name + " is not impressed -0-" : "";
            break;
    }
            
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
    if (boss.hp <= 0)
    {
        player.candy += boss.candyValue;
        state = EndBossFight;
    }
    else if (player.hp <= 0 || player.isFled || player.isSpared)
    {
        state = EndBossFight;
    }
    else 
    {
        state = ProgressTurn;
    }
}

function ProgressTurn()
{
    turn = (turn + 1) % array_length(combatants);
    bossState = "idle";
    combatants[turn].isDefended = false;
    state = SelectAction;
}

function EndBossFight()
{
    if (!isBossFightEnded)
    {
        isBossFightEnded = true;
        
        if (boss.hp <= 0)
        {
            messageBox.message = "Congratulations! You have earned " + string(boss.candyValue) + " candies for winning " + string(boss.name);
        }
        else if (player.isFled)
        {
            messageBox.message = "You ran away!? You are a coward!";
        }
        else if (player.isSpared)
        {
            messageBox.message = boss.name + " lets you go??? You are lucky, child, but it only happens once.";
        }
        else if (player.candy == 0)
        {
            messageBox.message = "No candies left... Your memory about her fades away.";
        }
        else
        {
            messageBox.message = "You lost... Say goodbye to your loved one, heheheh";
        }
        
        waitTimeRemaining = waitTimeFrames;
    }
    
    --waitTimeRemaining;
    if (waitTimeRemaining == 0)
    {
        if (player.hp <= 0)
        {
            player.isLost = true;
            room_goto(rm_ending_scene);
        }
        else 
        {
            if (boss.hp <= 0)
            {
                chosenBoss.isDefeated = true;
            }
            else if (player.isSpared)
            {
                chosenBoss.isDefeated = true;
            }
            else if (player.isFled)
            {
                chosenBoss.isDefeated = false;
            }
            
            
            var availableBosses = GetAvailableBosses();
            if (array_length(availableBosses) > 0)
            {
                room_goto(rm_path_randomization);
            }
            else 
            {
                room_goto(rm_ending_scene);
            }
        }
    }
}

state = BossIntro;