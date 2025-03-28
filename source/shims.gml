#define sound_play
///sound_play(index)
    return __gm82snd_instantiate(argument0,"FMODSoundPlay",0,1)

#define sound_loop
///sound_loop(index)
    return __gm82snd_instantiate(argument0,"FMODSoundLoop",0,1)



#define sound_stop
///sound_stop(index)
    var snd;
    
    if (is_real(argument0)) if (argument0) {
        if (__gm82snd_call("FMODInstanceIsPlaying",argument0)) {
            ds_list_delete(
                __gm82snd_instlist(
                    __gm82snd_map(
                        __gm82snd_call("FMODInstanceGetSound",argument0)
                    )
                ),argument0
            )
            __gm82snd_call("FMODInstanceStop",argument0)
        }
        if (argument0==__gm82snd_map("__bginst"))
            __gm82snd_map("__bginst",0)
        return 0
    }
    if (sound_exists(argument0)) {
        __gm82snd_stopallof(argument0)
        return 0
    }
    show_error("Sound does not exist: "+string(argument0),0)
    return 0


#define sound_stop_all
///sound_stop_all()
    var list,i,l,il;
    
    __gm82snd_call("FMODAllStop")
    
    list=__gm82snd_map("__globlist")
    l=ds_list_size(list)
    
    //get every active instance list, and clear them
    i=0 repeat (l/2) {
        //the inst list is the second entry in a pair 
        il=ds_list_find_value(list,i+1)
        ds_list_clear(il)
        i+=2
    }
    
    //clear global instance list
    ds_list_clear(list)


#define sound_pan
///sound_pan(index,value)
    var snd,pan;
    pan=median(-1,argument1,1)
    
    if (is_real(argument0)) if (argument0) {
        __gm82snd_call("FMODInstanceSetPan",argument0,pan)
        return 0
    }
    if (sound_exists(argument0)) {
        __gm82snd_map(argument0+"__pan",pan)
        return 0
    }
    
    show_error("Sound does not exist: "+string(argument0),0)
    return 0



#define sound_volume
///sound_volume(index,value)
    var vol;

    vol=median(0,argument1,1)
    
    if (is_real(argument0)) if (argument0) {
        __gm82snd_call("FMODInstanceSetVolume",argument0,vol)
        return 0
    }
    if (sound_exists(argument0)) {
        //sound id, set base volume
        __gm82snd_call("FMODSoundSetMaxVolume",__gm82snd_fmodid(argument0),vol)
        __gm82snd_map(argument0+"__volume",vol)
        return 0
    }
    
    show_error("Sound does not exist: "+string(argument0),0)
    return 0


#define sound_replace
//sound_replace(index,fname,kind,preload)
    var name,snd,kind,list,i;
    name=string(argument0)
    
    if (sound_exists(name)) {        
        __gm82snd_stopallof(name)
        snd=__gm82snd_fmodid(name)
        __gm82snd_call("FMODSoundFree",snd)
        ds_map_delete(__gm82snd_mapid,snd)        
        
        __oldkind=__gm82snd_map(name+"__kind")
        
        list=__gm82snd_map("__kindlist"+string(__oldkind))
        ds_list_delete(list,ds_list_find_index(list,name))
        
        kind=median(0,round(argument2),3)
        
        if (!__gm82snd_supported(argument1)) {
            show_error("Error adding sound: unsupported extension: "+string(argument1),0)
            return 0
        }
        
        snd=__gm82snd_call("FMODSoundAdd",argument1,0,(kind mod 2) && (argument3!=2))
        __gm82snd_setgroup(snd,kind)
        
        ds_list_add(__gm82snd_map("__kindlist"+string(kind)),name)    
        
        __gm82snd_map(snd,name)
        __gm82snd_map(name+"__fmodid",snd)
        __gm82snd_map(name+"__kind",kind)
        __gm82snd_map(name+"__loaded",-1+2*!!argument3)
        __gm82snd_map(name+"__filename",argument1)

        return 1
    }
    
    show_error("Sound does not exist: "+name,0)
    return 0


#define sound_restore
///sound_restore(index)
    //nop
    return 0


