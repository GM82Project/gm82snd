#define __gm82snd_init
    var __p,__dir;
    object_event_add(gm82core_object,ev_step,ev_step_end,"__gm82snd_update()")

    globalvar __gm82snd_version; __gm82snd_version=132

    //move fmod to a common location so that it doesn't leave a copy behind every time you run the game
    directory_create(temp_directory+"\gm82\sound")     
    __p=string_pos("\appdata\local\temp\gm_ttt_",string_lower(temp_directory))    
    __dir=string_copy(temp_directory,1,__p+19)+"gm82 dll cache"    
    directory_create(__dir)
    file_delete(__dir+"\fmodex.dll")
    file_rename(temp_directory+"\gm82\fmodex.dll",__dir+"\fmodex.dll")
    //poke it so that gmfmod can find it
    //this is a valid function and will put fmodex in the link list
    //this means it can be anywhere and it'll be found for further function defs
    external_define(__dir+"\fmodex.dll","FMOD_Debug_GetLevel",dll_cdecl,ty_real,0)
    
    global.__gm82snd_checkerrors=true
    
    __gm82snd_define("FMODinit",ty_real,ty_real)
    __gm82snd_define("FMODfree")
    __gm82snd_define("FMODUpdate")
    __gm82snd_define("FMODUpdateTakeOverWhileLocked")
    __gm82snd_define("FMODUpdateTakeOverDone")
    __gm82snd_define("FMODAllStop")
    __gm82snd_define("FMODMasterSetVolume",ty_real)
    __gm82snd_define("FMODSetPassword",ty_string)
    __gm82snd_define("FMODEncryptFile",ty_string,ty_string,ty_string)

    __gm82snd_define("FMODSoundAdd",ty_string,ty_real,ty_real)
    __gm82snd_define("FMODSoundFree",ty_real)
    __gm82snd_define("FMODSoundLoop",ty_real,ty_real)
    __gm82snd_define("FMODSoundPlay",ty_real,ty_real)
    __gm82snd_define("FMODSoundSetGroup",ty_real,ty_real)
    __gm82snd_define("FMODSoundSetMaxVolume",ty_real,ty_real)
    __gm82snd_define("FMODSoundGetLength",ty_real)
    __gm82snd_define("FMODSoundSetLoopPoints",ty_real,ty_real,ty_real)
    __gm82snd_define("FMODSoundSetLoopCount",ty_real,ty_real)
    __gm82snd_define("FMODCreateSoundFromMicInput")
    __gm82snd_define("FMODRecordStart",ty_real)
    __gm82snd_define("FMODRecordStop")
    
    __gm82snd_define("FMODInstanceAddEffect",ty_real,ty_real)
    __gm82snd_define("FMODGroupAddEffect",ty_real,ty_real)
    __gm82snd_define("FMODSoundAddEffect",ty_real,ty_real,ty_real)
    __gm82snd_define("FMODEffectFree",ty_real)
    __gm82snd_define("FMODEffectGetActive",ty_real)
    __gm82snd_define("FMODEffectGetBypass",ty_real)
    __gm82snd_define("FMODEffectGetNumParams",ty_real)
    __gm82snd_define("FMODEffectGetParamMax",ty_real,ty_real)
    __gm82snd_define("FMODEffectGetParamMin",ty_real,ty_real)
    __gm82snd_define("FMODEffectGetParamValue",ty_real,ty_real)
    __gm82snd_define("FMODEffectSetActive",ty_real,ty_real)
    __gm82snd_define("FMODEffectSetBypass",ty_real,ty_real)
    __gm82snd_define("FMODEffectGetParamDesc",ty_real,ty_real)
    __gm82snd_define("FMODEffectGetParamName",ty_real,ty_real)
    __gm82snd_define("FMODEffectGetParamLabel",ty_real,ty_real,ty_string)
    __gm82snd_define("FMODEffectGetParamValueStr",ty_real,ty_real,ty_string)
    __gm82snd_define("FMODEffectSetParamValue",ty_real,ty_real,ty_real)
    
    __gm82snd_define("FMODGroupStop",ty_real)
    __gm82snd_define("FMODGroupSetVolume",ty_real,ty_real)
    __gm82snd_define("FMODGroupSetPaused",ty_real,ty_real)
    __gm82snd_define("FMODGroupSetPitch",ty_real,ty_real)
    __gm82snd_define("FMODGroupSetPan",ty_real,ty_real)
    __gm82snd_define("FMODGroupGetMuted",ty_real)
    __gm82snd_define("FMODGroupGetPaused",ty_real)
    __gm82snd_define("FMODGroupGetPitch",ty_real)
    __gm82snd_define("FMODGroupGetVolume",ty_real)
    __gm82snd_define("FMODGroupSetMuted",ty_real,ty_real)
    
    __gm82snd_define("FMODInstanceStop",ty_real)
    __gm82snd_define("FMODInstanceIsPlaying",ty_real)
    __gm82snd_define("FMODInstanceGetPosition",ty_real)
    __gm82snd_define("FMODInstanceGetFrequency",ty_real)
    __gm82snd_define("FMODInstanceGetSound",ty_real)
    __gm82snd_define("FMODInstanceSetVolume",ty_real,ty_real)
    __gm82snd_define("FMODInstanceSetPaused",ty_real,ty_real)
    __gm82snd_define("FMODInstanceSetPosition",ty_real,ty_real)
    __gm82snd_define("FMODInstanceSetPan",ty_real,ty_real)      
    __gm82snd_define("FMODInstanceSetPitch",ty_real,ty_real)
    __gm82snd_define("FMODInstanceSetLoopCount",ty_real,ty_real)    
    
    __gm82snd_define("FMODGetLastError")
    __gm82snd_define("FMODGetNumInstances")
    __gm82snd_define("FMODGetTagData",ty_string)
    __gm82snd_define("FMODGetTagName",ty_string)
    
    __gm82snd_define("FMODInstanceGetLoopCount",ty_real)
    __gm82snd_define("FMODInstanceGetMuted",ty_real)
    __gm82snd_define("FMODInstanceGetNextTag",ty_real)
    __gm82snd_define("FMODInstanceGetPan",ty_real)
    __gm82snd_define("FMODInstanceGetPaused",ty_real)
    __gm82snd_define("FMODInstanceGetPitch",ty_real)
    __gm82snd_define("FMODInstanceGetVolume",ty_real)
    __gm82snd_define("FMODInstanceSetLoopCount",ty_real,ty_real)
    __gm82snd_define("FMODInstanceSetLoopPoints",ty_real,ty_real,ty_real)
    __gm82snd_define("FMODInstanceSetMuted",ty_real,ty_real)
    __gm82snd_define("FMODInstanceSetPan",ty_real,ty_real)
    __gm82snd_define("FMODInstanceSoundGetLength",ty_real)
    
    __gm82snd_define("FMODSoundGetLoopCount",ty_real)
    __gm82snd_define("FMODSoundGetMaxVolume",ty_real)
    __gm82snd_define("FMODSoundGetMusicChannelVolume",ty_real,ty_real)
    __gm82snd_define("FMODSoundGetMusicNumChannels",ty_real)
    __gm82snd_define("FMODSoundGetNumChannels",ty_real)
    __gm82snd_define("FMODSoundIsStreamed",ty_real)
    __gm82snd_define("FMODSoundSetEffects",ty_real,ty_real)
    __gm82snd_define("FMODSoundSetMusicChannelVolume",ty_real,ty_real,ty_real)
    
    global.__gm82snd_errorcheck=ds_map_find_value(__gm82snd_mapid,"__dll_FMODGetLastError")

    __gm82snd_call("FMODinit",256,false)

    __gm82snd_map("__bginst",0)
    __gm82snd_map("__bgtempo",1)
    __gm82snd_map("__passw","")
    __gm82snd_map("__kindlist0",ds_list_create())
    __gm82snd_map("__kindlist1",ds_list_create())
    __gm82snd_map("__kindlist2",ds_list_create())
    __gm82snd_map("__kindlist3",ds_list_create())
    __gm82snd_map("__globlist",ds_list_create())
    
    globalvar __gm82snd_mastervol;__gm82snd_mastervol=1
    

