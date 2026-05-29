#define sound_background_instance
    ///sound_background_instance()
    //Returns the instance id of the current background music.
    
    return __gm82snd_map("__bginst")


#define sound_get_length
    ///sound_get_length(index,[unit])
    //Returns the length of a sound, in the specified unit or seconds by default.
    //Valid unit types are 'unit_seconds' and 'unit_samples'.
    var __snd,__len;    
    
    if (is_real(argument0)) {
        if (argument0) __snd=__gm82snd_call("FMODInstanceGetSound",argument0)
        else {
            show_error("Sound is null.",0)
            return ""
        }
    } else __snd=__gm82snd_fmodid(argument0)
    
    if (__snd) {
        __len=__gm82snd_call("FMODSoundGetLength",__snd)/1000
        if (argument_count==2) {
            if (argument1==unit_samples)
                __len=ceil(__len*sound_get_frequency(argument0))
            if (argument1==unit_unitary)
                show_error("sound_get_length() does not accept unit_unitary as the time unit.",0)
        }
        return __len
    }
        
    show_error("Sound does not exist: "+string(argument0),0)
    return 0


#define sound_get_frequency
    ///sound_get_frequency(index)
    //Returns the sample rate of the sound, in hertz.
    
    var __snd,__ret;    
    
    if (is_real(argument0)) {
        if (argument0) {
            return __gm82snd_call("FMODInstanceGetFrequency",argument0)
        }
        else {
            show_error("Sound is null.",0)
            return ""
        }
    } else if (sound_exists(argument0)) {        
        //only sound instances have frequency getters - we need to find one
        //ideally, we want to reuse any existing instances for this check
        __list=__gm82snd_instlist(argument0)
        if (ds_list_size(__list)) {
            __snd=ds_list_find_value(__list,0)
            __ret=__gm82snd_call("FMODInstanceGetFrequency",__snd)
        } else {
            __snd=__gm82snd_instantiate(argument0,"FMODSoundPlay",1,0)        
            __ret=__gm82snd_call("FMODInstanceGetFrequency",__snd)
            sound_stop(__snd)
        }
        return __ret
    }
        
    show_error("Sound does not exist: "+string(argument0),0)
    return 0


#define sound_get_count
    ///sound_get_count([index])
    //Returns the number of active instances of a sound, or all sounds.
    
    if (argument_count==0) return __gm82snd_call("FMODGetNumInstances")
    
    if (is_real(argument0)) if (argument0) return __gm82snd_call("FMODInstanceIsPlaying",argument0)
    
    if (sound_exists(argument0)) 
        return ds_list_size(__gm82snd_instlist(argument0))
    
    show_error("Sound does not exist: "+string(argument0),0)
    return 0
    
    
#define sound_get_pos
    ///sound_get_pos(index,[unit])
    //Returns the current play position of a sound, in the specified unit or seconds by default.
    //Valid unit types are 'unit_seconds', 'unit_samples' and 'unit_unitary'.
    
    var __pos;
    if (is_real(argument0)) if (argument0) {
        __pos=__gm82snd_call("FMODInstanceGetPosition",argument0)
        if (argument_count==2) {
            if (argument1==unit_samples)
                __pos=ceil(__pos*sound_get_length(argument0)*sound_get_frequency(argument0))
            if (argument1==unit_seconds)
                __pos*=sound_get_length(argument0)
        }
        return __pos
    }    
    
    show_error("Sound is not an instance: "+string(argument0),0)
    return 0

#define sound_set_pos
    ///sound_get_pos(index,pos,[unit])
    //Sets the current play position of a sound, in the specified unit or seconds by default.
    //Valid unit types are 'unit_seconds', 'unit_samples' and 'unit_unitary'.
    //Note that for streamed sounds this will incur a small hitch in playback as the buffers are discarded.
    
    var __pos;
    if (is_real(argument0)) if (argument0) {
        __pos=argument1
        if (argument_count==3) {
            if (argument2==unit_seconds) {
                __len=sound_get_length(argument0)
                __pos=argument1/__len
            } else if (argument2==unit_samples) {
                __len=sound_get_length(argument0)*sound_get_frequency(argument0)
                __pos=argument1/__len
            }
        }
        
        return __gm82snd_call("FMODInstanceSetPosition",argument0,median(0,__pos,1))
    }    
    
    show_error("Sound is not an instance: "+string(argument0),0)
    return 0
    

