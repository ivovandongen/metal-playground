#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

#import "simple_shader_types.h"

vertex VertexOut vertex_function(device VertexIn *vertices [[buffer(0)]],
                                uint vid [[vertex_id]]) {
    VertexOut out;
    out.position = vertices[vid].position;
    out.color = vertices[vid].color;
    return out;
}

fragment float4 fragment_function(VertexOut in [[stage_in]]) {
    return in.color;
}

