using UnityEngine;

public class PixelateComposite : MonoBehaviour
{
    private Material pixelateCompositeMat;
    [SerializeField]
    private int pixelDensity = 64;

    private void OnEnable()
    {
        pixelateCompositeMat = new Material(Shader.Find("Unlit/PixelateComposite"));
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

        pixelateCompositeMat.SetVector("_AspectRatioMultiplier", aspectRatioData);
        pixelateCompositeMat.SetInt("_PixelDensity", pixelDensity);
        Graphics.Blit(source, destination, pixelateCompositeMat);
    }
}
