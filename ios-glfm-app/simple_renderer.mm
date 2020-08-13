#include "simple_renderer.h"

#include <array>

namespace {
// clang-tidy off
size_t constexpr VERTEX_COUNT = 6;
const std::array<float, VERTEX_COUNT * 8> vertexData{
    0.5, -0.5, 0.0, 1.0,     1.0, 0.0, 0.0, 1.0,
    -0.5, -0.5, 0.0, 1.0,     0.0, 1.0, 0.0, 1.0,
    -0.5,  0.5, 0.0, 1.0,     0.0, 0.0, 1.0, 1.0,

    0.5,  0.5, 0.0, 1.0,     1.0, 1.0, 0.0, 1.0,
    0.5, -0.5, 0.0, 1.0,     1.0, 0.0, 0.0, 1.0,
    -0.5,  0.5, 0.0, 1.0,     0.0, 0.0, 1.0, 1.0,
};
// clang-tidy on

}  // namespace

namespace metal {

SimpleRenderer::SimpleRenderer(GLFMDisplay* display) {
    view = (__bridge MTKView*)glfmGetMetalView(display);
    view.colorPixelFormat = MTLPixelFormatBGRA8Unorm;
    device = view.device;
    commandQueue = [device newCommandQueue];

    renderPassDescriptor = [MTLRenderPassDescriptor new];
    renderPassDescriptor.colorAttachments[0].loadAction = MTLLoadActionClear;
    renderPassDescriptor.colorAttachments[0].storeAction = MTLStoreActionStore;
    renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(1, 1, 1, 1);
}

void SimpleRenderer::render(GLFMDisplay* display, double frameTime) {
    int width, height;
    glfmGetDisplaySize(display, &width, &height);
    view.drawableSize = CGSizeMake(width, height);

    @autoreleasepool {
        commandBuffer = [commandQueue commandBuffer];
        commandBuffer.label = @"SimpleRenderer Command Buffer (GLFM)";

        renderPassDescriptor.colorAttachments[0].texture = view.currentDrawable.texture;

        renderCommandEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];

        auto vertexBuffer = [device newBufferWithBytes:vertexData.data()
                                                length:sizeof(float) * vertexData.size()
                                               options:MTLResourceOptionCPUCacheModeDefault];

        id<MTLLibrary> library = [device newDefaultLibrary];
        id<MTLFunction> vertexProgram = [library newFunctionWithName:@"vertex_function"];
        id<MTLFunction> fragmentProgram = [library newFunctionWithName:@"fragment_function"];

        MTLRenderPipelineDescriptor* pipelineStateDescriptor = [[MTLRenderPipelineDescriptor alloc] init];
        [pipelineStateDescriptor setVertexFunction:vertexProgram];
        [pipelineStateDescriptor setFragmentFunction:fragmentProgram];
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = MTLPixelFormatBGRA8Unorm;
        id<MTLRenderPipelineState> pipelineState = [device newRenderPipelineStateWithDescriptor:pipelineStateDescriptor
                                                                                          error:nil];

        [renderCommandEncoder setRenderPipelineState:pipelineState];
        [renderCommandEncoder setVertexBuffer:vertexBuffer offset:0 atIndex:0];
        [renderCommandEncoder drawPrimitives:MTLPrimitiveTypeTriangle vertexStart:0 vertexCount:(NSInteger) VERTEX_COUNT];

        [renderCommandEncoder endEncoding];

        [commandBuffer presentDrawable:view.currentDrawable];
        [commandBuffer commit];
    }
}

}  // namespace metal
