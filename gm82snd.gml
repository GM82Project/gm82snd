#define __gm82snd_call
//(func,args,...)
    var call;

    call=__gm82snd_map("__dll_"+argument0)

    if (argument_count=1) return external_call(call)
    if (argument_count=2) return external_call(call,argument[1])
    if (argument_count=3) return external_call(call,argument[1],argument[2])
    if (argument_count=4) return external_call(call,argument[1],argument[2],argument[3])
    if (argument_count=5) return external_call(call,argument[1],argument[2],argument[3],argument[4])
    if (argument_count=6) return external_call(call,argument[1],argument[2],argument[3],argument[4],argument[5])


#define __gm82snd_define
//(func,args,...)
    var dll,call;
    
    dll="GMFMODSimple.dll"
    if (argument_count=1) call=external_define(dll,argument0,1,0,0)
    if (argument_count=2) call=external_define(dll,argument0,1,0,1,argument[1])
    if (argument_count=3) call=external_define(dll,argument0,1,0,2,argument[1],argument[2])
    if (argument_count=4) call=external_define(dll,argument0,1,0,3,argument[1],argument[2],argument[3])
    if (argument_count=5) call=external_define(dll,argument0,1,0,4,argument[1],argument[2],argument[3],argument[4])
    if (argument_count=6) call=external_define(dll,argument0,1,0,5,argument[1],argument[2],argument[3],argument[4],argument[5])

    __gm82snd_map("__dll_"+argument0,call)


#define __gm82snd_fmodid
//(index)
    return __gm82snd_map(string(argument0)+"__fmodid")


#define __gm82snd_init
    var p,dir;
    object_event_add(__gm82core_object,ev_step,ev_step_end,"__gm82snd_update()")

    //move gmfmod to a common location so that it doesn't leave a million copies behind
    directory_create(temp_directory+"\gm82\sound")     
    p=string_pos("\appdata\local\temp\gm_ttt_",string_lower(temp_directory))    
    dir=string_copy(temp_directory,1,p+19)+"gm82snd"    
    directory_create(dir)    
    file_rename(temp_directory+"\gm82\fmodex.dll",dir+"\fmodex.dll")
    file_rename(temp_directory+"\gm82\GMFMODSimple.dll",dir+"\GMFMODSimple.dll")
    
    __gm82core_setdir(dir)
    
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

    __gm82snd_define("FMODCreateSoundFromMicInput")
    __gm82snd_define("FMODRecordStart",ty_real)
    __gm82snd_define("FMODRecordStop")
    
    __gm82snd_define("FMODInstanceAddEffect",ty_real,ty_real)
    __gm82snd_define("FMODGroupAddEffect",ty_real,ty_real)
    __gm82snd_define("FMODEffectFree",ty_real)
    __gm82snd_define("FMODEffectSetParamValue",ty_real,ty_real,ty_real)

    __gm82snd_define("FMODGroupStop",ty_real)
    __gm82snd_define("FMODGroupSetVolume",ty_real,ty_real)
    __gm82snd_define("FMODGroupSetPaused",ty_real,ty_real)
    __gm82snd_define("FMODGroupSetPitch",ty_real,ty_real)
    __gm82snd_define("FMODGroupSetPan",ty_real,ty_real)

    __gm82snd_define("FMODInstanceStop",ty_real)
    __gm82snd_define("FMODInstanceIsPlaying",ty_real)
    __gm82snd_define("FMODInstanceGetPosition",ty_real)
    __gm82snd_define("FMODInstanceGetSound",ty_real)
    __gm82snd_define("FMODInstanceSetVolume",ty_real,ty_real)
    __gm82snd_define("FMODInstanceSetPaused",ty_real,ty_real)
    __gm82snd_define("FMODInstanceSetPosition",ty_real,ty_real)
    __gm82snd_define("FMODInstanceSetPan",ty_real,ty_real)      
    __gm82snd_define("FMODInstanceSetPitch",ty_real,ty_real)

    __gm82snd_call("FMODinit",64,0)

    __gm82core_setdir(working_directory)

    __gm82snd_map("__bginst",0)
    __gm82snd_map("__bgtempo",1)
    __gm82snd_map("__passw","")
    __gm82snd_map("__3dlist",ds_list_create())
    __gm82snd_map("__globlist",ds_list_create())


