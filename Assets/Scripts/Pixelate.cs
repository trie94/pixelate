using UnityEngine;

/**
 * This is responsible for pixelating the entire scene.
 * Simply attach this script to the camera object.
 */
[RequireComponent(typeof(Camera))]
public class Pixelate : MonoBehaviour
{
    private Material material;
    [SerializeField]
    private int pixelDensity = 64;

    private void OnEnable()
    {
        material = new Material(Shader.Find("Unlit/Pixelate"));
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Vector2 aspectRatioData;
        if (Screen.height > Screen.width)
        {
            aspectRatioData = new Vector2((float)Screen.width / Screen.height, 1);
        }
        else
        {
            aspectRatioData = new Vector2(1, (float)Screen.height / Screen.width);
        }

        material.SetVector("_AspectRatioMultiplier", aspectRatioData);
        material.SetInt("_PixelDensity", pixelDensity);
        Graphics.Blit(source, destination, material);
    }
}