#define sound_kind_pan
    var __kind,__group,__pan;

    __kind=argument0
    __pan=median(-1,argument1,1)
    
    if (__kind==all) {
        __gm82snd_call("FMODGroupSetPan",1,__pan)
        __gm82snd_call("FMODGroupSetPan",2,__pan)
        __gm82snd_call("FMODGroupSetPan",3,__pan)
        __gm82snd_call("FMODGroupSetPan",4,__pan)
    } else {
        if (__kind==1) __group=1 //music
        if (__kind==3) __group=2 //mmplay
        if (__kind==2) __group=3 //3d
        if (__kind==0) __group=4 //regular sfx

        __gm82snd_call("FMODGroupSetPan",__group,__pan)
    }

#define sound_kind_pause
    var __kind,__group;

    __kind=argument0

    if (__kind==all) {
        __gm82snd_call("FMODGroupSetPaused",1,1)
        __gm82snd_call("FMODGroupSetPaused",2,1)
        __gm82snd_call("FMODGroupSetPaused",3,1)
        __gm82snd_call("FMODGroupSetPaused",4,1)
    } else {
        if (__kind==1) __group=1 //music
        if (__kind==3) __group=2 //mmplay
        if (__kind==2) __group=3 //3d
        if (__kind==0) __group=4 //regular sfx

        __gm82snd_call("FMODGroupSetPaused",__group,1)
    }

#define sound_kind_stop
    var __kind,__group;

    __kind=argument0

    if (__kind==all) {
        __gm82snd_call("FMODGroupStop",1)
        __gm82snd_call("FMODGroupStop",2)
        __gm82snd_call("FMODGroupStop",3)
        __gm82snd_call("FMODGroupStop",4)
    } else {
        if (__kind==1) {__group=1 __gm82snd_map("__bginst",0)} //music
        if (__kind==3) __group=2 //mmplay
        if (__kind==2) __group=3 //3d
        if (__kind==0) __group=4 //regular sfx

        __gm82snd_call("FMODGroupStop",__group)
    }

#define sound_kind_pitch
    var __kind,__pitch,__group;

    __kind=argument0
    __pitch=median(0.01,argument1,100)

    if (__kind==all) {
        __gm82snd_call("FMODGroupSetPitch",1,__pitch)
        __gm82snd_call("FMODGroupSetPitch",2,__pitch)
        __gm82snd_call("FMODGroupSetPitch",3,__pitch)
        __gm82snd_call("FMODGroupSetPitch",4,__pitch)
    } else {
        if (__kind==1) __group=1 //music
        if (__kind==3) __group=2 //mmplay
        if (__kind==2) __group=3 //3d
        if (__kind==0) __group=4 //regular sfx

        __gm82snd_call("FMODGroupSetPitch",__group,__pitch)
    }

#define sound_kind_resume
    var __kind,__group;

    __kind=argument0
    
    if (__kind==all) {
        __gm82snd_call("FMODGroupSetPaused",1,0)
        __gm82snd_call("FMODGroupSetPaused",2,0)
        __gm82snd_call("FMODGroupSetPaused",3,0)
        __gm82snd_call("FMODGroupSetPaused",4,0)
    } else {
        if (__kind==1) __group=1 //music
        if (__kind==3) __group=2 //mmplay
        if (__kind==2) __group=3 //3d
        if (__kind==0) __group=4 //regular sfx

        __gm82snd_call("FMODGroupSetPaused",__group,0)
    }

