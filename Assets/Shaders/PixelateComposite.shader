Shader "Unlit/PixelateComposite"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

			sampler2D _MainTex;
			sampler2D _PixelatedTexture;

			int _PixelDensity;
			float2 _AspectRatioMultiplier;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);

                // following two lines are the actual pixelate part
				float2 pixelScaling = _PixelDensity * _AspectRatioMultiplier;
				i.uv = round(i.uv * pixelScaling)/ pixelScaling;

                // composite pixelated part with the background
				fixed4 pixelated = tex2D(_PixelatedTexture, i.uv);
				col = col * (1-pixelated.a) + pixelated;
                return col;
            }
            ENDCG
        }
    }
}
