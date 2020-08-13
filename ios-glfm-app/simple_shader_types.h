#pragma once

#include <simd/simd.h>

typedef struct
{
    float4 position;
    float4 color;
} VertexIn;

typedef struct {
    float4 position [[position]];
    float4 color;
} VertexOut;

