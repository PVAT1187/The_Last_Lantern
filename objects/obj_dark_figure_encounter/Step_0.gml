if (darkFigureVisible)
{
    darkFigureStartY = lerp(darkFigureStartY, darkFigureTargetY, 0.2);
}

if (keyboard_check_pressed(vk_enter))
{
    ++messageIndex;
    
    if (messageIndex >= array_length(dialogue))
    {
        room_goto(rm_path_randomization);
    }
    else
    {
        ShowDialogue();
    }
}