#define __gm82snd_deinit
    __gm82snd_call("FMODAllStop")
    __gm82snd_call("FMODfree")


#define __gm82snd_map
    //(key):value
    //(key,value)
    if (argument_count==1) {
        return ds_map_find_value(__gm82snd_mapid,argument0)
    } else {
        if (ds_map_exists(__gm82snd_mapid,argument0))
            ds_map_replace(__gm82snd_mapid,argument0,argument1)
        else
            ds_map_add(__gm82snd_mapid,argument0,argument1)    
    }


#define __gm82snd_call
    //(func,args...)
    var __call,__ret,__error;

    __call=__gm82snd_map("__dll_"+argument0)

    switch (argument_count) {
        case 1: __ret=external_call(__call) break
        case 2: __ret=external_call(__call,argument[1]) break
        case 3: __ret=external_call(__call,argument[1],argument[2]) break
        case 4: __ret=external_call(__call,argument[1],argument[2],argument[3]) break
        case 5: __ret=external_call(__call,argument[1],argument[2],argument[3],argument[4]) break
        case 6: __ret=external_call(__call,argument[1],argument[2],argument[3],argument[4],argument[5]) break
    }

    if (global.__gm82snd_checkerrors) {
        __error=external_call(global.__gm82snd_errorcheck)
        if (__error) {
            if (__error=36 || __error=11) return __ret //deleted instance errors arent useful
            show_error("FMOD error in function "+argument0+":"+chr(13)+chr(13)+__gm82snd_geterrorstr(__error),0)
        }
    }
    return __ret


