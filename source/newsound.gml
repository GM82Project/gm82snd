#define sound_background_instance
    return __gm82snd_map("__bginst")




#define sound_get_length
//(index,[unit])
    var snd,len;    
    
    if (is_real(argument0)) {
        if (argument0) snd=__gm82snd_call("FMODInstanceGetSound",argument0)
        else {
            show_error("Sound is null.",0)
            return ""
        }
    } else snd=__gm82snd_fmodid(argument0)
    
    if (snd) {
        len=__gm82snd_call("FMODSoundGetLength",snd)/1000
        if (argument_count==2) {
            if (argument1==unit_samples)
                len=ceil(len*sound_get_frequency(argument0))
            if (argument1==unit_unitary)
                show_error("sound_get_length() does not accept unit_unitary as the time unit.",0)
        }
        return len
    }
        
    show_error("Sound does not exist: "+string(argument0),0)
    return 0


#define sound_get_frequency
//(index)
    var snd,ret;    
    
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
        list=__gm82snd_instlist(argument0)
        if (ds_list_size(list)) {
            snd=ds_list_find_value(list,0)
            ret=__gm82snd_call("FMODInstanceGetFrequency",snd)
        } else {
            snd=__gm82snd_instantiate(argument0,"FMODSoundPlay",1,0)        
            ret=__gm82snd_call("FMODInstanceGetFrequency",snd)
            sound_stop(snd)
        }
        return ret
    }
        
    show_error("Sound does not exist: "+string(argument0),0)
    return 0


#define sound_get_pos
//(index,[unit])
    var pos;
    if (is_real(argument0)) if (argument0) {
        pos=__gm82snd_call("FMODInstanceGetPosition",argument0)
        if (argument_count==2) {
            if (argument1==unit_samples)
                pos=ceil(pos*sound_get_length(argument0)*sound_get_frequency(argument0))
            if (argument1==unit_seconds)
                pos*=sound_get_length(argument0)
        }
        return pos
    }    
    
    show_error("Sound is not an instance: "+string(argument0),0)
    return 0

#define sound_set_pos
//(index,pos,[unit])
    var pos;
    if (is_real(argument0)) if (argument0) {
        pos=argument1
        if (argument_count==3) {
            if (argument2==unit_seconds) {
                len=sound_get_length(argument0)
                pos=argument1/len
            } else if (argument2==unit_samples) {
                len=sound_get_length(argument0)*sound_get_frequency(argument0)
                pos=argument1/len
            }
        }
        
        return __gm82snd_call("FMODInstanceSetPosition",argument0,median(0,pos,1))
    }    
    
    show_error("Sound is not an instance: "+string(argument0),0)
    return 0
    

#define sound_kind_pan
    var kind,group,pan;

    kind=argument0
    pan=median(-1,argument1,1)
    
    if (kind==all) {
        __gm82snd_call("FMODGroupSetPan",1,pan)
        __gm82snd_call("FMODGroupSetPan",2,pan)
        __gm82snd_call("FMODGroupSetPan",3,pan)
        __gm82snd_call("FMODGroupSetPan",4,pan)
    } else {
        if (kind==1) group=1 //music
        if (kind==3) group=2 //mmplay
        if (kind==2) group=3 //3d
        if (kind==0) group=4 //regular sfx

        __gm82snd_call("FMODGroupSetPan",group,pan)
    }

#define sound_kind_pause
    var kind,group;

    kind=argument0

    if (kind==all) {
        __gm82snd_call("FMODGroupSetPaused",1,1)
        __gm82snd_call("FMODGroupSetPaused",2,1)
        __gm82snd_call("FMODGroupSetPaused",3,1)
        __gm82snd_call("FMODGroupSetPaused",4,1)
    } else {
        if (kind==1) group=1 //music
        if (kind==3) group=2 //mmplay
        if (kind==2) group=3 //3d
        if (kind==0) group=4 //regular sfx

        __gm82snd_call("FMODGroupSetPaused",group,1)
    }

#define sound_kind_stop
    var kind,group;

    kind=argument0

    if (kind==all) {
        __gm82snd_call("FMODGroupStop",1)
        __gm82snd_call("FMODGroupStop",2)
        __gm82snd_call("FMODGroupStop",3)
        __gm82snd_call("FMODGroupStop",4)
    } else {
        if (kind==1) {group=1 __gm82snd_map("__bginst",0)} //music
        if (kind==3) group=2 //mmplay
        if (kind==2) group=3 //3d
        if (kind==0) group=4 //regular sfx

        __gm82snd_call("FMODGroupStop",group)
    }

