// house
houseScale = 3.5;
houseStartX = 200;

// endings
spriteScale = 1.5;
endings = 
[
    { title: "happy", minNumOfCandies: 10, sprite: spr_sun_happy, sound: snd_Haran},
    { title: "sad", minNumOfCandies: 5, sprite: spr_moon_bad, sound:  snd_Brahms___Vals3_synth},
    { title: "nightmare", minNumOfCandies: 0, sprite: spr_dark_figure, sound: snd_bittersweet_ending}
]

// action menu
offset = 10;
actionMenu = instance_create_layer(
    room_width / 2 - ACTION_MENU_START_OFFSET - offset, 
    room_height / 2 - ACTION_MENU_START_OFFSET, 
    "Instances", 
    obj_action_menu
);
actionMenu.actions = 
[
    "TRY AGAIN"
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

var numOfCandiesRemaining = global.player.player.candy;

endingIndex = 0;
var numOfEndings = array_length(endings);

for (var i = 0; i < numOfEndings; ++i)
{
    if (numOfCandiesRemaining >= endings[i].minNumOfCandies)
    {
        endingIndex = i;
        break;    
    }
}

actionMenu.isActive = false;

state = ShowMessages;

function ShowMessages()
{
    state = RevealEnding;
}

function RevealEnding()
{   
    messageBox.message = "THE END"
        + "\nThank you for playing!"
        + "\n(Press Enter to continue.)";     
    
    if (keyboard_check_pressed(vk_enter))
    {
        actionMenu.isActive = true;
        state = TryAgain;
    }
}

function TryAgain()
{
    if (actionMenu.isActionChosen)
    {
        game_restart();
    }
}