#define __gm82snd_deinit
    __gm82snd_call("FMODAllStop")
    __gm82snd_call("FMODfree")
    external_free("GMFMODSimple.dll")


#define __gm82snd_instantiate
//(index,loop)
    var snd,kind,inst,pitch,pan,vol,flags,name,list,list2;
    name=string(argument0)
    snd=__gm82snd_fmodid(name)
    if (!snd) {
        sound_restore(name)        
        snd=__gm82snd_fmodid(name)
    }
    
    if (snd) {
        kind=sound_get_kind(name)
        if (kind==1) sound_stop(__gm82snd_map("__bginst"))

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
    }
    show_error("Sound does not exist: "+name,0)
    return 0


#define __gm82snd_instlist
//(name)
    return __gm82snd_map(string(argument0)+"__instlist")


#define __gm82snd_isloaded
//(name)
    return __gm82snd_map(string(argument0)+"__loaded")
    

#define __gm82snd_map
//(key):value
//(key,value)
    if (argument_count=1) {
        return ds_map_find_value(__gm82snd_mapid,argument[0])
    } else {
        ds_map_set(__gm82snd_mapid,argument[0],argument[1])
    }


#define __gm82snd_setgroup
//(fmodid,group)
    var kind,group;

    kind=argument1

    if (kind=1) group=1 //music
    if (kind=3) group=2 //mmplay
    if (kind=2) group=3 //3d
    if (kind=0) group=4 //regular sfx

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
    for (i=0;i<l;i+=2) {
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
    }


#define __gm82snd_update3d
    var list3d,j,spd,spdmax,name,key,list,s,i,sx,sy,sz,mindist,maxdist,dir,vol,anglein,angleout,conevol;
    
    //speed of sound is 343 m/s
    spdmax=343
    
    //i've inlined all of the map readers in this function for performance concerns.
    
    list3d=ds_map_find_value(__gm82snd_mapid,"__3dlist")
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


#define sound_3d_set_sound_cone
//(snd,x,y,z,anglein,angleout,voloutside) 
    var name,load,mindist,maxdist;
    name=string(argument0)
    load=__gm82snd_isloaded(name)
    
    if (load!=0) {
        anglein=median(0,argument4,180)
        angleout=median(anglein,argument5,180)
        att=median(0,argument6/100,100)
        __gm82snd_map(name+"__3dconex",argument1)
        __gm82snd_map(name+"__3dconey",argument2)
        __gm82snd_map(name+"__3dconez",argument3)
        __gm82snd_map(name+"__3dconein",anglein)
        __gm82snd_map(name+"__3dconeout",angleout)
        __gm82snd_map(name+"__3dconevol",1/power(10,att/20))
        __gm82snd_update3d()
    } else {
        show_error("Sound does not exist: "+name,0)
    }    
    


#define sound_3d_set_sound_distance
//(snd,mindist,maxdist)
    var name,load,mindist,maxdist;
    name=string(argument0)
    load=__gm82snd_isloaded(name)
    
    if (load!=0) {
        mindist=median(1,argument1,1000000000)
        maxdist=median(mindist,argument2,1000000000)
        __gm82snd_map(name+"__3dmin",mindist)
        __gm82snd_map(name+"__3dmax",maxdist)
        __gm82snd_update3d()
    } else {
        show_error("Sound does not exist: "+name,0)
    }    
    

#define sound_3d_set_sound_position
//(snd,x,y,z)
    var name,load,sx,sy,sz;
    name=string(argument0)
    load=__gm82snd_isloaded(name)
    
    if (load!=0) {
        sx=argument1
        sy=argument2
        sz=argument3
        __gm82snd_map(name+"__3dx",sx)
        __gm82snd_map(name+"__3dy",sy)
        __gm82snd_map(name+"__3dz",sz)
    } else {
        show_error("Sound does not exist: "+name,0)
    }
    