#define sound_kind_pitch
    var kind,pitch,group;

    kind=argument0
    pitch=median(0.01,argument1,100)

    if (kind==all) {
        __gm82snd_call("FMODGroupSetPitch",1,pitch)
        __gm82snd_call("FMODGroupSetPitch",2,pitch)
        __gm82snd_call("FMODGroupSetPitch",3,pitch)
        __gm82snd_call("FMODGroupSetPitch",4,pitch)
    } else {
        if (kind==1) group=1 //music
        if (kind==3) group=2 //mmplay
        if (kind==2) group=3 //3d
        if (kind==0) group=4 //regular sfx

        __gm82snd_call("FMODGroupSetPitch",group,pitch)
    }

#define sound_kind_resume
    var kind,group;

    kind=argument0
    
    if (kind==all) {
        __gm82snd_call("FMODGroupSetPaused",1,0)
        __gm82snd_call("FMODGroupSetPaused",2,0)
        __gm82snd_call("FMODGroupSetPaused",3,0)
        __gm82snd_call("FMODGroupSetPaused",4,0)
    } else {
        if (kind==1) group=1 //music
        if (kind==3) group=2 //mmplay
        if (kind==2) group=3 //3d
        if (kind==0) group=4 //regular sfx

        __gm82snd_call("FMODGroupSetPaused",group,0)
    }

#define sound_kind_volume
    var kind,group,vol;

    kind=argument0
    vol=median(0,argument1,1)

    if (kind==all) {
        __gm82snd_call("FMODGroupSetVolume",1,vol)
        __gm82snd_call("FMODGroupSetVolume",2,vol)
        __gm82snd_call("FMODGroupSetVolume",3,vol)
        __gm82snd_call("FMODGroupSetVolume",4,vol)
    } else {
        if (kind==1) group=1 //music
        if (kind==3) group=2 //mmplay
        if (kind==2) group=3 //3d
        if (kind==0) group=4 //regular sfx

        __gm82snd_call("FMODGroupSetVolume",group,vol)
    }


#define sound_kind_get_volume
//(kind)
    var kind,group;

    kind=argument0

    if (kind==all) {
        return __gm82snd_mastervol
    } else {
        if (kind==1) group=1 //music
        if (kind==3) group=2 //mmplay
        if (kind==2) group=3 //3d
        if (kind==0) group=4 //regular sfx

        return __gm82snd_call("FMODGroupGetVolume",group)
    }


#define sound_loop_ex
//(index,[volume,pitch,pan])
    var snd;
    
    if (argument_count>1) {
        snd=__gm82snd_instantiate(argument[0],"FMODSoundLoop",1,1)
        sound_volume(snd,argument[1])
        if (argument_count>2) sound_pitch(snd,argument[2])
        if (argument_count>3) sound_pan(snd,argument[3])
        sound_resume(snd)
    } else {
        snd=__gm82snd_instantiate(argument[0],"FMODSoundLoop",0,1)
    }
    
    return snd


#define sound_loop_single_ex
//(index,[volume,pitch,pan])
    var snd;
    
    var inst,name;
    name=string(argument0)
    inst=__gm82snd_map(name+"__single")
    if (inst) __gm82snd_call("FMODInstanceStop",inst) 
    
    if (argument_count>1) {
        inst=__gm82snd_instantiate(argument[0],"FMODSoundLoop",1,1)
        sound_volume(inst,argument[1])
        if (argument_count>2) sound_pitch(inst,argument[2])
        if (argument_count>3) sound_pan(inst,argument[3])
        sound_resume(inst)
    } else {
        inst=__gm82snd_instantiate(argument[0],"FMODSoundLoop",0,1)
    }
    
    __gm82snd_map(name+"__single",inst)
    return inst


#define sound_loop_ex_layer
//(index,[volume,pitch,pan])
    var snd;
    
    if (argument_count>1) {
        snd=__gm82snd_instantiate(argument[0],"FMODSoundLoop",1,0)
        sound_volume(snd,argument[1])
        if (argument_count>2) sound_pitch(snd,argument[2])
        if (argument_count>3) sound_pan(snd,argument[3])
        sound_resume(snd)
    } else {
        snd=__gm82snd_instantiate(argument[0],"FMODSoundLoop",0,0)
    }
    
    return snd


#define sound_loop_paused
//(index,[volume,pitch,pan])
    var snd;
    
    snd=__gm82snd_instantiate(argument[0],"FMODSoundLoop",1,1)
        
    if (argument_count>1) {
        sound_volume(snd,argument[1])
        if (argument_count>2) sound_pitch(snd,argument[2])
        if (argument_count>3) sound_pan(snd,argument[3])
    }
    
    return snd


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
    var list,i;
    
    if (is_real(argument0)) if (argument0) {
        __gm82snd_call("FMODInstanceSetPaused",argument0,1)
        return 0
    }
    if (sound_exists(argument0)) {
        list=__gm82snd_instlist(argument0)
        i=ds_list_size(list)
        repeat (i) {
            i-=1
            __gm82snd_call("FMODInstanceSetPaused",ds_list_find_value(list,i),1)                
        }
        return 0
    }
    
    show_error("Sound does not exist: "+string(argument0),0)
    return 0


