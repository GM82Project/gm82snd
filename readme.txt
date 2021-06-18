-Game Maker 8.2 Sound-

This is a replacement audio engine for Game Maker 8.1. Adding the extension
completely replaces the builtin sound functions, meaning, you can't play any
sound resources directly - you need to either use included files with
sound_add_included, or place them in a folder and load them all at game start.
We've changed how sound names work to make this a bit easier for you - you can
use sound_add_directory to load every file with a specific extension in a
folder, and sound ids are now the filename of that sound (without extension).

Read on about the distinction between sounds and instances, and also how to
properly use sound kinds.


[FMOD compatibility]

A set of direct FMOD function calls is included to enable compatibility for
games that already implement the script or extension versions of GMFMOD.
They're not fully implemented, but they should let most games start up.


[sounds vs. sound instances]

The first important distinction to have is that just like GM:Studio, every time
you play a sound the function returns a sound instance handle. This is
equivalent to the difference between object ids and instance ids. When you call
a sound function on a sound id, that will apply to every subsequent sound
instance created from that sound, while calling it on an instance id will
immediately apply the effect to it. This also applies to things like sound_stop
which will stop every instance of a sound vs. stopping only the one instance.


[kinds & streaming]

When a sound is loaded, the kind you pick determines how it'll behave.

kind = 0 (normal) is not streamed and can have multiple instances
kind = 1 (background) is streamed from disk and can only have one instance
kind = 2 (3d) is treated identically to kind = 0 (normal) but with spatial 3d
kind = 3 (mmplayer) is streamed from disk but can also have multiple instances

Streamed sounds are decoded from disk - meaning, they take a bit more cpu to
play. Having a lot of streamed sounds playing at once can cause slowdowns, so be
careful. Streamed sounds also do not like seeking! Setting their position too
fast can cause stuttering and other problems.

Another thing to note is that streamed sounds are loaded very fast. Loading oggs
without streaming can take several seconds.

So bottom line - you can load short oggs as normal type if you need, but use
mmplayer type for things like long voice lines that need to be streamed.


[vanilla function list]

These functions work the same, and some of them also accept sound instances.

sound_3d_set_sound_cone
sound_3d_set_sound_distance
sound_3d_set_sound_position
sound_3d_set_sound_velocity
sound_add
sound_background_tempo
sound_delete
sound_discard
sound_exists
sound_fade
sound_get_kind
sound_get_name
sound_get_preload
sound_global_volume
sound_isplaying
sound_loop
sound_name
sound_pan
sound_play
sound_replace
sound_restore
sound_stop
sound_stop_all
sound_volume


[adding sounds]

sound_add_included(fname,kind,preload)
    Adds a sound from one of the included files.
    
sound_add_directory(dir,extension,kind,preload)
    Adds every sound of a specific extension from a folder. Returns how many
    sounds were added.
/!\ Caution: this function uses file_find. If you're trying to find folders
    to load, make sure you create a list beforehand, and then navigate the list
    outside of a file find loop. Otherwise, errors will occur.

sound_password(string)
    Sets the password for encrypting or decrypting sound files. Setting a
    password does not affect non-encrypted sounds.
    
sound_encrypt(source,dest)
    Encrypts file source into file dest using the password set previously.
    Use this to create encrypted sound files that can only be played with the
    correct password. Useful for important game spoilers!


[new functions]

sound_pitch(index,pitch)
    Changes the pitch of a sound between 0.01 and 100 (default is 1).

sound_play_paused(index)
    Creates a paused sound instance so you can set its parameters before play.

sound_loop_paused(index)
    Creates a paused looped instance so you can set its parameters before play.
    
sound_play_single(index)
    Plays a single instance of the sound. Will only stop older instances that
    were created with one of the _single functions.
    
sound_loop_single(index)
    Loops a single instance of the sound. Will only stop older instances that
    were created with one of the _single functions.
    
sound_set_loop(index,loopstart,loopend)
    Sets the loop points of a sound (between 0 and 1). Use sound_get_length()
    if you need to use seconds for measurement.

sound_get_length(index)
    Returns the length of the sound in seconds.


[effects]

Game Maker's sound effects were handled by DirectSound itself. Our engine uses
FmodEx which means we can't make 1:1 recreations of the effects, but we provide
an effect constructor so that you can use FmodEx sound effects.

Currently, we only support applying effects to sound kinds due to memory leaks
that would require manual upkeeping - do let me know if you require the ability
to apply effects to sounds or instances.

sound_kind_effect(kind,effect)
    Adds an effect to a sound kind and returns its id.
    
    You can also specify "all" to apply the effect to all kinds at once.
    
    Effect is one of the following:
    
    se_chorus
    se_echo
    se_flanger
    se_gargle
    se_reverb
    se_compressor
    se_equalizer
    se_lowpass
    se_highpass
    se_normalize
    se_pitchshift

sound_effect_options(sfxinst,option,value)
    Changes an effect's options. Check the GMFMODSimple demo for how to use
    these (they are called effect parameters in fmod).
    
sound_effect_destroy(effect)
    Stops using the effect.


[kind functions]

These functions operate on all sounds by kind. That's how you change background
music volume without having to go through each one, for example.

sound_kind_pause(kind)
sound_kind_resume(kind)
sound_kind_volume(kind,volume)
sound_kind_pan(kind,pan)
sound_kind_pitch(kind,pitch)
sound_kind_stop(kind)
sound_kind_effect(kind,effect)
sound_kind_list(kind)
    Returns a ds_list with the names of each sound loaded of this kind.
    Remember to destroy the list once you're done with it.


[microphone functions]

note: microphone functionality is currently not implemented. I'll look into
adding it if there's demand... so let me know if you need it.

sound_add_mic()
    Adds a sound handle for recording from a microphone.

sound_mic_start()
    Starts recording the handle and returns a sound instance.

sound_mic_stop()
    Stops recording.


[deprecated functions]

sound_effect_chorus(...)
sound_effect_compressor(...)
sound_effect_echo(...)
sound_effect_equalizer(...)
sound_effect_flanger(...)
sound_effect_gargle(...)
sound_effect_reverb(...)
sound_effect_set(...)
    These functions changed the parameters for DirectSound effects.
    To use effects, check the [Effects] section for more instructions.
    
sound_set_search_directory(...)
    This function isn't needed.


[notes]

-> The Fmod license specifies you must display a Fmod logo in your games.
-> Reach out directly to Firelight Technologies for discussing commercial use.


- Created by renex & floogle -