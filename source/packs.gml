#define sound_create_pack
    ///sound_create_pack(sourcedir,filename)
    //sourcedir: directory to load files from
    //filename: filename to save the pack to
    //Creates a sound pack containing supported files from the source directory.
    var __dir,__save,__q,__fn,__size,__mb,__b;
    
    __dir=filename_dir(argument0)
    __save=argument1

    __q=ds_queue_create()

    for (__fn=file_find_first(__dir+"\*.*",0);__fn!="";__fn=file_find_next()) {
        if (__gm82snd_supported(__fn))
            ds_queue_enqueue(__q,__dir+"\"+__fn)
    } file_find_close()

    __size=ds_queue_size(__q)

    __mb=buffer_create()
    __b=buffer_create()

    buffer_write_string(__mb,"WASD1.0")
    buffer_write_u32(__mb,__size)

    repeat (__size) {__fn=ds_queue_dequeue(__q)
        buffer_load(__b,__fn)
        buffer_deflate(__b)
        buffer_write_string(__mb,filename_name(__fn))
        buffer_write_u32(__mb,buffer_get_size(__b))
        buffer_copy(__mb,__b)
        buffer_clear(__b)
    }

    buffer_save(__mb,__save)
    buffer_destroy(__mb)
    buffer_destroy(__b)
    ds_queue_destroy(__q)


#define sound_add_pack
    ///sound_add_pack(pack)
    //pack: path to pack file to load
    //returns: list with sounds added
    //Adds a sound pack for use.
    //Note: Make sure to delete the returned list when you're done.
    var __fn,__mb,__retlist,__b,__count,__name,__fname,__length,__pos;

    __fn=temp_directory+"\gm82\sound\wasd"

    __mb=buffer_create()
    buffer_load(__mb,argument0)

    if (buffer_read_string(__mb)!="WASD1.0") {buffer_destroy(__mb) show_error("Error loading WASD pack: file "+argument0+"is not a valid WASD pack.",0) return noone}

    __retlist=ds_list_create()
    __b=buffer_create()

    __count=buffer_read_u32(__mb)

    repeat (__count) {
        __name=buffer_read_string(__mb)
        __fname=__fn+filename_ext(__name)
        __name=filename_remove_ext(__name)
        __length=buffer_read_u32(__mb)
        __pos=buffer_get_pos(__mb)
        buffer_copy_part(__b,__mb,__pos,__length)
        buffer_set_pos(__mb,__pos+__length)
        buffer_inflate(__b)
        buffer_save_temp(__b,__fname)
        sound_add_ext(__fname,0,0,__name)
        file_delete(__fname)
        buffer_clear(__b)
        ds_list_add(__retlist,__name)
    }

    return __retlist


#define sound_unpack_pack
    ///sound_unpack_pack(pack,dir)
    //pack: path to pack file
    //dir: directory to unpack to
    //returns: list of files unpacked
    //unpacks the specified pack file to a directory.
    //Note: Make sure to delete the return list when you're done with it.
    var __dir,__mb,__retlist,__b,__count,__name,__fname,__length,__pos;

    __dir=argument1+"\"
    directory_create(__dir)

    __mb=buffer_create()
    buffer_load(__mb,argument0)

    if (buffer_read_string(__mb)!="WASD1.0") {buffer_destroy(__mb) show_error("Error loading WASD pack: file "+argument0+"is not a valid WASD pack.",0) return noone}

    __b=buffer_create()

    __count=buffer_read_u32(__mb)
    
    __retlist=ds_list_create()

    repeat (__count) {
        __name=buffer_read_string(__mb)
        __fname=__dir+"\"+__name
        __length=buffer_read_u32(__mb)
        __pos=buffer_get_pos(__mb)
        buffer_copy_part(__b,__mb,__pos,__length)
        buffer_set_pos(__mb,__pos+__length)
        buffer_inflate(__b)
        buffer_save(__b,__fname)
        buffer_clear(__b)
        ds_list_add(__retlist,__name)
    }
    
    return __retlist


#define sound_password
    ///sound_password(string)
    //string: password
    //Sets the password used to load encrypted files, and to encrypt files.
    
    __gm82snd_map("__passw",string(argument0))
    __gm82snd_call("FMODSetPassword",string(argument0))


#define sound_encrypt
    ///sound_encrypt(fname,newfname)
    //fname: file to encrypt
    //newfname: filename to save encrypted file to
    //Encrypts a sound file using the password set using sound_password().
    var pass;
    
    pass=__gm82snd_map("__passw")
    if (file_exists(argument0)) {
        if (pass!="") {
            __gm82snd_call("FMODEncryptFile",argument0,argument1,pass)
        } else show_error("Sound password not set.",0)
    } else show_error("File does not exist trying to encrypt sound: "+name,0)
