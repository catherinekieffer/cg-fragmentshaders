#version 300 es
precision mediump float;

// Input
in vec2 model_uv;

// Uniforms
uniform sampler2D image;
uniform float time;

// Output
out vec4 FragColor;

void main() {

    //scale and translate the texture coordinate such that it is in the range [-1.0, 1.0]
        // scale by 2 and subtract 1
    vec2 scaled_uv = model_uv * 2.0 - vec2(1.0); 
    
    //calculate radius = magnitude of texture coordinate, raised to the power of 1.5
    float magnitude = length(scaled_uv);
    float radius = pow(magnitude, 1.5);

    // calculate a texture coordinate offset = texture_coordinate * (sin(radius * 30.0 - time * 5.0) + 0.5) / 60.0
    vec2 texture_coord_offset = scaled_uv * (sin(radius * 30.0 - time * 5.0) + 0.5) / 60.0;

    //calculate final texture coordinate = original_texture_coordinate + texture_coordinate_offset
    vec2 final_text_coord = model_uv + texture_coord_offset;

    FragColor = texture(image, final_text_coord);
}
