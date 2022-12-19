#define __gm82snd_call
//(func,args,...)
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
//(func,args,...)
    var dll,call;
    
    dll=temp_directory+"\gm82\GMFMODSimple.dll"
    switch (argument_count) {
        case 1: call=external_define(dll,argument[0],1,0,0) break
        case 2: call=external_define(dll,argument[0],1,0,1,argument[1]) break
        case 3: call=external_define(dll,argument[0],1,0,2,argument[1],argument[2]) break
        case 4: call=external_define(dll,argument[0],1,0,3,argument[1],argument[2],argument[3]) break
        case 5: call=external_define(dll,argument[0],1,0,4,argument[1],argument[2],argument[3],argument[4]) break
        case 6: call=external_define(dll,argument[0],1,0,5,argument[1],argument[2],argument[3],argument[4],argument[5]) break
    }
    
    __gm82snd_map("__dll_"+argument0,call)


#define __gm82snd_fmodid
//(index)
    return __gm82snd_map(string(argument0)+"__fmodid")


#define __gm82snd_init
    var p,dir;
    object_event_add(__gm82core_object,ev_step,ev_step_end,"__gm82snd_update()")

    //move fmod to a common location so that it doesn't leave a copy behind every time you run the game
    directory_create(temp_directory+"\gm82\sound")     
    p=string_pos("\appdata\local\temp\gm_ttt_",string_lower(temp_directory))    
    dir=string_copy(temp_directory,1,p+19)+"gm82snd"    
    directory_create(dir)    
    file_rename(temp_directory+"\gm82\fmodex.dll",dir+"\fmodex.dll")
    //poke it so that gmfmod can find it
    //this is a valid function and will put fmodex in the link list
    //this means it can be anywhere and it'll be found for further function defs
    external_define(dir+"\fmodex.dll","FMOD_Debug_GetLevel",dll_cdecl,ty_real,0)
    
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
    __gm82snd_define("FMODGetLastError")

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
    __gm82snd_define("FMODGetNumInstances")

    __gm82snd_define("FMODInstanceGetLoopCount",ty_real)
    __gm82snd_define("FMODInstanceGetMuted",ty_real)
    __gm82snd_define("FMODInstanceGetNextTag",ty_real)
    __gm82snd_define("FMODInstanceGetPan",ty_real)
    __gm82snd_define("FMODInstanceGetPaused",ty_real)
    __gm82snd_define("FMODInstanceGetPitch",ty_real)
    __gm82snd_define("FMODInstanceGetPosition",ty_real)
    __gm82snd_define("FMODInstanceGetSound",ty_real)
    __gm82snd_define("FMODInstanceGetVolume",ty_real)
    __gm82snd_define("FMODInstanceIsPlaying",ty_real)
    __gm82snd_define("FMODInstanceSetLoopCount",ty_real,ty_real)
    __gm82snd_define("FMODInstanceSetLoopPoints",ty_real,ty_real,ty_real)
    __gm82snd_define("FMODInstanceSetMuted",ty_real,ty_real)
    __gm82snd_define("FMODInstanceSetPan",ty_real,ty_real)
    __gm82snd_define("FMODInstanceSetPaused",ty_real,ty_real)
    __gm82snd_define("FMODInstanceSetPitch",ty_real,ty_real)
    __gm82snd_define("FMODInstanceSetPosition",ty_real,ty_real)
    __gm82snd_define("FMODInstanceSetVolume",ty_real,ty_real)
    __gm82snd_define("FMODInstanceSoundGetLength",ty_real)
    __gm82snd_define("FMODInstanceStop",ty_real)
    __gm82snd_define("FMODMasterSetVolume",ty_real)
    __gm82snd_define("FMODSoundAddEffect",ty_real,ty_real,ty_real)
    __gm82snd_define("FMODSoundGetLoopCount",ty_real)
    __gm82snd_define("FMODSoundGetMaxVolume",ty_real)
    __gm82snd_define("FMODSoundGetMusicChannelVolume",ty_real,ty_real)
    __gm82snd_define("FMODSoundGetMusicNumChannels",ty_real)
    __gm82snd_define("FMODSoundGetNumChannels",ty_real)
    __gm82snd_define("FMODSoundIsStreamed",ty_real)
    __gm82snd_define("FMODSoundSetEffects",ty_real,ty_real)
    __gm82snd_define("FMODSoundSetLoopCount",ty_real,ty_real)
    __gm82snd_define("FMODSoundSetMusicChannelVolume",ty_real,ty_real,ty_real)
    __gm82snd_define("FMODUpdateTakeOverDone")
    __gm82snd_define("FMODUpdateTakeOverWhileLocked")
    
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
    

