#pragma once

#include <glfm.h>

#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>

namespace metal {

class SimpleRenderer {
public:
    explicit SimpleRenderer(GLFMDisplay* display);
    void render(GLFMDisplay* display, double frameTime);
private:
    MTKView* view = nullptr;
    id<MTLCommandQueue> commandQueue = nil;
    id<MTLCommandBuffer> commandBuffer = nil;
    id<MTLRenderCommandEncoder> renderCommandEncoder = nil;
    id<MTLDevice> device = nil;
    MTLRenderPassDescriptor *renderPassDescriptor = nil;
};

} // namespace metal