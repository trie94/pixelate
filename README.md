# Pixelate Shaders in Unity
This is a sample Unity project that contains pixelate and selective pixelate shaders.

## Pixelate Shader
![pixelate](/ReadmeImages/allPixelate.png)

This is a simple shader in which it pixelates the entire scene. Simply attach the _Pixelate_ script on to the Camera. You can refer to _pixelated_ scene. Since this pixelates the entire scene, you can use any material/ shader to the game objects in the scene.

## Selective Pixelate Shader
![selective pixelate](/ReadmeImages/selectivePixelate.png)

This pixelates only the target objects that have _Pixelate Target_ script attached. You will not be able to see the pixelated objects until you enter the play mode. Command buffer is used to achieve this effect.

Here is how it works: we first get a clean background texture without the target objects drawn.
To achieve this, target objects have an _invisible_ shader attached to begin with. Once we get the background texture, it's time to draw the target objects with materials that we want to render with, and save it to the _PixelatedTexture_ in the _PixelateComposite_ shader. Now we have two textures, one without target objects, the other that only has target objects.
Finally, in the _PixelateComposite_ shader, we pixelate the texture that has the target objects, and combine it with the background texture.
Refer to _selectivePixelated_ scene for more details.


### Reference
* https://www.youtube.com/watch?v=SMLbbi8oaO8&t=1s
* https://www.bitshiftprogrammer.com/2018/05/pixelation-shader-unity-implementation.html
