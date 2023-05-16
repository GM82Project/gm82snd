cmake_minimum_required(VERSION 3.19)
project(GMFMODSimple CXX)

set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

if(${CMAKE_CXX_COMPILER_ID} STREQUAL "MSVC")
    set(CMAKE_CXX_FLAGS "/O2 /GS- /W2 /WX")
endif()

add_library(GMFMODSimple SHARED GMFMODSimpleGrix/source/main_STUDIO.cpp)

target_include_directories(GMFMODSimple PRIVATE GMFMODSimpleGrix/source)
target_link_directories(GMFMODSimple PRIVATE GMFMODSimpleGrix/source)
target_link_libraries(GMFMODSimple fmodex_vc)

option(INSTALL_GEX "Install the generated .gex" OFF)

if (INSTALL_GEX)
	add_custom_command(
		TARGET GMFMODSimple
		POST_BUILD
		COMMAND py build_gex.py gm82snd.gej
		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
		COMMENT "Building .gex"
	)
else()
	add_custom_command(
		TARGET GMFMODSimple
		POST_BUILD
		COMMAND py build_gex.py gm82snd.gej --noinstall
		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
		COMMENT "Building .gex"
	)
endif()