#define sound_kind_volume
    var __kind,__group,__vol;

    __kind=argument0
    __vol=median(0,argument1,1)

    if (__kind==all) {
        __gm82snd_call("FMODGroupSetVolume",1,__vol)
        __gm82snd_call("FMODGroupSetVolume",2,__vol)
        __gm82snd_call("FMODGroupSetVolume",3,__vol)
        __gm82snd_call("FMODGroupSetVolume",4,__vol)
    } else {
        if (__kind==1) __group=1 //music
        if (__kind==3) __group=2 //mmplay
        if (__kind==2) __group=3 //3d
        if (__kind==0) __group=4 //regular sfx

        __gm82snd_call("FMODGroupSetVolume",__group,__vol)
    }


#define sound_kind_get_volume
//(kind)
    var __kind,__group;

    __kind=argument0

    if (__kind==all) {
        return __gm82snd_mastervol
    } else {
        if (__kind==1) __group=1 //music
        if (__kind==3) __group=2 //mmplay
        if (__kind==2) __group=3 //3d
        if (__kind==0) __group=4 //regular sfx

        return __gm82snd_call("FMODGroupGetVolume",__group)
    }


#define sound_loop_ex
//(index,[volume,pitch,pan])
    var __snd;
    
    if (argument_count>1) {
        __snd=__gm82snd_instantiate(argument[0],"FMODSoundLoop",1,1)
        sound_volume(snd,argument[1])
        if (argument_count>2) sound_pitch(__snd,argument[2])
        if (argument_count>3) sound_pan(__snd,argument[3])
        sound_resume(__snd)
    } else {
        __snd=__gm82snd_instantiate(argument[0],"FMODSoundLoop",0,1)
    }
    
    return __snd


#define sound_loop_single_ex
//(index,[volume,pitch,pan])
    var __snd;
    
    var __inst,__name;
    __name=string(argument0)
    __inst=__gm82snd_map(__name+"__single")
    if (__inst) __gm82snd_call("FMODInstanceStop",__inst) 
    
    if (argument_count>1) {
        __inst=__gm82snd_instantiate(argument[0],"FMODSoundLoop",1,1)
        sound_volume(__inst,argument[1])
        if (argument_count>2) sound_pitch(__inst,argument[2])
        if (argument_count>3) sound_pan(__inst,argument[3])
        sound_resume(__inst)
    } else {
        __inst=__gm82snd_instantiate(argument[0],"FMODSoundLoop",0,1)
    }
    
    __gm82snd_map(__name+"__single",__inst)
    return __inst


#define sound_loop_ex_layer
//(index,[volume,pitch,pan])
    var __snd;
    
    if (argument_count>1) {
        __snd=__gm82snd_instantiate(argument[0],"FMODSoundLoop",1,0)
        sound_volume(__snd,argument[1])
        if (argument_count>2) sound_pitch(__snd,argument[2])
        if (argument_count>3) sound_pan(__snd,argument[3])
        sound_resume(__snd)
    } else {
        __snd=__gm82snd_instantiate(argument[0],"FMODSoundLoop",0,0)
    }
    
    return __snd


#define sound_loop_paused
//(index,[volume,pitch,pan])
    var __snd;
    
    __snd=__gm82snd_instantiate(argument[0],"FMODSoundLoop",1,1)
        
    if (argument_count>1) {
        sound_volume(__snd,argument[1])
        if (argument_count>2) sound_pitch(__snd,argument[2])
        if (argument_count>3) sound_pan(__snd,argument[3])
    }
    
    return __snd


#define sound_get_pan
//(index)
    if (is_real(argument0)) if (argument0) {
        return __gm82snd_call("FMODInstanceGetPan",argument0)
    }
    if (sound_exists(argument0)) {
        //sound id, get base volume
        return __gm82snd_map(argument0+"__pan")
    }
    
    show_error("Sound does not exist: "+string(argument0),0)
    return 0


#define sound_pause
//(index)
    var __list,__i;
    
    if (is_real(argument0)) if (argument0) {
        __gm82snd_call("FMODInstanceSetPaused",argument0,1)
        return 0
    }
    if (sound_exists(argument0)) {
        list=__gm82snd_instlist(argument0)
        __i=ds_list_size(__list)
        repeat (__i) {
            __i-=1
            __gm82snd_call("FMODInstanceSetPaused",ds_list_find_value(list,__i),1)                
        }
        return 0
    }
    
    show_error("Sound does not exist: "+string(argument0),0)
    return 0


