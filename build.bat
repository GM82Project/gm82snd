del build\release\gm82snd.dll

cmake -B build -A Win32 -DINSTALL_GEX=ON && cmake --build build --config Release

pause
