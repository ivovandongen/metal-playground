include_guard()

macro(_ios_target_defaults TARGET_NAME)
    set_target_properties(
            ${TARGET_NAME} PROPERTIES
            CMAKE_MACOSX_BUNDLE YES
            XCODE_ATTRIBUTE_BITCODE_GENERATION_MODE bitcode
            XCODE_ATTRIBUTE_CLANG_ENABLE_OBJC_ARC YES
            XCODE_ATTRIBUTE_ENABLE_BITCODE "YES"
            XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET "9.0"
            XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH $<$<CONFIG:Debug>:YES>
    )
    target_compile_options(${TARGET_NAME} PRIVATE "-fobjc-arc")
endmacro()

macro(target_defaults TARGET_NAME)
    if (CMAKE_SYSTEM_NAME STREQUAL iOS)
        _ios_target_defaults(${TARGET_NAME})
    endif()
endmacro()