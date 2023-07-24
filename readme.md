# gm82snd
This is a replacement audio engine for Game Maker 8.2. Adding the extension completely replaces the builtin sound functions, bringing the audio engine near up to spec with GM:Studio.

Features:

- many common audio formats are supported
  - wav, ogg, mp3, midi, mod, it, s3m, xm, aif, flac, wma
- stream music from files on disk
- create and control individual sound instances
- pitch, loop points, pause, seek, pan, etc
- positional 3d sound
- chainable sound effects

Read the [included manual](Game Maker 8.2 Sound.txt) for usage instructions.

### notes
This extension requires [gm82core](https://github.com/omicronrex/gm82core).

Moreover, usage of this extension is bound by Firelight's licensing terms due to usage of legacy [FmodEx](https://www.fmod.com) technology.