#define __gm82snd_define
    //(func,args...)
    var __dll,__call;
    
    __dll=temp_directory+"\gm82\gm82snd.dll"
    switch (argument_count) {
        case 1: __call=external_define(__dll,argument[0],1,0,0) break
        case 2: __call=external_define(__dll,argument[0],1,0,1,argument[1]) break
        case 3: __call=external_define(__dll,argument[0],1,0,2,argument[1],argument[2]) break
        case 4: __call=external_define(__dll,argument[0],1,0,3,argument[1],argument[2],argument[3]) break
        case 5: __call=external_define(__dll,argument[0],1,0,4,argument[1],argument[2],argument[3],argument[4]) break
        case 6: __call=external_define(__dll,argument[0],1,0,5,argument[1],argument[2],argument[3],argument[4],argument[5]) break
    }
    
    __gm82snd_map("__dll_"+argument0,__call)


#define __gm82snd_supported
    //(fname)
    return string_pos(string_lower(filename_ext(string(argument0))),".wav;.ogg;.mp3;.mid;.midi;.mod;.it;.s3m;.xm;.wma;.aif;.flac")


#define __gm82snd_fmodid
    //(index)
    return __gm82snd_map(string(argument0)+"__fmodid")


#define __gm82snd_instantiate
    //(index,function,pause,stopbgs)
    var __snd,__kind,__inst,__pitch,__pan,__vol,__flags,__name,__list,__list2;
    
    if (is_real(argument0)) {
        show_error("sound does not exist: "+string(argument0),0)
        return 0
    }
    
    __name=argument0
    
    __snd=__gm82snd_fmodid(argument0)
    if (!__snd) {
        show_error("Sound does not exist: "+__name,0)
        return 0
    }
    
    __kind=sound_get_kind(__name)
    if (__kind==1 && argument3) {
        __inst=__gm82snd_map("__bginst")
        if (__inst) sound_stop(__inst)
    }

    __flags=0
   
    __pitch=__gm82snd_map(__name+"__pitch")
    if (__pitch!=0) __flags=1

    if (__kind==1) {
        __flags=1
        __pitch*=__gm82snd_map("__bgtempo")
    }

    __pan=__gm82snd_map(__name+"__pan")
    if (__pan!=0) __flags=1
    
    __vol=1
    if (__kind==2) {
        __flags=1
        __vol=0
    }
    
    if (__flags) {
        __inst=__gm82snd_call(argument1,__snd,1)
        __gm82snd_call("FMODInstanceSetPitch",__inst,__pitch)
        __gm82snd_call("FMODInstanceSetPan",__inst,__pan)
        __gm82snd_call("FMODInstanceSetVolume",__inst,__vol)
        if (!argument2) __gm82snd_call("FMODInstanceSetPaused",__inst,0)  
    } else {
        __inst=__gm82snd_call(argument1,__snd,argument2)
    }

    __list=__gm82snd_instlist(__name)
    ds_list_add(__list,__inst)
    __list2=__gm82snd_map("__globlist")
    ds_list_add(__list2,__inst)
    ds_list_add(__list2,__list)
        
    if (__kind==1 && argument3) __gm82snd_map("__bginst",__inst)
    return __inst


