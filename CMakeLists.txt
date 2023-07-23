cmake_minimum_required(VERSION 3.19)
project(gm82snd CXX)

set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

if(${CMAKE_CXX_COMPILER_ID} STREQUAL "MSVC")
    set(CMAKE_CXX_FLAGS "/O2 /GS- /W2 /WX")
endif()

add_library(gm82snd SHARED GMFMODSimpleGrix/source/main_STUDIO.cpp)

target_include_directories(gm82snd PRIVATE GMFMODSimpleGrix/source)
target_link_directories(gm82snd PRIVATE GMFMODSimpleGrix/source)
target_link_libraries(gm82snd fmodex_vc)

set(UPX_PATH "upx" CACHE STRING "Path to upx.exe if applicable")
if(NOT UPX_PATH STREQUAL "")
	add_custom_command(
		TARGET gm82snd
		POST_BUILD	
		COMMAND ${UPX_PATH} --lzma ${CMAKE_BINARY_DIR}/$<CONFIG>/gm82snd.dll
	)
endif()

option(INSTALL_GEX "Install the generated .gex" OFF)

set(GEX_URL https://raw.githubusercontent.com/GM82Project/gm82gex/main/gm82gex.py)
set(GEX_PY ${CMAKE_SOURCE_DIR}/gm82gex.py)
file(DOWNLOAD ${GEX_URL} STATUS DOWNLOAD_STATUS)
list(GET DOWNLOAD_STATUS 0 STATUS_CODE)
if(${STATUS_CODE} EQUAL 0)
	file(DOWNLOAD ${GEX_URL} ${GEX_PY})
else()
	message(WARNING "Couldn't redownload gm82gex.py")
endif()

if (INSTALL_GEX)
	add_custom_command(
		TARGET gm82snd
		POST_BUILD
		COMMAND py ${GEX_PY} gm82snd.gej
		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
		COMMENT "Building .gex"
	)
else()
	add_custom_command(
		TARGET gm82snd
		POST_BUILD
		COMMAND py ${GEX_PY} gm82snd.gej --noinstall
		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
		COMMENT "Building .gex"
	)
endif()