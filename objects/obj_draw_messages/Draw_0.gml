// configurates text
draw_set_font(fn_m6x11);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_gray);

draw_text_ext(messageTextStartX, messageTextStartY, message, -1, messageTextWrapWidth);