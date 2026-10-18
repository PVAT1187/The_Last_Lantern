state();

if (!global.isAudioUnlocked && (keyboard_check_pressed(vk_anykey) || mouse_check_button_pressed(mb_any)))
{
    global.isAudioUnlocked = true;
    audio_play_sound(snd_hauntedcastle, 1, true);
}