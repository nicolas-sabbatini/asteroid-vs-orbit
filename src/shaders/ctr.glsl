// https://www.shadertoy.com/view/ltf3WB
extern vec2 iResolution;

// Will return a value of 1 if the 'x' is < 'value'
float Less(float x, float value)
{
    return 1.0 - step(value, x);
}

// Will return a value of 1 if the 'x' is >= 'lower' && < 'upper'
float Between(float x, float lower, float upper)
{
    return step(lower, x) * (1.0 - step(upper, x));
}

//	Will return a value of 1 if 'x' is >= value
float GEqual(float x, float value)
{
    return step(value, x);
}

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    float brightness = 1.5;
    vec2 uv = screen_coords.xy / iResolution.xy;
    uv.y = -uv.y;

    vec2 uvStep;
    uvStep.x = uv.x / (1.0 / iResolution.x);
    uvStep.x = mod(uvStep.x, 3.0);
    uvStep.y = uv.y / (1.0 / iResolution.y);
    uvStep.y = mod(uvStep.y, 3.0);

    vec4 newColour = Texel(tex, texture_coords);

    newColour.r = newColour.r * step(1.0, (Less(uvStep.x, 1.0) + Less(uvStep.y, 1.0)));
    newColour.g = newColour.g * step(1.0, (Between(uvStep.x, 1.0, 2.0) + Between(uvStep.y, 1.0, 2.0)));
    newColour.b = newColour.b * step(1.0, (GEqual(uvStep.x, 2.0) + GEqual(uvStep.y, 2.0)));

    return newColour * brightness;
}