#define __gm82snd_deinit
    __gm82snd_call("FMODAllStop")
    __gm82snd_call("FMODfree")


#define __gm82snd_instantiate
//(index,function,pause,stopbgs)
    var snd,kind,inst,pitch,pan,vol,flags,name,list,list2;
    
    if (is_real(argument0)) {
        show_error("sound does not exist: "+string(argument0),0)
        return 0
    }
    
    name=argument0
    
    snd=__gm82snd_fmodid(argument0)
    if (!snd) {
        show_error("Sound does not exist: "+name,0)
        return 0
    }
    
    kind=sound_get_kind(name)
    if (kind==1 && argument3) {
        inst=__gm82snd_map("__bginst")
        if (inst) sound_stop(inst)
    }

    flags=0
   
    pitch=__gm82snd_map(name+"__pitch")
    if (pitch!=0) flags=1

    if (kind==1) {
        flags=1
        pitch*=__gm82snd_map("__bgtempo")
    }

    pan=__gm82snd_map(name+"__pan")
    if (pan!=0) flags=1
    
    vol=1
    if (kind==2) {
        flags=1
        vol=0
    }
    
    if (flags) {
        inst=__gm82snd_call(argument1,snd,1)
        __gm82snd_call("FMODInstanceSetPitch",inst,pitch)
        __gm82snd_call("FMODInstanceSetPan",inst,pan)
        __gm82snd_call("FMODInstanceSetVolume",inst,vol)
        if (!argument2) __gm82snd_call("FMODInstanceSetPaused",inst,0)  
    } else {
        inst=__gm82snd_call(argument1,snd,argument2)
    }

    list=__gm82snd_instlist(name)
    ds_list_add(list,inst)
    list2=__gm82snd_map("__globlist")
    ds_list_add(list2,inst)
    ds_list_add(list2,list)
        
    if (kind==1) __gm82snd_map("__bginst",inst)
    return inst


#define __gm82snd_instlist
//(name)
    return __gm82snd_map(argument0+"__instlist")


#define sound_exists
//(name)
    if (is_real(argument0)) return 0
    return !!ds_map_find_value(__gm82snd_mapid,argument0+"__fmodid")
    

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


#define __gm82snd_setgroup
//(fmodid,group)
    var kind,group;

    kind=argument1

    if (kind==1) group=1 //music
    if (kind==3) group=2 //mmplay
    if (kind==2) group=3 //3d
    if (kind==0) group=4 //regular sfx

    __gm82snd_call("FMODSoundSetGroup",argument0,group)


#define __gm82snd_stopallof
//(name)
    var list,i,s;
    
    list=__gm82snd_instlist(argument0)
    s=ds_list_size(list)
    for (i=0;i<s;i+=1) {
        __gm82snd_call("FMODInstanceStop",ds_list_find_value(list,i))
    }
    ds_list_clear(list)
    __gm82snd_update2d()
    

#define __gm82snd_update
    //this is to avoid getting deactivated by game logic
    x=view_xview[0]+view_wview[0]/2
    y=view_yview[0]+view_hview[0]/2

    __gm82snd_call("FMODUpdate")
    __gm82snd_update3d()
    __gm82snd_update2d()


#define __gm82snd_update2d
    var list,i,l,inst,il,snd;
    
    list=__gm82snd_map("__globlist")
    l=ds_list_size(list)
    global.__gm82snd_checkerrors=false
    i=0 while (i<l) {
        inst=ds_list_find_value(list,i)
        if (!__gm82snd_call("FMODInstanceIsPlaying",inst)) {
            __gm82snd_call("FMODInstanceStop",inst)
            ds_list_delete(list,i)
            il=ds_list_find_value(list,i)
            ds_list_delete(list,i)
            ds_list_delete(il,ds_list_find_index(il,inst))
            i-=2
            l-=2
        }
        i+=2
    }
    global.__gm82snd_checkerrors=true


