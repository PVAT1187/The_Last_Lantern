depth = -1000;
darkFigureScale = 4;
darkFigureStartX = 225;
darkFigureStartY = -200;
darkFigureTargetY = 10;
darkFigureVisible = false;
darkFigureSprite = spr_dark_figure_sad;

//boxes
boxes = instance_create_layer(0, 0, "Instances", obj_draw_boxes);

// message box
messageBox = instance_create_layer(
    room_width / 2 - ACTION_MENU_START_OFFSET, 
    room_height / 2 - ACTION_MENU_START_OFFSET,
    "Instances", 
    obj_draw_messages
);

dialogue = 
[
    { 
        text: "The lights are going out, one by one...", 
        isDarkFigureVisible: false,
        sprite: spr_dark_figure
    },
    
    {
        text: "(It's late. Let's go home.)" + "\n(Mom always said this whenever the festival ended.)", 
        isDarkFigureVisible: false,
        sprite: spr_dark_figure
    },
    
    {
        text: "Leaving already? What a shame!", 
        isDarkFigureVisible: true,
        sprite: spr_dark_figure
    },
    
    {
        text: "(What!?)", 
        isDarkFigureVisible: true,
        sprite: spr_dark_figure
    },
    
    {
        text: "(W-Who are you!?)", 
        isDarkFigureVisible: true,
        sprite: spr_dark_figure
    },
    
    {
        text: "You can call me The Dark Figure. I am the one who rules the underworld.", 
        isDarkFigureVisible: true,
        sprite: spr_dark_figure
    },
    
    {
        text: "I can make your wish come true. You know the one.", 
        isDarkFigureVisible: true,
        sprite: spr_dark_figure
    },
    
    {
        text: "(W-What wish!? W-What are you talking about?)", 
        isDarkFigureVisible: true,
        sprite: spr_dark_figure_huh
    },
    
    {
        text: "Don't try to play dumb. I heard it... You rang that bowl so beautifully.", 
        isDarkFigureVisible: true,
        sprite: spr_dark_figure
    },
    
    {
        text: "Just like she used to. Did you hear it? Someone heard it.", 
        isDarkFigureVisible: true,
        sprite: spr_dark_figure
    },
    
    {
        text: "(...I just wish I could see her one more time.)",
        isDarkFigureVisible: true,
        sprite: spr_dark_figure
    },
    
    {
        text: "Here's my offer: I'll show you the way. Bring candy, you'll need every piece.", 
        isDarkFigureVisible: true,
        sprite: spr_dark_figure
    },
    
    {
        text: "No take-backs!", 
        isDarkFigureVisible: true,
        sprite: spr_dark_figure
    },
    
    {
        text: "(Wait, take back what? I didn't agree to anything!)",
        isDarkFigureVisible: true,
        sprite: spr_dark_figure
    },

    {
        text: "You rang the bowl. That counts as signing, dear.",
        isDarkFigureVisible: true,
        sprite: spr_dark_figure
    },  
    
    {
       text: "Now listen closely, because I'm only saying this once. The road home is long and dark.",
       isDarkFigureVisible: true,
       sprite: spr_dark_figure_shocked
    }, 

    {
       text: "Three paths. Three monsters. One of them will be waiting at the end of each.",
       isDarkFigureVisible: true,
       sprite: spr_dark_figure 
    }, 
    
    {
       text: "Every move you make costs candy. Attacking, defending, running away... even begging.",
       isDarkFigureVisible: true,
       sprite: spr_dark_figure 
    }, 

    {
       text: "Well, begging is free. But I wouldn't count on it working. Hehehe.",
       isDarkFigureVisible: true,
       sprite: spr_dark_figure 
    }, 

    {
       text: "(Why does it feel like each candy is worth more than it should be...?)",
       isDarkFigureVisible: true,
       sprite: spr_dark_figure 
    },

    {
       text: "Oh, you noticed. Spend them wisely. What you keep is what you get to hold on to.",
       isDarkFigureVisible: true,
       sprite: spr_dark_figure_shocked
    },

    {
       text: "Now, off you go! Don't worry, I'll be watching. Always.",
       isDarkFigureVisible: true,
       sprite: spr_dark_figure 
    },

    {
       text: "...",
       isDarkFigureVisible: false,
       sprite: spr_dark_figure 
    },
   
    {
       text: "(The last lantern goes out.)",
       isDarkFigureVisible: false,
       sprite: spr_dark_figure 
    }
]

messageIndex = 0;

function ShowDialogue()
{
    var message = dialogue[messageIndex];
    messageBox.message = message.text;
    darkFigureVisible = message.isDarkFigureVisible;
    darkFigureSprite = message.sprite;
}

ShowDialogue();