#define sound_global_volume
///sound_global_volume(value)
    __gm82snd_mastervol=median(0,argument0,1)
    __gm82snd_call("FMODMasterSetVolume",__gm82snd_mastervol)


#define sound_isplaying
///sound_isplaying(index)
    if (is_real(argument0)) if (argument0) return __gm82snd_call("FMODInstanceIsPlaying",argument0)
    
    if (sound_exists(argument0)) 
        return !ds_list_empty(__gm82snd_instlist(argument0))
    
    show_error("Sound does not exist: "+string(argument0),0)
    return 0


#define sound_get_name
///sound_get_name(index)
    var name; 
    
    if (is_real(argument0)) {
        if (argument0) {
            name=__gm82snd_map(__gm82snd_call("FMODInstanceGetSound",argument0))
        } else {
            show_error("Sound is null.",0)
            return ""
        }
    } else {
        name=argument0
    }
    
    if (sound_exists(name)) {
        return name
    }
    
    show_error("Sound does not exist: "+string(name),0)
    return ""
    

#define sound_get_preload
///sound_get_preload(index)
    if (is_real(argument0)) if (argument0) {
        return 1
    }
    
    return sound_exists(argument0)


#define sound_fade
///sound_fade(index,value,time)
    //todo: uugghhhg more internal state


#define sound_get_kind
///sound_get_kind(ind)
    var snd,name;
    name=string(argument0)
    
    if (is_real(argument0)) if (argument0) {
        snd=__gm82snd_call("FMODInstanceGetSound",argument0)
        return __gm82snd_map(__gm82snd_map(snd)+"__kind")
    }
    if (sound_exists(argument0)) {
        return __gm82snd_map(name+"__kind")
    }
    
    show_error("Sound does not exist: "+name,0)
    return 0


#define sound_delete
///sound_delete(index)
    var snd,i;
    snd=__gm82snd_fmodid(argument0)
    
    if (snd) {        
        __gm82snd_stopallof(argument0)
        __gm82snd_call("FMODSoundFree",snd)
        ds_map_delete(__gm82snd_mapid,snd)    
        
        for (i=0;i<4;i+=1) {
            list=__gm82snd_map("__kindlist"+string(i))
            j=ds_list_find_index(list,argument0)
            if (j!=-1) ds_list_delete(list,j)
        }
        
        ds_list_destroy(__gm82snd_instlist(argument0))
        
        ds_map_delete(__gm82snd_mapid,snd)
        ds_map_delete(__gm82snd_mapid,argument0+"__fmodid")
        ds_map_delete(__gm82snd_mapid,argument0+"__filename")
        ds_map_delete(__gm82snd_mapid,argument0+"__kind")
        ds_map_delete(__gm82snd_mapid,argument0+"__loaded")
        ds_map_delete(__gm82snd_mapid,argument0+"__pitch")
        ds_map_delete(__gm82snd_mapid,argument0+"__volume")
        ds_map_delete(__gm82snd_mapid,argument0+"__3dmin")
        ds_map_delete(__gm82snd_mapid,argument0+"__3dmax")
        ds_map_delete(__gm82snd_mapid,argument0+"__3dconevol")
        ds_map_delete(__gm82snd_mapid,argument0+"__instlist")
        
        return 1
    }
    show_error("Sound does not exist: "+string(argument0),0)
    return 0


#define sound_discard
///sound_discard(index)
    //nop
    return 0


#define sound_background_tempo
///sound_background_tempo(factor)
    var pitch;

    pitch=median(0,argument0,100)
    sound_pitch(__gm82snd_map("__bginst"),pitch)
    __gm82snd_map("__bgtempo",pitch)


#define sound_exists
    ///sound_exists(name)
    //name: sound to check
    //returns: if the sound exists
    
    if (is_real(argument0)) return 0
    return !!ds_map_find_value(__gm82snd_mapid,argument0+"__fmodid")