#define sound_3d_set_sound_velocity
//(snd,x,y,z)
    var name,load,sx,sy,sz;
    name=string(argument0)
    load=__gm82snd_isloaded(name)
    
    if (load!=0) {
        sx=argument1
        sy=argument2
        sz=argument3
        __gm82snd_map(name+"__3dvx",sx)
        __gm82snd_map(name+"__3dvy",sy)
        __gm82snd_map(name+"__3dvz",sz)
    } else {
        show_error("Sound does not exist: "+name,0)
    }

#define sound_add
//(fname,kind,preload)
    var snd,name,kind;
    
    kind=median(0,round(argument1),3)

    if (argument2) {
        snd=__gm82snd_call("FMODSoundAdd",argument0,0,kind mod 2)
        __gm82snd_setgroup(snd,kind)
    } else
        snd=0
    
    name=filename_change_ext(filename_name(argument0),"")

    if (kind=2) {
        ds_list_add(__gm82snd_map("__3dlist"),name)
    }
    
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

    pitch=median(0.01,argument0,100)
    sound_pitch(__gm82snd_map("__bginst"),pitch)
    __gm82snd_map("__bgtempo",pitch)


#define sound_delete
//(index)
    var snd,name,loaded;
    name=string(argument0)
    
    loaded=__gm82snd_isloaded(name)
    
    if (loaded!=0) {
        if (loaded=1) {
            __gm82snd_stopallof(name)
            snd=__gm82snd_fmodid(name)
            __gm82snd_call("FMODSoundFree",snd)
            ds_map_delete(__gm82snd_mapid,name+"__loaded")
            ds_map_delete(__gm82snd_mapid,snd)
        }
        list=__gm82snd_map("__3dlist")
        i=ds_list_find_index(list,name)
        if (i!=-1) ds_list_delete(list,i)
        
        ds_list_destroy(__gm82snd_instlist(name))
        
        ds_map_delete(__gm82snd_mapid,name)
        ds_map_delete(__gm82snd_mapid,name+"__fmodid")
        ds_map_delete(__gm82snd_mapid,name+"__filename")
        ds_map_delete(__gm82snd_mapid,name+"__kind")
        ds_map_delete(__gm82snd_mapid,name+"__loaded")
        ds_map_delete(__gm82snd_mapid,name+"__pitch")
        ds_map_delete(__gm82snd_mapid,name+"__volume")
        ds_map_delete(__gm82snd_mapid,name+"__3dmin")
        ds_map_delete(__gm82snd_mapid,name+"__3dmax")
        ds_map_delete(__gm82snd_mapid,name+"__3dconevol")
        ds_map_delete(__gm82snd_mapid,name+"__instlist")
        
        return 1
    }
    show_error("Sound does not exist: "+name,0)
    return 0


#define sound_discard
//(index)
    var snd,name,loaded;
    name=string(argument0)
    
    loaded=__gm82snd_isloaded(name)
    
    if (loaded!=0) {
        if (loaded=1) {
            __gm82snd_stopallof(name)
            snd=__gm82snd_fmodid(name)
            __gm82snd_call("FMODSoundFree",snd)
            __gm82snd_map(name+"__loaded",-1)
            __gm82snd_map(snd,"")
        }
        return 0
    }
    show_error("Sound does not exist: "+name,0)
    return 0


#define sound_encrypt
//(fname,newfname)
    var pass;
    pass=__gm82snd_map("__passw")
    if (file_exists(argument0)) {
        if (pass!="") {
            __gm82snd_call("FMODEncryptFile",argument0,argument1,pass)
        } else show_error("Sound password not set.",0)
    } else show_error("File does not exist: "+name,0)


#define sound_exists
//(index)
    return (__gm82snd_isloaded(argument0)!=0)


#define sound_fade
//(index,value,time)
    //todo: uugghhhg more internal state


