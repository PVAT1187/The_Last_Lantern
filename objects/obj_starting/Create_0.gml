groundScale = 3;

leftGroundStartX = 5;
middleGroundStartX = 200;
rightGroundStartX = 390;

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
    "BLACK CAT",
    "OUIJA BOARD"
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

// state functions
function SelectGame()
{
    actionMenu.isActive = true;
    
    var gameKey = string_replace_all(string_lower(actionMenu.actions[actionMenu.selectedActionIndex]), " ", "_");
    var game = variable_struct_get(global.minigames, gameKey);
    
    if (game.isPlayed)
    {
        messageBox.message = "You already played this game.";
    }
    else 
    {
        messageBox.message = string(game.description);
    }
    
    if (actionMenu.isActionChosen)
    {
        actionMenu.isActionChosen = false;
        
        if (!game.isPlayed)
        {
            game.isPlayed = true;
            room_goto(game.room);
        }
    }
}

state = SelectGame;