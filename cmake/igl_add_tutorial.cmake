function(igl_add_tutorial name)
    message(${ARGN} 1)
    # Only create tutorial if dependencies have been enabled in the current build
    foreach(module IN ITEMS ${ARGN})
        if(NOT TARGET ${module})
            return()
        endif()
    endforeach()
    

    message(STATUS "Creating libigl tutorial: ${name}")
    # get all cpp files in ${CMAKE_CURRENT_SOURCE_DIR}/${name}/
    file(GLOB SRCFILES ${CMAKE_CURRENT_SOURCE_DIR}/${name}/*.cpp)
    add_executable(${name} ${SRCFILES})
    message(${APPLE})
    if(APPLE)
    
        FIND_LIBRARY(COCOA_LIBRARY Cocoa)
        FIND_LIBRARY(OpenGL_LIBRARY OpenGL)
        FIND_LIBRARY(IOKit_LIBRARY IOKit)
        FIND_LIBRARY(CoreVideo_LIBRARY CoreVideo)
        MARK_AS_ADVANCED(COCOA_LIBRARY OpenGL_LIBRARY)
        SET(APPLE_LIBS ${COCOA_LIBRARY} ${IOKit_LIBRARY} ${OpenGL_LIBRARY} ${CoreVideo_LIBRARY})
    endif()
    target_link_libraries(${name} PRIVATE
        # ${APPLE_LIBS}
        igl::core
        igl::tutorial_data
        ${DEST_DATA_FOLDER}
        ${ARGN}
    )
    set_target_properties(${name} PROPERTIES FOLDER Libigl_Tutorials)
endfunction()