#define __gm82snd_instlist
    //(name)
    return __gm82snd_map(argument0+"__instlist")


#define __gm82snd_setgroup
//(fmodid,group)
    var __kind,__group;

    __kind=argument1

    if (__kind==1) __group=1 //music
    if (__kind==3) __group=2 //mmplay
    if (__kind==2) __group=3 //3d
    if (__kind==0) __group=4 //regular sfx

    __gm82snd_call("FMODSoundSetGroup",argument0,__group)


#define __gm82snd_stopallof
//(name)
    var __list,__i,__s;
    
    __list=__gm82snd_instlist(argument0)
    __s=ds_list_size(__list)
    for (__i=0;__i<__s;__i+=1) {
        __gm82snd_call("FMODInstanceStop",ds_list_find_value(__list,__i))
    }
    ds_list_clear(__list)
    __gm82snd_update2d()
    

#define __gm82snd_update
    __gm82snd_call("FMODUpdate")
    __gm82snd_update3d()
    __gm82snd_update2d()


#define __gm82snd_update2d
    var __list,__i,__l,__inst,__il,__snd;
    
    __list=__gm82snd_map("__globlist")
    __l=ds_list_size(__list)
    global.__gm82snd_checkerrors=false
    __i=0 while (__i<__l) {
        __inst=ds_list_find_value(__list,__i)
        if (!__gm82snd_call("FMODInstanceIsPlaying",__inst)) {
            __gm82snd_call("FMODInstanceStop",__inst)
            ds_list_delete(__list,__i)
            __il=ds_list_find_value(__list,__i)
            ds_list_delete(__list,__i)
            ds_list_delete(__il,ds_list_find_index(__il,__inst))
            __i-=2
            __l-=2
        }
        __i+=2
    }
    global.__gm82snd_checkerrors=true


#define __gm82snd_update3d
    var __list3d,__j,__length,__name,__list,__s,__i;
    
    __list3d=ds_map_find_value(__gm82snd_mapid,"__kindlist2")
    __length=ds_list_size(__list3d)
    for (__j=0;__j<__length;__j+=1) {
        __name=ds_list_find_value(__list3d,__j)
        __list=ds_map_find_value(__gm82snd_mapid,__name+"__instlist")
        __s=ds_list_size(__list)

        for (__i=0;__i<__s;__i+=1) {
            __gm82snd_update_3d_sound(__name,ds_list_find_value(__list,__i))
        }
    }


#define __gm82snd_update_3d_sound
    //(name,instance)
    var __name,__inst,__sx,__sy,__sz,__vx,__vy,__vz,__cx,__cy,__cz,__mindist,__maxdist,__dir,__vol,__anglein,__angleout,__conevol;
    
    __name=argument0
    __inst=argument1
    
    //i've inlined all of the map readers in this function for performance concerns.
    
    __sx=ds_map_find_value(__gm82snd_mapid,__name+"__3dx")
    __sy=ds_map_find_value(__gm82snd_mapid,__name+"__3dy")
    __sz=ds_map_find_value(__gm82snd_mapid,__name+"__3dz")
    
    __vx=ds_map_find_value(__gm82snd_mapid,__name+"__3dvx")
    __vy=ds_map_find_value(__gm82snd_mapid,__name+"__3dvy")
    __vz=ds_map_find_value(__gm82snd_mapid,__name+"__3dvz")
    
    __cx=ds_map_find_value(__gm82snd_mapid,__name+"__3dconex")
    __cy=ds_map_find_value(__gm82snd_mapid,__name+"__3dconey")
    __cz=ds_map_find_value(__gm82snd_mapid,__name+"__3dconez")
    
    __mindist=ds_map_find_value(__gm82snd_mapid,__name+"__3dmin")
    __maxdist=ds_map_find_value(__gm82snd_mapid,__name+"__3dmax")
    __anglein=ds_map_find_value(__gm82snd_mapid,__name+"__3dconein")
    __angleout=ds_map_find_value(__gm82snd_mapid,__name+"__3dconeout")
    __conevol=ds_map_find_value(__gm82snd_mapid,__name+"__3dconevol")
    
    __vol=__mindist/median(__mindist,point_distance_3d(0,0,0,__sx,__sy,__sz),__maxdist)
    
    if (__conevol<1) {
        __dir=angle_difference_3d(__cx,__cy,__cz,-__sx,-__sy,-__sz)
        __vol*=lerp(1,__conevol,median(0,(__dir-__anglein)/(__angleout-__anglein),1))
    }      
    
    __gm82snd_call("FMODInstanceSetPan",__inst,lengthdir_x(1,point_direction(0,0,__sx,__sy+__sz)))
    __gm82snd_call("FMODInstanceSetVolume",__inst,__vol)                                                   //speed of sound in directx is 343 m/s
    __gm82snd_call("FMODInstanceSetPitch",__inst,1-(point_distance(0,0,__sx+__vx,__sy+__vy+__sz+__vz)-point_distance(0,0,__sx,__sy+__sz))/343) 


