def setup():
    size(50, 50, P2D)
    gradientShader = loadShader("shader.glsl")
    k = createGraphics(500, 500, P2D)
    k.filter(gradientShader)
    k.save("gradient.png")
    exit()