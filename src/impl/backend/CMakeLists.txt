cmake_minimum_required(VERSION 3.14)
cmake_policy(SET CMP0091 NEW)
project(cimgui_impl)

set (CMAKE_CXX_STANDARD 11)

set (BACKENDS_FOLDER "../../../cimgui/cimgui/imgui/backends")

find_package(glfw3 REQUIRED)
find_package(GLEW REQUIRED)

include_directories(../../../cimgui/cimgui/imgui)
add_definitions("-DIMGUI_DISABLE_OBSOLETE_FUNCTIONS=1")

add_definitions("-DIMGUI_IMPL_API=extern \"C\" ")

# Compile the backends once, position independent, for both libraries
add_library(cimgui SHARED IMPORTED)
set_target_properties(cimgui PROPERTIES
    IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/../../../cimgui/dllcimgui.so
    INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_SOURCE_DIR}/../../../cimgui/cimgui/)
add_library(${PROJECT_NAME}_objects OBJECT imgui_impl_opengl3.cpp imgui_impl_glfw.cpp)
set_target_properties(${PROJECT_NAME}_objects PROPERTIES POSITION_INDEPENDENT_CODE ON)
add_library(${PROJECT_NAME} SHARED)
add_library(${PROJECT_NAME}_static STATIC)
set_target_properties(${PROJECT_NAME}_static PROPERTIES OUTPUT_NAME ${PROJECT_NAME})
target_link_libraries(${PROJECT_NAME} ${PROJECT_NAME}_objects)
target_link_libraries(${PROJECT_NAME}_static ${PROJECT_NAME}_objects)

target_compile_definitions(${PROJECT_NAME}_objects PUBLIC
    -DCIMGUI_USE_OPENGL3
    -DCIMGUI_USE_GLFW)
if(${CMAKE_SYSTEM_NAME} STREQUAL "Darwin")
    find_package(OpenGL REQUIRED)
    target_link_libraries(${PROJECT_NAME}_objects cimgui glfw GLEW::GLEW OpenGL::GL)
else()
    target_link_libraries(${PROJECT_NAME}_objects cimgui glfw GLEW::GLEW)
endif()