#define sound_resume
//(index)
    var list,i;
    
    if (is_real(argument0)) if (argument0) {
        __gm82snd_call("FMODInstanceSetPaused",argument0,0)
        return 0
    }
    if (sound_exists(argument0)) {
        list=__gm82snd_instlist(argument0)
        i=ds_list_size(list)
        repeat (i) {
            i-=1
            __gm82snd_call("FMODInstanceSetPaused",ds_list_find_value(list,i),0)                
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
    var snd;
    
    if (argument_count>1) {
        snd=__gm82snd_instantiate(argument[0],"FMODSoundPlay",1,1)
        sound_volume(snd,argument[1])
        if (argument_count>2) sound_pitch(snd,argument[2])
        if (argument_count>3) sound_pan(snd,argument[3])
        sound_resume(snd)
    } else {
        snd=__gm82snd_instantiate(argument[0],"FMODSoundPlay",0,1)
    }
    
    return snd
    
    
#define sound_play_single_ex
//(index,[volume,pitch,pan])
    var snd;
    
    var inst,name;
    name=string(argument0)
    inst=__gm82snd_map(name+"__single")
    if (inst) __gm82snd_call("FMODInstanceStop",inst) 
    
    if (argument_count>1) {
        inst=__gm82snd_instantiate(argument[0],"FMODSoundPlay",1,1)
        sound_volume(inst,argument[1])
        if (argument_count>2) sound_pitch(inst,argument[2])
        if (argument_count>3) sound_pan(inst,argument[3])
        sound_resume(inst)
    } else {
        inst=__gm82snd_instantiate(argument[0],"FMODSoundPlay",0,1)
    }
    
    __gm82snd_map(name+"__single",inst)
    return inst


#define sound_play_ex_layer
//(index,[volume,pitch,pan])
    var snd;
    
    if (argument_count>1) {
        snd=__gm82snd_instantiate(argument[0],"FMODSoundPlay",1,0)
        sound_volume(snd,argument[1])
        if (argument_count>2) sound_pitch(snd,argument[2])
        if (argument_count>3) sound_pan(snd,argument[3])
        sound_resume(snd)
    } else {
        snd=__gm82snd_instantiate(argument[0],"FMODSoundPlay",0,0)
    }
    
    return snd


#define sound_play_paused
//(index,[volume,pitch,pan])
    var snd;
    
    snd=__gm82snd_instantiate(argument[0],"FMODSoundPlay",1,1)
        
    if (argument_count>1) {
        sound_volume(snd,argument[1])
        if (argument_count>2) sound_pitch(snd,argument[2])
        if (argument_count>3) sound_pan(snd,argument[3])
    }
    
    return snd


#define sound_play_single
    var inst,name;
    name=string(argument0)
    inst=__gm82snd_map(name+"__single")
    if (inst) __gm82snd_call("FMODInstanceStop",inst) 
    inst=__gm82snd_instantiate(name,"FMODSoundPlay",0,1)
    __gm82snd_map(name+"__single",inst)
    return inst


#define sound_loop_single
    var inst,name;
    name=string(argument0)
    inst=__gm82snd_map(name+"__single")
    if (inst) __gm82snd_call("FMODInstanceStop",inst) 
    inst=__gm82snd_instantiate(name,"FMODSoundLoop",0,1)
    __gm82snd_map(name+"__single",inst)
    return inst


#define sound_set_loop
//(index,loopstart,loopend,[unit])
    var a,b,len;
    
    if (sound_exists(argument0)) {
        a=argument1
        b=argument2
        if (argument_count==4) {
            if (argument3==unit_seconds) {
                len=sound_get_length(argument0)
                a=argument1/len
                b=argument2/len
            } else if (argument3==unit_samples) {
                len=sound_get_length(argument0)*sound_get_frequency(argument0)
                a=argument1/len
                b=argument2/len
            }
        }
        a=median(0,a,1)
        b=median(a,b,1)
        __gm82snd_call("FMODSoundSetLoopPoints",__gm82snd_fmodid(argument0),a,b)
        return 0
    }
    show_error("Sound does not exist: "+string(argument0),0)
    return 0


#define sound_set_loop_count
//(index,count)
    var a;
    
    a=max(0,round(argument1))
    
    if (is_real(argument0)) if (argument0) {
        __gm82snd_call("FMODInstanceSetLoopCount",argument0,a)
        return 0
    }
    if (sound_exists(argument0)) {
        __gm82snd_call("FMODSoundSetLoopCount",__gm82snd_fmodid(argument0),a)
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


#define sound_get_count
    return __gm82snd_call("FMODGetNumInstances")


#define sound_kind_list
//(kind):list
    var lr,i,kind,list,l;
    
    lr=ds_list_create()
    kind=median(0,round(argument0),3)
    list=ds_map_find_value(__gm82snd_mapid,"__kindlist"+string(kind))
    l=ds_list_size(list)
    for (i=0;i<l;i+=1) {
        ds_list_add(lr,ds_list_find_value(list,i))
    }
    return lr


#define sound_add_ext
//(fname,kind,streamed,name)
    var snd,name,kind,load;

    if (!file_exists(argument0)) {
        show_error("File does not exist trying to add a sound: "+string(argument0),0)
        return noone
    }
    
    name=argument3    
    if (sound_exists(name)) {
        if (debug_mode) show_error("Debug warning: Sound '"+argument0+"' was overwritten.",0)
        sound_replace(name,argument0,argument1,argument2)
        return name
    }
    
    kind=median(0,round(argument1),3)

    if (!__gm82snd_supported(argument0)) {
        show_error("Error adding sound: unsupported extension: "+string(argument0),0)
        return ""
    }

    //we always preload now, but preload==2 means "decode on load"
    snd=__gm82snd_call("FMODSoundAdd",argument0,0,argument2)
    __gm82snd_setgroup(snd,kind)
    
    ds_list_add(__gm82snd_map("__kindlist"+string(kind)),name)    
    
    __gm82snd_map(snd,name)
    __gm82snd_map(name+"__fmodid",snd)
    __gm82snd_map(name+"__filename",argument0)
    __gm82snd_map(name+"__kind",kind)
    __gm82snd_map(name+"__loaded",-1+2*!!argument2)
    __gm82snd_map(name+"__pitch",1)
    __gm82snd_map(name+"__volume",1)
    __gm82snd_map(name+"__3dmin",1)
    __gm82snd_map(name+"__3dmax",1000000000)
    __gm82snd_map(name+"__3dconevol",1)
    __gm82snd_map(name+"__instlist",ds_list_create())

    return name


#define sound_add_directory
//(dir,extension,kind,preload)
    var dir,fname,count,f;
    
    dir=argument0

    if (string_char_at(dir,string_length(dir))!="\")
        dir+="\"
    
    if (!string_pos(":",dir)) dir=working_directory+"\"+dir

    count=0    
    if (directory_exists(dir)) {
        f=file_find_first(dir+"*"+argument1,0)
        while (f!="") {
            sound_add(dir+f,argument2,argument3)
            count+=1
            f=file_find_next()
        }           
        file_find_close()                                    
    }                                       
    return count    


#define sound_add_directory_ext
//(dir,extension,kind,streamed,nameprefix)
    var dir,fname,f,list,name;
    
    dir=argument0

    if (!string_pos(":",dir)) dir=working_directory+"\"+dir

    if (string_char_at(dir,string_length(dir))!="\")
        dir+="\"
    
    list=ds_list_create()
    if (directory_exists(dir)) {
        f=file_find_first(dir+"*"+argument1,0)
        while (f!="") {
            name=argument4+filename_change_ext(f,"")
            sound_add_ext(dir+f,argument2,argument3,name)
            ds_list_add(list,name)
            f=file_find_next()
        }           
        file_find_close()                                    
    }                                       
    return list 


#define sound_add_included
//(fname,kind,preload)
    var fname;
    fname=temp_directory+"\gm82\sound\"+argument0
    export_include_file_location(argument0,fname)
    return sound_add(fname,argument1,argument2)


#define sound_kind_effect
//(kind,effect)
    var kind,group,ef,i;
    kind=argument0

    if (kind==1)   group=1 //music
    if (kind==3)   group=2 //mmplay
    if (kind==2)   group=3 //3d
    if (kind==0)   group=4 //regular sfx
    if (kind==all) group=0 //all
    
    ef=0
    switch (argument1) {
        case 1: ef=12 break //se_chorus
        case 2: ef=6 break  //se_echo
        case 3: ef=18 break //se_lowpass
        case 4: ef=7 break  //se_flanger
        case 5: ef=5 break  //se_highpass
        case 6: ef=9 break  //se_normalize
        case 7: ef=11 break //se_pitchshift
        case 8: ef=8 break  //se_gargle
        case 16: ef=17 break//se_reverb
        case 32: ef=16 break//se_compressor
        case 64: ef=10 break//se_equalizer
    }
    if (ef) {
        i=__gm82snd_call("FMODGroupAddEffect",group,ef)
        //reverb's defaults are barely audible
        if (ef==17) sound_effect_options(i,1,0.7)
        //echo's defaults are also terrible
        if (ef==6) {
            sound_effect_options(i,0,100)
            sound_effect_options(i,1,0.8)
            sound_effect_options(i,4,0.3)
        }
        return i
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