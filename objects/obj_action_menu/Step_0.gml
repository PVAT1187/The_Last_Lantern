var numOfActions = array_length(actions);
if (!isActive || numOfActions == 0)
{
    exit;
}

selectedActionIndex += keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
     
if (selectedActionIndex > numOfActions - 1)
{
    selectedActionIndex = 0;
}
if (selectedActionIndex < 0)
{
    selectedActionIndex = numOfActions - 1;
}

if (keyboard_check_pressed(vk_enter))
{
    isActionChosen = true;
}