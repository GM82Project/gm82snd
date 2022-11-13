call "%VS120COMNTOOLS%vsvars32.bat"

del GMFMODSimple.dll

cd GMFMODSimpleGrix

msbuild GMFMODSimpleGrix.sln /property:Configuration=Release /p:WarningLevel=0

copy Release\GMFMODSimpleGrix.dll ..\GMFMODSimple.dll

cd ..

if exist GMFMODSimple.dll (
build_gex.py gm82snd.gej
)
pause