#define __gm82snd_update3d
    var list3d,j,spd,spdmax,name,key,list,s,i,sx,sy,sz,mindist,maxdist,dir,vol,anglein,angleout,conevol;
    
    //speed of sound is 343 m/s
    spdmax=343
    
    //i've inlined all of the map readers in this function for performance concerns.
    
    list3d=ds_map_find_value(__gm82snd_mapid,"__kindlist2")
    length=ds_list_size(list3d)
    for (j=0;j<length;j+=1) {
        name=ds_list_find_value(list3d,j)
        list=ds_map_find_value(__gm82snd_mapid,name+"__instlist")
        s=ds_list_size(list)

        for (i=0;i<s;i+=1) {
            inst=ds_list_find_value(list,i)
            sx=ds_map_find_value(__gm82snd_mapid,name+"__3dx")
            sy=ds_map_find_value(__gm82snd_mapid,name+"__3dy")
            sz=ds_map_find_value(__gm82snd_mapid,name+"__3dz")

            vx=ds_map_find_value(__gm82snd_mapid,name+"__3dvx")
            vy=ds_map_find_value(__gm82snd_mapid,name+"__3dvy")
            vz=ds_map_find_value(__gm82snd_mapid,name+"__3dvz")
            
            cx=ds_map_find_value(__gm82snd_mapid,name+"__3dconex")
            cy=ds_map_find_value(__gm82snd_mapid,name+"__3dconey")
            cz=ds_map_find_value(__gm82snd_mapid,name+"__3dconez")
            
            mindist=ds_map_find_value(__gm82snd_mapid,name+"__3dmin")
            maxdist=ds_map_find_value(__gm82snd_mapid,name+"__3dmax")
            anglein=ds_map_find_value(__gm82snd_mapid,name+"__3dconein")
            angleout=ds_map_find_value(__gm82snd_mapid,name+"__3dconeout")
            conevol=ds_map_find_value(__gm82snd_mapid,name+"__3dconevol")
            
            vol=mindist/median(mindist,point_distance_3d(0,0,0,sx,sy,sz),maxdist)
            
            if (conevol<1) {
                dir=angle_difference_3d(cx,cy,cz,-sx,-sy,-sz)
                vol*=lerp(1,conevol,median(0,(dir-anglein)/(angleout-anglein),1))
            }      
            
            __gm82snd_call("FMODInstanceSetPan",inst,lengthdir_x(1,point_direction(0,0,sx,sy+sz)))
            __gm82snd_call("FMODInstanceSetVolume",inst,vol)
            __gm82snd_call("FMODInstanceSetPitch",inst,1-(point_distance(0,0,sx+vx,sy+vy+sz+vz)-point_distance(0,0,sx,sy+sz))/spdmax)
        }
    }


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