#define sound_get_kind
//(ind)
    var snd,name;
    name=string(argument0)
    
    if (is_real(argument0)) {
        snd=__gm82snd_call("FMODInstanceGetSound",argument0)
        return __gm82snd_map(__gm82snd_map(snd)+"__kind")
    } else {
        if (__gm82snd_map(argument0+"__loaded"))!=0 
        return __gm82snd_map(name+"__kind")
    }
    
    show_error("Sound does not exist: "+name,0)
    return 0


#define sound_get_length
//(index)
    var snd;    
    
    if (is_real(argument0)) snd=__gm82snd_call("FMODInstanceGetSound",argument0)
    else snd=__gm82snd_fmodid(argument0)
    
    if (snd)
        return __gm82snd_call("FMODSoundGetLength",snd)/1000
        
    show_error("Sound does not exist: "+name,0)
    return 0


#define sound_get_name
//(index)
    var snd,name; 
    
    if (is_real(argument0)) {
        snd=__gm82snd_call("FMODInstanceGetSound",argument0)
        name=__gm82snd_map(snd)
    } else {
        name=argument0
    }
    
    loaded=__gm82snd_isloaded(name)
    
    if (loaded!=0) {
        return filename_change_ext(__gm82snd_map(name+"__filename"),"")
    }
    
    show_error("Sound does not exist: "+name,0)
    return 0
    

#define sound_get_preload
//(index)
    var snd;
    
    if (is_real(argument0)) {
        snd=__gm82snd_call("FMODInstanceGetSound",argument0)
        return __gm82snd_map(__gm82snd_map(snd)+"__loaded")
    } else {
        loaded=__gm82snd_map(argument0+"__loaded")
        if (loaded!=0) return !!loaded
    }    
    
    show_error("Sound does not exist: "+string(argument0),0)
    return 0


#define sound_get_pos
//(index)
    var snd;
    
    if (is_real(argument0)) {
        //todo: add safety
        return __gm82snd_call("FMODInstanceGetPosition",argument0)
    }    
    
    show_error("Sound is not an instance: "+argument0,0)
    return 0

#define sound_set_pos
//(index,pos)
    var snd;
    
    if (is_real(argument0)) {
        //todo: add safety
        return __gm82snd_call("FMODInstanceSetPosition",argument0,median(0,argument1,1))
    }    
    
    show_error("Sound is not an instance.",0)
    return 0
    

#define sound_global_volume
//(value)
    __gm82snd_call("FMODMasterSetVolume",median(0,argument0,1))


#define sound_isplaying
//(index)
    var snd;  
    
    if (is_real(argument0)) return __gm82snd_call("FMODInstanceIsPlaying",argument0)
    
    snd=__gm82snd_fmodid(argument0)    
    if (snd) 
        return !ds_list_empty(__gm82snd_instlist(argument0))


#define sound_kind_pan
    var kind,group;

    kind=argument0

    if (kind=1) group=1 //music
    if (kind=3) group=2 //mmplay
    if (kind=2) group=3 //3d
    if (kind=0) group=4 //regular sfx

    __gm82snd_call("FMODGroupSetPan",group,median(-1,argument1,1))

#define sound_kind_pause
    var kind,group;

    kind=argument0

    if (kind=1) group=1 //music
    if (kind=3) group=2 //mmplay
    if (kind=2) group=3 //3d
    if (kind=0) group=4 //regular sfx

    __gm82snd_call("FMODGroupSetPaused",group,1)


#define sound_kind_stop
    var kind,group;

    kind=argument0

    if (kind=1) group=1 //music
    if (kind=3) group=2 //mmplay
    if (kind=2) group=3 //3d
    if (kind=0) group=4 //regular sfx

    __gm82snd_call("FMODGroupStop",group)


#define sound_kind_pitch
    var kind,group;

    kind=argument0

    if (kind=1) group=1 //music
    if (kind=3) group=2 //mmplay
    if (kind=2) group=3 //3d
    if (kind=0) group=4 //regular sfx

    __gm82snd_call("FMODGroupSetPitch",group,median(0.01,argument1,100))


