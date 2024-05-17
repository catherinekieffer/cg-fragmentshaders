#version 300 es
precision mediump float;

// Input
in vec2 model_uv;

// Uniforms
uniform sampler2D image;

// Output
out vec4 FragColor;

void main() {
    //scale and translate the texture coordinate such that it is in the range [-1.0, 1.0]
        // scale by 2 and subtract 1
    vec2 scaled_uv = model_uv * 2.0 - vec2(1.0); 
    
    //calculate 𝜽 = arctan(texture_coordinate_y, texture_coordinate_x)
    float theta = atan(scaled_uv.y, scaled_uv.x);

    //calculate radius = magnitude of texture coordinate, raised to the power of 1.5
    float magnitude = length(scaled_uv);
    float radius = pow(magnitude, 1.5);

    // calculate fish eye texture coordinate = (radius * cos(𝜽),  radius * sin(𝜽))
    vec2 fish_eye_text_coord = vec2(radius * cos(theta),  radius * sin(theta));

    // re-scale final texture coordinate in range [0.0, 1.0]
        // final texture coordinate = 0.5 * (fish eye texture coordinate + 1.0)
    vec2 final_fish_eye = 0.5 * (fish_eye_text_coord + 1.0);

    FragColor = texture(image, final_fish_eye);
}