#define sound_3d_set_sound_cone
//(snd,x,y,z,anglein,angleout,voloutside) 
    var anglein,angleout,att;
    
    if (is_real(argument0)) return 0

    if (sound_exists(argument0)) {
        __anglein=median(0,argument4,180)
        __angleout=median(anglein,argument5,180)
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
        __maxdist=median(mindist,argument2,1000000000)
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

    if (!string_pos(":",dir)) dir=working_directory+"\"+dir

    if (string_char_at(dir,string_length(dir))!="\")
        dir+="\"
    
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


#define sound_add_mic
//todo

#define sound_mic_start
//todo

#define sound_mic_stop
//todo

#define sound_background_tempo
//(factor)
    var pitch;

    pitch=median(0,argument0,100)
    sound_pitch(__gm82snd_map("__bginst"),pitch)
    __gm82snd_map("__bgtempo",pitch)


#define sound_delete
//(index)
    var snd;
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
//(index)
    //nop
    return 0


#define sound_encrypt
//(fname,newfname)
    var pass;
    pass=__gm82snd_map("__passw")
    if (file_exists(argument0)) {
        if (pass!="") {
            __gm82snd_call("FMODEncryptFile",argument0,argument1,pass)
        } else show_error("Sound password not set.",0)
    } else show_error("File does not exist trying to encrypt sound: "+name,0)


#define sound_fade
//(index,value,time)
    //todo: uugghhhg more internal state


#define sound_get_kind
//(ind)
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


#define sound_get_length
//(index)
    var snd;    
    
    if (is_real(argument0)) {
        if (argument0) snd=__gm82snd_call("FMODInstanceGetSound",argument0)
        else {
            show_error("Sound is null.",0)
            return ""
        }
    } else snd=__gm82snd_fmodid(argument0)
    
    if (snd)
        return __gm82snd_call("FMODSoundGetLength",snd)/1000
        
    show_error("Sound does not exist: "+string(argument0),0)
    return 0


#define sound_get_name
//(index)
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
        return filename_change_ext(__gm82snd_map(name+"__filename"),"")
    }
    
    show_error("Sound does not exist: "+string(name),0)
    return ""
    

#define sound_get_preload
//(index)
    if (is_real(argument0)) if (argument0) {
        return 1
    }
    
    return sound_exists(argument0)


#define sound_get_pos
//(index)
    if (is_real(argument0)) if (argument0) {
        return __gm82snd_call("FMODInstanceGetPosition",argument0)
    }    
    
    show_error("Sound is not an instance: "+string(argument0),0)
    return 0

#define sound_set_pos
//(index,pos)
    if (is_real(argument0)) if (argument0) {
        return __gm82snd_call("FMODInstanceSetPosition",argument0,median(0,argument1,1))
    }    
    
    show_error("Sound is not an instance: "+string(argument0),0)
    return 0
    

#define sound_global_volume
//(value)
    __gm82snd_call("FMODMasterSetVolume",median(0,argument0,1))


#define sound_isplaying
//(index)
    if (is_real(argument0)) if (argument0) return __gm82snd_call("FMODInstanceIsPlaying",argument0)
    
    if (sound_exists(argument0)) 
        return !ds_list_empty(__gm82snd_instlist(argument0))
    
    show_error("Sound does not exist: "+string(argument0),0)
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
        if (kind==1) group=1 //music
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


#define sound_loop
//(index)
    return __gm82snd_instantiate(argument0,"FMODSoundLoop",0,1)


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


#define sound_pan
//(index,value)
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


#define sound_password
//(string)
    __gm82snd_map("__passw",string(argument0))
    __gm82snd_call("FMODSetPassword",string(argument0))


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


#define sound_play
//(index)
    return __gm82snd_instantiate(argument0,"FMODSoundPlay",0)


#define sound_play_ex
//(index,[volume,pitch,pan])
    var snd;
    
    if (argument_count>1) {
        snd=__gm82snd_instantiate(argument[0],"FMODSoundPlay",1)
        sound_volume(snd,argument[1])
        if (argument_count>2) sound_pitch(snd,argument[2])
        if (argument_count>3) sound_pan(snd,argument[3])
        sound_resume(snd)
    } else {
        snd=__gm82snd_instantiate(argument[0],"FMODSoundPlay",0)
    }
    
    return snd


#define sound_play_paused
//(index,[volume,pitch,pan])
    var snd;
    
    snd=__gm82snd_instantiate(argument[0],"FMODSoundPlay",1)
        
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
    inst=__gm82snd_instantiate(name,"FMODSoundPlay",0)
    __gm82snd_map(name+"__single",inst)
    return inst


#define sound_loop_single
    var inst,name;
    name=string(argument0)
    inst=__gm82snd_map(name+"__single")
    if (inst) __gm82snd_call("FMODInstanceStop",inst) 
    inst=__gm82snd_instantiate(name,"FMODSoundLoop",0)
    __gm82snd_map(name+"__single",inst)
    return inst


#define sound_replace
//sound_replace(index,fname,kind,preload)
    var name,snd,kind,list,i;
    name=string(argument0)
    
    if (sound_exists(argument0)) {        
        __gm82snd_stopallof(name)
        snd=__gm82snd_fmodid(argument0)
        __gm82snd_call("FMODSoundFree",snd)
        ds_map_delete(__gm82snd_mapid,snd)        
        
        for (i=0;i<4;i+=1) {
            list=__gm82snd_map("__kindlist"+string(i))
            j=ds_list_find_index(list,name)
            if (j!=-1) ds_list_delete(list,j)
        }
        
        kind=median(0,round(argument1),3)
        
        ds_list_add(__gm82snd_map("__kindlist"+string(kind)),name)    
        
        if (argument3) {
            snd=__gm82snd_call("FMODSoundAdd",argument1,0,kind)
            __gm82snd_map(name+"__fmodid",snd)
            __gm82snd_map(snd,name)
        }
        __gm82snd_map(name+"__kind",kind)
        __gm82snd_map(name+"__loaded",-1+2*!!argument3)
        __gm82snd_map(name+"__filename",argument1)

        return 1
    }
    
    show_error("Sound does not exist: "+name,0)
    return 0


#define sound_restore
//(index)
    //nop
    return 0


#define sound_set_loop
//(index,loopstart,loopend)
    var a,b;
    
    if (sound_exists(argument0)) {
        a=median(0,argument1,1)
        b=median(a,argument2,1)
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
    

#define sound_stop
//(index)
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
        return 0
    }
    if (sound_exists(argument0)) {
        __gm82snd_stopallof(argument0)
        return 0
    }
    show_error("Sound does not exist: "+string(argument0),0)
    return 0


#define sound_stop_all
//()
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


#define sound_volume
//(index,value)
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

#define __gm82snd_geterrorstr
    switch (argument0)
    {
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
//
//