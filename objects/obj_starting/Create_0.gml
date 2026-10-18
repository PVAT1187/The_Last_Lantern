if (IsAllMinigamesPlayed())
{
    room_goto(rm_dark_figure_encounter);
    exit;
}

// action menu
offset = 25;
actionMenu = instance_create_layer(
    room_width / 2 - ACTION_MENU_START_OFFSET - offset, 
    room_height / 2 - ACTION_MENU_START_OFFSET, 
    "Instances", 
    obj_action_menu
);
actionMenu.actions =
[
    "BOWL TAPPING",
    //"BLACK CAT",
    //"OUIJA BOARD"
];

// message box
messageBox = instance_create_layer(
    room_width / 2 - ACTION_MENU_START_OFFSET - offset, 
    room_height / 2 - ACTION_MENU_START_OFFSET, 
    "Instances", 
    obj_draw_messages
);

// boxes
boxes = instance_create_layer(0, 0, "Instances", obj_draw_boxes);

dialogue =
[
    "You're late! The festival is nearly over.",
    "Most of the stalls are already packing up...",
    "(Mom and I never missed a single festival.)",
    "Hurry up! There's still time for one last game."
]

messageIndex = 0;
isStartingIntroPlayed = false;

function StartingIntro()
{
    actionMenu.isActive = false;
    
    if (keyboard_check_pressed(vk_enter))
    {
        ++messageIndex;
        
        if (messageIndex >= array_length(dialogue))
        {
            isStartingIntroPlayed = true;
            state = SelectGame;
            return;
        }
    }
    
    messageBox.message = dialogue[messageIndex] + PROMP;
}

// state functions
function SelectGame()
{
    actionMenu.isActive = true;
    
    var gameKey = string_replace_all(string_lower(actionMenu.actions[actionMenu.selectedActionIndex]), " ", "_");
    var game = variable_struct_get(global.minigames, gameKey);
    
    // Todo: work on other minigames
    
    /*if (game.isPlayed)
    {
        messageBox.message = "You already played this game.";
    }
    else 
    {*/
        messageBox.message = string(game.description);
    //}
    
    if (actionMenu.isActionChosen)
    {
        actionMenu.isActionChosen = false;
        
        //if (!game.isPlayed)
        //{
            //game.isPlayed = true;
            room_goto(game.room);
        //}
    }
}

if (isStartingIntroPlayed)
{
    state = SelectGame;
}
else
{
    messageBox.message = dialogue[0] + PROMP;
    state = StartingIntro;
}