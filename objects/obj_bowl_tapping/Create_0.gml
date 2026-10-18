// message box
messageBox = instance_create_layer(
    room_width / 2 - ACTION_MENU_START_OFFSET, 
    room_height / 2 - ACTION_MENU_START_OFFSET, 
    "Instances", 
    obj_draw_messages
);

// boxes
boxes = instance_create_layer(0, 0, "Instances", obj_draw_boxes);

// bowl
bowlScale = 3;
bowlStartX = 225;

bowlTapTimeRemaining = 0;
bowlTapTimeFrames = 5;

textStartPosition = 5;

// correct
correctTextStartY = 60;

// error
errorTextStartY = 30;

// key list
keyListStartX = 140;
keyListStartY = 275;
keyListSpacing = 50;

minigamesDuration = 30;

keys = [ "A", "S", "D", "W" ];

keyList = [];

gameTimeFrames = minigamesDuration * game_get_speed(gamespeed_fps);

totalErrorMatches = 0;
totalCorrectMatches = 0;
candiesEarned = 0;

function Pause()
{
    messageBox.message = "Get ready..."
        + "\n(This reminds me so much of mother."
        + "\nShe used to ring this bowl every year. She said it called the good luck.)"
        + PROMP;
    
    if (keyboard_check_pressed(vk_enter))
    {
        state = CountDown;
    }
}

function CountDown()
{
    messageBox.message = "Press the keys shown on screen in order!";
    state = Shuffle;
}

function Shuffle()
{
    keyList = [];

    var numOfKeys = array_length(keys);
    for (var i = 0; i < numOfKeys; ++i)
    {
        var randomKeyIndex = irandom(numOfKeys - 1);
        array_push(keyList, keys[randomKeyIndex]);
    }

    state = Play;
}

function Play()
{
    if (bowlTapTimeRemaining > 0)
    {
        --bowlTapTimeRemaining;
    }
    
    --gameTimeFrames;
    if (gameTimeFrames == 0)
    {
        keyList = [];
        
        candiesEarned = max(5, floor(totalCorrectMatches / array_length(keys)) - floor(totalErrorMatches / 2));
        candiesEarned = AddCandies(candiesEarned);
        
        messageBox.message = "Time's up!" + PROMP;
        state = TimeUp;
        return;
    }

    var numOfKeys = array_length(keys);
    for (var i = 0; i < numOfKeys; ++i)
    {
        if (array_length(keyList) > 0 && keyboard_check_pressed(ord(keys[i])))
        {
            if (keys[i] == keyList[0])
            {
                ++totalCorrectMatches;
                bowlTapTimeRemaining = bowlTapTimeFrames;
                array_delete(keyList, 0, 1);
            }
            else 
            {
                ++totalErrorMatches;
            }
        }
    }

    if (array_length(keyList) == 0)
    {
        state = Shuffle;
    }
}

function TimeUp()
{
    if (keyboard_check_pressed(vk_enter))
    {
        messageBox.message = "You earned " + string(candiesEarned) + " candies!"
        + "\n(She always saved the first candy of the night for me.)"
        + PROMP;
        
        state = RevealResult;
    }
           
}

function RevealResult()
{
    if (keyboard_check_pressed(vk_enter))
    {
        state = Finish;
    }
}

function Finish()
{
    global.minigames.bowl_tapping.isPlayed = true;
    room_goto(rm_starting_scene);
}

state = Pause;