#define __gm82snd_geterrorstr
    switch (argument0) {
        case  1: return "Tried to call lock a second time before unlock was called. ";
        case  2: return "Tried to call a function on a data type that does not allow this type of functionality (ie calling Sound::lock on a streaming sound). ";
        case  3: return "Neither NTSCSI nor ASPI could be initialised. ";
        case  4: return "An error occurred while initialising the CDDA subsystem. ";
        case  5: return "Couldn't find the specified device. ";
        case  6: return "No audio tracks on the specified disc. ";
        case  7: return "No CD/DVD devices were found. ";
        case  8: return "No disc present in the specified drive. ";
        case  9: return "A CDDA read error occurred. ";
        case 10: return "Error trying to allocate a channel. ";
        case 11: return "The specified channel has been reused to play another sound. ";
        case 12: return "A Win32 COM related error occured. COM failed to initialize or a QueryInterface failed meaning a Windows codec or driver was not installed properly. ";
        case 13: return "DMA Failure.  See debug output for more information. ";
        case 14: return "DSP connection error.  Connection possibly caused a cyclic dependancy. ";
        case 15: return "DSP Format error.  A DSP unit may have attempted to connect to this network with the wrong format. ";
        case 16: return "DSP connection error.  Couldn't find the DSP unit specified. ";
        case 17: return "DSP error.  Cannot perform this operation while the network is in the middle of running.  This will most likely happen if a connection or disconnection is attempted in a DSP callback. ";
        case 18: return "DSP connection error.  The unit being connected to or disconnected should only have 1 input or output. ";
        case 19: return "Error loading file. ";
        case 20: return "Couldn't perform seek operation.  This is a limitation of the medium (ie netstreams) or the file format. ";
        case 21: return "Media was ejected while reading. ";
        case 22: return "End of file unexpectedly reached while trying to read essential data (truncated data?). ";
        case 23: return "File not found. ";
        case 24: return "Unwanted file access occured. ";
        case 25: return "Unsupported file or audio format. ";
        case 26: return "A HTTP error occurred. This is a catch-all for HTTP errors not listed elsewhere. ";
        case 27: return "The specified resource requires authentication or is forbidden. ";
        case 28: return "Proxy authentication is required to access the specified resource. ";
        case 29: return "A HTTP server error occurred. ";
        case 30: return "The HTTP request timed out. ";
        case 31: return "FMOD was not initialized correctly to support this function. ";
        case 32: return "Cannot call this command after System::init. ";
        case 33: return "An error occured that wasn't supposed to.  Contact support. ";
        case 34: return "On Xbox 360, this memory address passed to FMOD must be physical, (ie allocated with XPhysicalAlloc.) ";
        case 35: return "Value passed in was a NaN, Inf or denormalized float. ";
        case 36: return "An invalid object handle was used. ";
        case 37: return "An invalid parameter was passed to this function. ";
        case 38: return "An invalid speaker was passed to this function based on the current speaker mode. ";
        case 39: return "The vectors passed in are not unit length, or perpendicular. ";
        case 40: return "PS2 only.  fmodex.irx failed to initialize.  This is most likely because you forgot to load it. ";
        case 41: return "Reached maximum audible playback count for this sound's soundgroup. ";
        case 42: return "Not enough memory or resources. ";
        case 43: return "PS2 only.  Not enough memory or resources on PlayStation 2 IOP ram. ";
        case 44: return "Not enough memory or resources on console sound ram. ";
        case 45: return "Can't use FMOD_OPENMEMORY_POINT on non PCM source data, or non mp3/xma/adpcm data if FMOD_CREATECOMPRESSEDSAMPLE was used. ";
        case 46: return "Tried to call a command on a 3d sound when the command was meant for 2d sound. ";
        case 47: return "Tried to call a command on a 2d sound when the command was meant for 3d sound. ";
        case 48: return "Tried to use a feature that requires hardware support.  (ie trying to play a VAG compressed sound in software on PS2). ";
        case 49: return "Tried to use a feature that requires the software engine.  Software engine has either been turned off, or command was executed on a hardware channel which does not support this feature. ";
        case 50: return "Couldn't connect to the specified host. ";
        case 51: return "A socket error occurred.  This is a catch-all for socket-related errors not listed elsewhere. ";
        case 52: return "The specified URL couldn't be resolved. ";
        case 53: return "Operation on a non-blocking socket could not complete immediately. ";
        case 54: return "Operation could not be performed because specified sound is not ready. ";
        case 55: return "Error initializing output device, but more specifically, the output device is already in use and cannot be reused. ";
        case 56: return "Error creating hardware sound buffer. ";
        case 57: return "A call to a standard soundcard driver failed, which could possibly mean a bug in the driver or resources were missing or exhausted. ";
        case 58: return "Soundcard does not support the minimum features needed for this soundsystem (16bit stereo output). ";
        case 59: return "Error initializing output device. ";
        case 60: return "FMOD_HARDWARE was specified but the sound card does not have the resources nescessary to play it. ";
        case 61: return "Attempted to create a software sound but no software channels were specified in System::init. ";
        case 62: return "Panning only works with mono or stereo sound sources. ";
        case 63: return "An unspecified error has been returned from a 3rd party plugin. ";
        case 64: return "A requested output, dsp unit type or codec was not available. ";
        case 65: return "A resource that the plugin requires cannot be found. (ie the DLS file for MIDI playback) ";
        case 66: return "The number of allowed instances of a plugin has been exceeded. ";
        case 67: return "An error occured trying to initialize the recording device. ";
        case 68: return "Specified Instance in FMOD_REVERB_PROPERTIES couldn't be set. Most likely because another application has locked the EAX4 FX slot. ";
        case 69: return "The error occured because the sound referenced contains subsounds.  (ie you cannot play the parent sound as a static sample, only its subsounds.) ";
        case 70: return "This subsound is already being used by another sound, you cannot have more than one parent to a sound.  Null out the other parent's entry first. ";
        case 71: return "The specified tag could not be found or there are no tags. ";
        case 72: return "The sound created exceeds the allowable input channel count.  This can be increased using the maxinputchannels parameter in System::setSoftwareFormat. ";
        case 73: return "Something in FMOD hasn't been implemented when it should be! contact support! ";
        case 74: return "This command failed because System::init or System::setDriver was not called. ";
        case 75: return "A command issued was not supported by this object.  Possibly a plugin without certain callbacks specified. ";
        case 76: return "An error caused by System::update occured. ";
        case 77: return "The version number of this file format is not supported. ";
        case 78: return "An Event failed to be retrieved, most likely due to 'just fail' being specified as the max playbacks behavior. ";
        case 79: return "An error occured that wasn't supposed to.  See debug log for reason. ";
        case 80: return "Can't execute this command on an EVENT_INFOONLY event. ";
        case 81: return "Event failed because 'Max streams' was hit when FMOD_INIT_FAIL_ON_MAXSTREAMS was specified. ";
        case 82: return "FSB mis-matches the FEV it was compiled with. ";
        case 83: return "A category with the same name already exists. ";
        case 84: return "The requested event, event group, event category or event property could not be found. ";
        default: return "Unknown error.";
    };
//
//