#define sound_3d_set_sound_cone
//(snd,x,y,z,anglein,angleout,voloutside) 
    var anglein,angleout,att;
    
    if (is_real(argument0)) return 0

    if (sound_exists(argument0)) {
        __anglein=median(0,argument4,180)
        __angleout=median(__anglein,argument5,180)
        __att=median(0,argument6/100,100)
        __gm82snd_map(argument0+"__3dconex",argument1)
        __gm82snd_map(argument0+"__3dconey",argument2)
        __gm82snd_map(argument0+"__3dconez",argument3)
        __gm82snd_map(argument0+"__3dconein",__anglein)
        __gm82snd_map(argument0+"__3dconeout",__angleout)
        __gm82snd_map(argument0+"__3dconevol",1/power(10,__att/20))
        __gm82snd_update3d()
    } else {
        show_error("Sound does not exist: "+string(argument0),0)
    }    



#define sound_3d_set_sound_distance
//(snd,mindist,maxdist)
    var __mindist,__maxdist;

    if (sound_exists(argument0)) {
        __mindist=median(1,argument1,1000000000)
        __maxdist=median(__mindist,argument2,1000000000)
        __gm82snd_map(argument0+"__3dmin",__mindist)
        __gm82snd_map(argument0+"__3dmax",__maxdist)
        __gm82snd_update3d()
    } else {
        show_error("Sound does not exist: "+string(argument0),0)
    }    
    

#define sound_3d_set_sound_position
//(snd,x,y,z)
    if (sound_exists(argument0)) {
        __gm82snd_map(argument0+"__3dx",argument1)
        __gm82snd_map(argument0+"__3dy",argument2)
        __gm82snd_map(argument0+"__3dz",argument3)
    } else {
        show_error("Sound does not exist: "+string(argument0),0)
    }
    

#define sound_3d_set_sound_velocity
//(snd,x,y,z)
    if (sound_exists(argument0)) {
        __gm82snd_map(argument0+"__3dvx",argument1)
        __gm82snd_map(argument0+"__3dvy",argument2)
        __gm82snd_map(argument0+"__3dvz",argument3)
    } else {
        show_error("Sound does not exist: "+string(argument0),0)
    }

#define sound_add
//(fname,kind,preload)
    var snd,name,kind,load;

    if (!file_exists(argument0)) {
        show_error("File does not exist trying to add a sound: "+string(argument0),0)
        return noone
    }
    
    name=filename_change_ext(filename_name(argument0),"")    
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
    snd=__gm82snd_call("FMODSoundAdd",argument0,0,(kind mod 2) && (argument2!=2))
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


#define sound_effect_chorus
    show_error("Error in function sound_effect_chorus: Please use sound_effect_set() instead!",0)
#define sound_effect_echo
    show_error("Error in function sound_effect_echo: Please use sound_effect_set() instead!",0)
#define sound_effect_flanger
    show_error("Error in function sound_effect_flanger: Please use sound_effect_set() instead!",0)
#define sound_effect_gargle
    show_error("Error in function sound_effect_gargle: Please use sound_effect_set() instead!",0)
#define sound_effect_reverb
    show_error("Error in function sound_effect_reverb: Please use sound_effect_set() instead!",0)
#define sound_effect_compressor
    show_error("Error in function sound_effect_compressor: Please use sound_effect_set() instead!",0)
#define sound_effect_equalizer
    show_error("Error in function sound_effect_equalizer: Please use sound_effect_set() instead!",0)

#define sound_set_search_directory
    return 0

#define sound_effect_set
//(sndinst,effect)
    /*var name,loaded,ef;
    name=string(argument0)
    loaded=__gm82snd_isloaded(name)
    
    if (loaded!=0) {
        //sound id
        show_error("Error in function sound_effect_set("+name+"): Sound effects can only be applied to sound instances.",0)
        return 0
    } else if (is_real(argument0)) if (argument0) {
        ef=0
        switch (argument1) {
            case 1: ef=12 break
            case 2: ef=6 break
            case 3: ef=3 break
            case 4: ef=7 break
            case 5: ef=5 break
            case 6: ef=9 break
            case 7: ef=11 break
            case 8: ef=8 break
            case 16: ef=18 break
            case 32: ef=17 break
            case 64: ef=10 break
        }
        if (ef) {
            return __gm82snd_call("FMODInstanceAddEffect",argument0,ef)
        } else show_error("Error in function sound_effect_set("+name+"): invalid effect number "+string(argument0),0)
        return 0
    }
    
    show_error("Sound does not exist: "+name,0)*/
    return 0