#define sound_kind_resume
    var kind,group;

    kind=argument0

    if (kind=1) group=1 //music
    if (kind=3) group=2 //mmplay
    if (kind=2) group=3 //3d
    if (kind=0) group=4 //regular sfx

    __gm82snd_call("FMODGroupSetPaused",group,0)


#define sound_kind_volume
    var kind,group;

    kind=argument0

    if (kind=1) group=1 //music
    if (kind=3) group=2 //mmplay
    if (kind=2) group=3 //3d
    if (kind=0) group=4 //regular sfx

    __gm82snd_call("FMODGroupSetVolume",group,median(0,argument1,1))


#define sound_loop
//(index)
    return __gm82snd_instantiate(argument0,"FMODSoundLoop",0)


#define sound_loop_paused
//(index)
    return __gm82snd_instantiate(argument0,"FMODSoundLoop",1)


#define sound_pan
//(index,value)
    var snd,name,pan;
    name=string(argument0)
    pan=median(-1,argument1,1)
    
    loaded=__gm82snd_isloaded(name)
    
    if (loaded!=0) {
        __gm82snd_map(name+"__pan",pan)
        return 0
    } else if (is_real(argument0)) {
        __gm82snd_call("FMODInstanceSetPan",argument0,pan)
        return 0
    }
    
    show_error("Sound does not exist: "+name,0)
    return 0


#define sound_password
//(string)
    __gm82snd_map("__passw",string(argument0))
    __gm82snd_call("FMODSetPassword",string(argument0))


#define sound_pause
//(index)
    var snd,name,list,s,i;
    name=string(argument0)
    
    loaded=__gm82snd_isloaded(name)    
    
    if (loaded!=0) {
        if (loaded) {
            list=__gm82snd_instlist(name)
            s=ds_list_size(list)
            for (i=0;i<s;i+=1) {
                __gm82snd_call("FMODInstanceSetPaused",ds_list_find_value(list,i),1)
            }
        }
        return 0
    } else if (is_real(argument0)) {
        __gm82snd_call("FMODInstanceSetPaused",argument0,1)
        return 0
    }
    
    show_error("Sound does not exist: "+name,0)
    return 0


#define sound_pause_all
    sound_kind_pause(0)
    sound_kind_pause(1)
    sound_kind_pause(2)
    sound_kind_pause(3)


#define sound_resume_all
    sound_kind_resume(0)
    sound_kind_resume(1)
    sound_kind_resume(2)
    sound_kind_resume(3)


#define sound_pitch
//(index,value)
    var snd,name,loaded;
    name=string(argument0)
    
    loaded=__gm82snd_isloaded(name)
    
    if (loaded!=0) {
        __gm82snd_map(name+"__pitch",argument1)
        return 0
    } else if (is_real(argument0)) {
        __gm82snd_call("FMODInstanceSetPitch",argument0,argument1)
        return 0
    }
    
    show_error("Sound does not exist: "+name,0)
    return 0


#define sound_play
//(index)
    return __gm82snd_instantiate(argument0,"FMODSoundPlay",0)


