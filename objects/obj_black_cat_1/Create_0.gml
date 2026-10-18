// boxes
boxes = instance_create_layer(0, 0, "Instances", obj_draw_boxes);

// message box
messageBox = instance_create_layer(
    room_width / 2 - ACTION_MENU_START_OFFSET, 
    room_height / 2 - ACTION_MENU_START_OFFSET, 
    "Instances", 
    obj_draw_messages
);