#include <glfm.h>

#include <iostream>
#include <memory>

#include "simple_renderer.h"

namespace {
std::unique_ptr<metal::SimpleRenderer> renderer;
}

void glfmMain(GLFMDisplay *display) {
    glfmSetDisplayConfig(display, GLFMRenderingAPIMetal, GLFMColorFormatRGBA8888, GLFMDepthFormat16, GLFMStencilFormat8,
                         GLFMMultisampleNone);

    glfmSetSurfaceCreatedFunc(display, [](GLFMDisplay *d, auto width, auto height) {
        GLFMRenderingAPI api = glfmGetRenderingAPI(d);
        std::cout << "Surface created: " << width << ":" << height << std::endl;
        std::cout << "Using: " << [&] {
            switch (api) {
                case GLFMRenderingAPIOpenGLES2:
                    return "OpenGL ES2";
                case GLFMRenderingAPIOpenGLES3:
                    return "OpenGL ES3";
                case GLFMRenderingAPIOpenGLES31:
                    return "OpenGL ES31";
                case GLFMRenderingAPIOpenGLES32:
                    return "OpenGL ES32";
                case GLFMRenderingAPIMetal:
                    return "Metal";
            }
        }() << std::endl;

        renderer = std::make_unique<metal::SimpleRenderer>(d);
    });

    glfmSetMainLoopFunc(display, [](GLFMDisplay *d, double frameTime) {
        renderer->render(d, frameTime);
    });

    glfmSetSurfaceDestroyedFunc(display, [](GLFMDisplay *) {
        std::cout << "Surface destroyed" << std::endl;
        renderer.reset();
    });
}
