message(STATUS "Adding glfm ios app")

include(${PROJECT_SOURCE_DIR}/deps/glfm.cmake)

add_executable(
    ios-glfm-app
        main.cpp
)

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
        PROPERTIES
        MACOSX_PACKAGE_LOCATION
        Resources
)

set_property(TARGET ios-glfm-app
    PROPERTY MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_LIST_DIR}/Info.plist
)