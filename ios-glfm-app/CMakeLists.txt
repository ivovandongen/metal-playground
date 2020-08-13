message(STATUS "Adding glfm ios app")

include(${PROJECT_SOURCE_DIR}/deps/glfm.cmake)

set(METAL_SHADERS simple_shaders.metal)

add_executable(
    ios-glfm-app
        main.cpp
        simple_renderer.h
        simple_renderer.mm
        simple_shader_types.h
        ${METAL_SHADERS}
)
set_source_files_properties(main.cpp PROPERTIES LANGUAGE OBJCXX)
set_source_files_properties(${METAL_SHADERS} PROPERTIES LANGUAGE METAL)


target_defaults(ios-glfm-app)

target_link_libraries(
    ios-glfm-app
        PRIVATE
        glfm
        "-framework CoreGraphics"
        "-framework Foundation"
        "-framework Metal"
        "-framework MetalKit"
        "-framework QuartzCore"
        "-framework UIKit"
)

set_source_files_properties(
    ${CMAKE_CURRENT_LIST_DIR}/LaunchScreen.storyboard
    ${METAL_SHADERS}
        PROPERTIES
        MACOSX_PACKAGE_LOCATION
        Resources
)

set_property(TARGET ios-glfm-app
    PROPERTY MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_LIST_DIR}/Info.plist
)