#define sound_play_paused
//(index)
    return __gm82snd_instantiate(argument0,"FMODSoundPlay",1)


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
    var name,loaded,snd,kind,list;
    name=string(argument0)
    
    loaded=__gm82snd_isloaded(name)
    if (loaded!=0) {
        if (loaded) {
            __gm82snd_stopallof(name)
            snd=__gm82snd_fmodid(name)
            __gm82snd_call("FMODSoundFree",snd)
            ds_map_delete(__gm82snd_mapid,snd)
        }
        
        list=__gm82snd_map("__3dlist")
        
        if (__gm82snd_map(name+"__kind")==2) {
            ds_list_delete(list,ds_list_find_index(list,name))
        }
        
        kind=argument3 mod 2
        
        if (kind=2) {
            ds_list_add(__gm82snd_map("__3dlist"),name)
        }
        
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
    var snd,name,loaded;
    name=string(argument0)
    
    loaded=__gm82snd_isloaded(name)
    
    if (loaded!=0) {
        if (loaded=-1) {
            kind=__gm82snd_map(name+"__kind")
            snd=__gm82snd_call("FMODSoundAdd",__gm82snd_map(name+"__filename"),0,kind mod 2)
            
            __gm82snd_setgroup(snd,kind)
            __gm82snd_call("FMODSoundSetMaxVolume",snd,__gm82snd_map(name+"__volume"))
            
            __gm82snd_map(name+"__fmodid",snd)
            __gm82snd_map(name+"__loaded",1)
            __gm82snd_map(snd,name)
        }
        return 0
    }
    show_error("Sound does not exist: "+name,0)
    return 0


#define sound_resume
//(index)
    var snd,name,list,s,i;
    name=string(argument0)
    
    loaded=__gm82snd_isloaded(name)    
    
    if (loaded!=0) {
        if (loaded) {
            list=__gm82snd_instlist(name)
            s=ds_list_size(list)
            for (i=0;i<s;i+=1) {
                __gm82snd_call("FMODInstanceSetPaused",ds_list_find_value(list,i),0)
            }
        }
        return 0
    } else if (is_real(argument0)) {
        __gm82snd_call("FMODInstanceSetPaused",argument0,0)
        return 0
    }
    
    show_error("Sound does not exist: "+name,0)
    return 0


#define sound_set_loop
//(index,loopstart,loopend)
    var snd,name,a,b;
    name=string(argument0)
    
    loaded=__gm82snd_isloaded(name)
    
    if (loaded!=0) {
        if (loaded) {
            a=median(0,argument1,1)
            b=median(a,argument2,1)
            __gm82snd_call("FMODSoundSetLoopPoints",__gm82snd_fmodid(name),a,b)
            return 1
        }
        return 0
    }
    show_error("Sound does not exist: "+name,0)
    return 0
    

#define sound_stop
//(index)
    var snd,name;
    name=string(argument0)
    
    loaded=__gm82snd_isloaded(name)   
    if (loaded!=0) {
        if (loaded) {
            __gm82snd_stopallof(name)
        }
        return 0
    } else if (is_real(argument0)) {
        snd=__gm82snd_call("FMODInstanceGetSound",argument0)
        __gm82snd_call("FMODInstanceStop",argument0)        
        ds_list_delete(__gm82snd_instlist(__gm82snd_map(snd)),argument0)
        return 0
    }
    show_error("Sound does not exist: "+name,0)
    return 0


#define sound_stop_all
//(index)
    var key;
    __gm82snd_call("FMODAllStop")
    key=ds_map_find_first(__gm82snd_mapid)
    repeat (ds_map_size(__gm82snd_mapid)) {
        if (string_pos("__instlist",key))
            ds_list_clear(ds_map_find_value(__gm82snd_mapid,key))
        key=ds_map_find_next(__gm82snd_mapid,key)
    }
    ds_list_clear(__gm82snd_map("__globlist"))


#define sound_volume
//(index,value)
    var vol,name,loaded;
    name=string(argument0)
    vol=median(0,argument1,1)
    loaded=__gm82snd_isloaded(name)
    
    if (loaded!=0) {
        //sound id, set base volume
        if (loaded) __gm82snd_call("FMODSoundSetMaxVolume",__gm82snd_fmodid(name),vol)
        __gm82snd_map(name+"__volume",vol)
        return 0
    } else if (is_real(argument0)) {
        __gm82snd_call("FMODInstanceSetVolume",argument0,vol)
        return 0
    }
    
    show_error("Sound does not exist: "+name,0)
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
    } else if (is_real(argument0)) {
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
    var kind,group,ef;
    kind=argument0

    if (kind=1)   group=1 //music
    if (kind=3)   group=2 //mmplay
    if (kind=2)   group=3 //3d
    if (kind=0)   group=4 //regular sfx
    if (kind=all) group=0 //all
    
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
        if (ef=17) sound_effect_options(i,1,0.7)
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
    //nop
