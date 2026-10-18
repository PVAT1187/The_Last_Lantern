// house
houseScale = 3.5;
houseStartX = 200;

// endings
spriteScale = 1.5;
endings = 
[
    { 
        title: "happy", 
        minNumOfCandies: 10, 
        sprite: spr_sun_happy, 
        sound: snd_Haran,
        dialogue:
        [
            "You made it through the dark. At the end of the road, someone is waiting.",
            "(Mom!)",
            "My brave child. You kept so many of them.",
            "I always saved the first candy of the night for you, hehehe. Here.",
            "It's late. Let's go home.",
            "(Just a little longer, Mom. Please.)",
            "(She squeezes my hand. For tonight, I don't have to let go.)"
        ]
    },
    
    { 
        title: "sad", 
        minNumOfCandies: 5, 
        sprite: spr_moon_bad, sound:  
        snd_Brahms___Vals3_synth,
        dialogue:
        [
            "You made it through the dark. At the end of the road, someone is waiting.",
            "(Mom...?)",
            "You came all this way for me. My silly child.",
            "I wish I could stay longer. It's late.",
            "(She fades before I can say anything.)"
        ]
    },
    
    { 
        title: "nightmare", 
        minNumOfCandies: 0, 
        sprite: spr_dark_figure, 
        sound: snd_bittersweet_ending,
        dialogue:
        [
            "Oh dear. Out of candy already?",
            "Memories fade, that's what they do.",
            "Her face... what did it look like again?",
            "Better luck next time~ Hehehe."
        ]
    }
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

if (global.player.player.isLost)
{
    endingIndex = array_length(endings) - 1;
}

actionMenu.isActive = false;

messageIndex = 0;
messageBox.message = endings[endingIndex].dialogue[0] + PROMP;

function ShowMessages()
{
    if (keyboard_check_pressed(vk_enter))
    {
        ++messageIndex;
        
        var dialogue = endings[endingIndex].dialogue;
        
        if (messageIndex >= array_length(dialogue))
        {
            messageBox.message = "THE END" + "\nThank you for playing!" + PROMP;
            state = RevealEnding;
        }
        else 
        {
            messageBox.message = dialogue[messageIndex] + PROMP;
        }
    }
}

function RevealEnding()
{
    if (keyboard_check_pressed(vk_enter))
    {
        actionMenu.isActive = true;
        actionMenu.isActionChosen = false;
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

state = ShowMessages;