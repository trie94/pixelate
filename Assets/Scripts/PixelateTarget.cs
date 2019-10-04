using UnityEngine;

/**
 * This should be attached to the targets that will be pixelated at runtime.
 * It registers the current gameobject to the pixelate target.
 */
public class PixelateTarget : MonoBehaviour
{
    private Renderer rend;
    public Renderer Renderer { get { return rend; } }
    public Material material;

    void Start()
    {
        rend = GetComponent<Renderer>();
        PixelateController.Instance.RegisterPixelateTarget(this);
    }
}