#define sound_resume
//(index)
    var __list,__i;
    
    if (is_real(argument0)) if (argument0) {
        __gm82snd_call("FMODInstanceSetPaused",argument0,0)
        return 0
    }
    if (sound_exists(argument0)) {
        __list=__gm82snd_instlist(argument0)
        __i=ds_list_size(__list)
        repeat (__i) {
            __i-=1
            __gm82snd_call("FMODInstanceSetPaused",ds_list_find_value(__list,__i),0)                
        }
        return 0
    }
    
    show_error("Sound does not exist: "+string(argument0),0)
    return 0


#define sound_pause_all
    sound_kind_pause(all)


#define sound_resume_all
    sound_kind_resume(all)


#define sound_pitch
//(index,value)
    if (is_real(argument0)) if (argument0) {
        __gm82snd_call("FMODInstanceSetPitch",argument0,argument1)
        
        return 0
    }
    if (sound_exists(argument0)) {
        __gm82snd_map(argument0+"__pitch",argument1)
        return 0
    } 
    
    show_error("Sound does not exist: "+string(argument0),0)
    return 0


#define sound_get_pitch
//(index)
    if (is_real(argument0)) if (argument0) {
        return __gm82snd_call("FMODInstanceGetPitch",argument0)
    }
    if (sound_exists(argument0)) {
        //sound id, get base volume
        return __gm82snd_map(argument0+"__pitch")
    }
    
    show_error("Sound does not exist: "+string(argument0),0)
    return 0


#define sound_play_ex
//(index,[volume,pitch,pan])
    var __snd;
    
    if (argument_count>1) {
        __snd=__gm82snd_instantiate(argument[0],"FMODSoundPlay",1,1)
        sound_volume(__snd,argument[1])
        if (argument_count>2) sound_pitch(__snd,argument[2])
        if (argument_count>3) sound_pan(__snd,argument[3])
        sound_resume(__snd)
    } else {
        __snd=__gm82snd_instantiate(argument[0],"FMODSoundPlay",0,1)
    }
    
    return __snd
    
    
#define sound_play_single_ex
//(index,[volume,pitch,pan])
    var __snd,__inst,__name;
    
    __name=string(argument0)
    __inst=__gm82snd_map(__name+"__single")
    if (__inst) __gm82snd_call("FMODInstanceStop",__inst) 
    
    if (argument_count>1) {
        __inst=__gm82snd_instantiate(argument[0],"FMODSoundPlay",1,1)
        sound_volume(__inst,argument[1])
        if (argument_count>2) sound_pitch(__inst,argument[2])
        if (argument_count>3) sound_pan(__inst,argument[3])
        sound_resume(__inst)
    } else {
        __inst=__gm82snd_instantiate(argument[0],"FMODSoundPlay",0,1)
    }
    
    __gm82snd_map(__name+"__single",__inst)
    return __inst


#define sound_play_ex_layer
//(index,[volume,pitch,pan])
    var __snd;
    
    if (argument_count>1) {
        __snd=__gm82snd_instantiate(argument[0],"FMODSoundPlay",1,0)
        sound_volume(__snd,argument[1])
        if (argument_count>2) sound_pitch(__snd,argument[2])
        if (argument_count>3) sound_pan(__snd,argument[3])
        sound_resume(__snd)
    } else {
        __snd=__gm82snd_instantiate(argument[0],"FMODSoundPlay",0,0)
    }
    
    return __snd


#define sound_play_paused
//(index,[volume,pitch,pan])
    var __snd;
    
    __snd=__gm82snd_instantiate(argument[0],"FMODSoundPlay",1,1)
        
    if (argument_count>1) {
        sound_volume(__snd,argument[1])
        if (argument_count>2) sound_pitch(__snd,argument[2])
        if (argument_count>3) sound_pan(__snd,argument[3])
    }
    
    return __snd


