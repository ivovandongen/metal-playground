include_guard()

add_library(
    glfm STATIC
        ${CMAKE_CURRENT_LIST_DIR}/glfm/src/glfm_platform_ios.m
)

target_defaults(glfm)

target_include_directories(
    glfm
        PUBLIC ${CMAKE_CURRENT_LIST_DIR}/glfm/include
)

target_link_libraries(
    glfm
        PUBLIC
        "-framework MetalKit" "-framework Metal" "-framework QuartzCore"
        "-framework GLKit" "-framework OpenGLES"
)

target_compile_definitions(
    glfm
        PUBLIC GLFM_INCLUDE_METAL=1
)
