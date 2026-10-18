// paths
pathScale = 3;
pathStartY = 5;

leftPathStartX = 10;
straightPathStartX = 225;
rightPathStartX = 425;

// candy bag and picked candy
candyBagScale = 1.5;
candyBagStartX = 150;
candyBagStartY = 250;

pickedCandyStartX= 200;
pickedCandyStartY = 255;

// acion menu
offset = 30;
actionMenu = instance_create_layer(
    room_width / 2 - ACTION_MENU_START_OFFSET - offset, 
    room_height / 2 - ACTION_MENU_START_OFFSET,
    "Instances", 
    obj_action_menu
);
actionMenu.actions = 
[
    "PULL FROM BAG"
];

// message box
messageBox = instance_create_layer(
    room_width / 2 - ACTION_MENU_START_OFFSET, 
    room_height / 2 - ACTION_MENU_START_OFFSET,
    "Instances", 
    obj_draw_messages
);

// boxes
boxes = instance_create_layer(0, 0, "Instances", obj_draw_boxes);

// candy
candies =
[
    { color: "brown", correlatedPath: "left", sprite: spr_candy_brown },
    { color: "blue", correlatedPath: "straight", sprite: spr_candy_dark_blue },
    { color: "green", correlatedPath: "right", sprite: spr_candy_green }
]

// state functions
pickedCandyIndex = -1; // 0 == brown, 1 == blue, 2 == green
pickedCandyShown = false;
waitTimeRemaining = 0;
waitTimeFrames = 90;

isPathIntroPlayed = false;
isPathIntroFinishedPlaying = false;

function PathIntro()
{
    actionMenu.isActive = false;
    
    if (!isPathIntroPlayed)
    {
        isPathIntroPlayed = true;
        
        messageBox.message = "You have reached the paths";
        waitTimeRemaining = waitTimeFrames + offset;
    }
    
    --waitTimeRemaining;
    if (waitTimeRemaining == 0)
    {
        isPathIntroFinishedPlaying = true;
        state = RandomizePath;
    }
}

function RandomizePath()
{
    actionMenu.isActive = true;
    messageBox.message = "Pull a candy from the candy bag to determine the path you will take.";
    
    if (actionMenu.isActionChosen)
    {
        actionMenu.isActive = false;
        actionMenu.isActionChosen = false;
        
        messageBox.message = "Reach into the candy bag...";
        
        pickedCandyIndex = irandom(array_length(candies) - 1);
        
        waitTimeRemaining = waitTimeFrames;
        
        state = RevealCandyResult;
    }
}

function RevealCandyResult()
{
    --waitTimeRemaining;
    if (waitTimeRemaining == 0)
    {
        pickedCandyShown = true;
        
        var pickedCandy = candies[pickedCandyIndex];
    
        messageBox.message = "You pulled out a " + string(pickedCandy.color) 
        + " candy, which means you will take the " 
        + (pickedCandy.correlatedPath) + " path";
        
        var offset = 30
        waitTimeRemaining = waitTimeFrames + offset;
    
        state = GoToPath;
    }
}

function GoToPath()
{
    --waitTimeRemaining;
    if (waitTimeRemaining == 0)
    {
        room_goto(rm_boss_fight);        
    }
}

state = PathIntro;