#define sound_play_single
    var __inst,__name;
    
    __name=string(argument0)
    __inst=__gm82snd_map(__name+"__single")
    if (__inst) __gm82snd_call("FMODInstanceStop",__inst) 
    __inst=__gm82snd_instantiate(name,"FMODSoundPlay",0,1)
    __gm82snd_map(__name+"__single",__inst)
    
    return __inst


#define sound_loop_single
    var __inst,__name;
    
    __name=string(argument0)
    __inst=__gm82snd_map(__name+"__single")
    if (inst) __gm82snd_call("FMODInstanceStop",__inst) 
    __inst=__gm82snd_instantiate(__name,"FMODSoundLoop",0,1)
    __gm82snd_map(__name+"__single",__inst)
    
    return __inst


#define sound_set_loop
//(index,loopstart,loopend,[unit])
    var __a,__b,__len;
    
    if (sound_exists(argument0)) {
        __a=argument1
        __b=argument2
        if (argument_count==4) {
            if (argument3==unit_seconds) {
                __len=sound_get_length(argument0)
                __a=argument1/__len
                __b=argument2/__len
            } else if (argument3==unit_samples) {
                __len=sound_get_length(argument0)*sound_get_frequency(argument0)
                __a=argument1/__len
                __b=argument2/__len
            }
        }
        __a=median(0,__a,1)
        __b=median(__a,__b,1)
        __gm82snd_call("FMODSoundSetLoopPoints",__gm82snd_fmodid(argument0),__a,__b)
        return 0
    }
    show_error("Sound does not exist: "+string(argument0),0)
    return 0


#define sound_set_loop_count
//(index,count)
    var __a;
    
    __a=max(0,round(argument1))
    
    if (is_real(argument0)) if (argument0) {
        __gm82snd_call("FMODInstanceSetLoopCount",argument0,__a)
        return 0
    }
    if (sound_exists(argument0)) {
        __gm82snd_call("FMODSoundSetLoopCount",__gm82snd_fmodid(argument0),__a)
        return 0
    }
    show_error("Sound does not exist: "+string(argument0),0)
    return 0
    

#define sound_get_volume
//(index)
    if (is_real(argument0)) if (argument0) {
        return __gm82snd_call("FMODInstanceGetVolume",argument0)
    }
    if (sound_exists(argument0)) {
        //sound id, get base volume
        return __gm82snd_map(argument0+"__volume")
    }
    
    show_error("Sound does not exist: "+string(argument0),0)
    return 0


#define sound_kind_list
//(kind):list
    var __lr,__i,__kind,__list,__l;
    
    __lr=ds_list_create()
    __kind=median(0,round(argument0),3)
    __list=ds_map_find_value(__gm82snd_mapid,"__kindlist"+string(__kind))
    __l=ds_list_size(__list)
    for (__i=0;__i<__l;__i+=1) {
        ds_list_add(lr,ds_list_find_value(__list,__i))
    }
    return __lr


#define sound_add_ext
//(fname,kind,streamed,name)
    var __snd,__name,__kind,__load;

    if (!file_exists(argument0)) {
        show_error("File does not exist trying to add a sound: "+string(argument0),0)
        return noone
    }
    
    __name=argument3    
    if (sound_exists(__name)) {
        if (debug_mode) show_debug_message("warning: sound called '"+argument3+"' was overwritten with '"+argument0+"'.")
        sound_replace(__name,argument0,argument1,argument2)
        return __name
    }
    
    __kind=median(0,round(argument1),3)

    if (!__gm82snd_supported(argument0)) {
        show_error("Error adding sound: unsupported extension: "+string(argument0),0)
        return ""
    }

    //we always preload now, but preload==2 means "decode on load"
    __snd=__gm82snd_call("FMODSoundAdd",argument0,0,argument2)
    __gm82snd_setgroup(__snd,__kind)
    
    ds_list_add(__gm82snd_map("__kindlist"+string(__kind)),__name)    
    
    __gm82snd_map(__snd,__name)
    __gm82snd_map(__name+"__fmodid",__snd)
    __gm82snd_map(__name+"__filename",argument0)
    __gm82snd_map(__name+"__kind",__kind)
    __gm82snd_map(__name+"__loaded",-1+2*!!argument2)
    __gm82snd_map(__name+"__pitch",1)
    __gm82snd_map(__name+"__volume",1)
    __gm82snd_map(__name+"__3dmin",1)
    __gm82snd_map(__name+"__3dmax",1000000000)
    __gm82snd_map(__name+"__3dconevol",1)
    __gm82snd_map(__name+"__instlist",ds_list_create())

    return __name


#define sound_add_directory
//(dir,extension,kind,preload)
    var __dir,__fname,__count,__f;
    
    __dir=argument0

    if (string_char_at(__dir,string_length(__dir))!="\")
        __dir+="\"
    
    if (!string_pos(":",__dir)) __dir=working_directory+"\"+__dir

    __count=0    
    if (directory_exists(__dir)) {
        __f=file_find_first(__dir+"*"+argument1,0)
        while (__f!="") {
            sound_add(__dir+__f,argument2,argument3)
            __count+=1
            __f=file_find_next()
        }           
        file_find_close()                                    
    }                                       
    return __count    


#define sound_add_directory_ext
//(dir,extension,kind,streamed,nameprefix)
    var __dir,__fname,__f,__list,__name;
    
    __dir=argument0

    if (!string_pos(":",__dir)) __dir=working_directory+"\"+__dir

    if (string_char_at(__dir,string_length(__dir))!="\")
        __dir+="\"
    
    __list=ds_list_create()
    if (directory_exists(__dir)) {
        __f=file_find_first(__dir+"*"+argument1,0)
        while (__f!="") {
            __name=argument4+filename_change_ext(__f,"")
            sound_add_ext(__dir+__f,argument2,argument3,__name)
            ds_list_add(__list,__name)
            __f=file_find_next()
        }           
        file_find_close()                                    
    }                                       
    return __list 


#define sound_add_included
//(fname,kind,preload)
    var __fname;
    __fname=temp_directory+"\gm82\sound\"+argument0
    export_include_file_location(argument0,__fname)
    return sound_add(__fname,argument1,argument2)


#define sound_kind_effect
//(kind,effect)
    var __kind,__group,__ef,__i;
    __kind=argument0

    if (__kind==1)   __group=1 //music
    if (__kind==3)   __group=2 //mmplay
    if (__kind==2)   __group=3 //3d
    if (__kind==0)   __group=4 //regular sfx
    if (__kind==all) __group=0 //all
    
    __ef=0
    switch (argument1) {
        case 1: __ef=12 break //se_chorus
        case 2: __ef=6 break  //se_echo
        case 3: __ef=18 break //se_lowpass
        case 4: __ef=7 break  //se_flanger
        case 5: __ef=5 break  //se_highpass
        case 6: __ef=9 break  //se_normalize
        case 7: __ef=11 break //se_pitchshift
        case 8: __ef=8 break  //se_gargle
        case 16: __ef=17 break//se_reverb
        case 32: __ef=16 break//se_compressor
        case 64: __ef=10 break//se_equalizer
    }
    if (__ef) {
        __i=__gm82snd_call("FMODGroupAddEffect",__group,__ef)
        //reverb's defaults are barely audible
        if (__ef==17) sound_effect_options(__i,1,0.7)
        //echo's defaults are also terrible
        if (__ef==6) {
            sound_effect_options(__i,0,100)
            sound_effect_options(__i,1,0.8)
            sound_effect_options(__i,4,0.3)
        }
        return __i
    } else show_error("Error in function sound_kind_effect("+string(argument0)+"): invalid effect number "+string(argument1),0)
    return 0


#define sound_effect_options
//(sfxinst,option,value)
    __gm82snd_call("FMODEffectSetParamValue",argument0,argument1,argument2)


#define sound_effect_destroy
//(effect)
    if (argument0) {
        __gm82snd_call("FMODEffectFree",argument0)
        return 1
    }
    return 0
//
//