Shader "Unlit/PixelateTarget"
{
	Properties
	{
		_ObjectColor ("Color", Color) = (1,0,0,1)
	}
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent"}
        LOD 100
		Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
			#include "AutoLight.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
				float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
				float3 worldNormal : NORMAL;
				SHADOW_COORDS(1)
            };

			fixed4 _ObjectColor;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				o.worldNormal = mul((float3x3)unity_ObjectToWorld, v.normal);
				TRANSFER_SHADOW(o);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
				float4 lighting = saturate(dot(normalize(_WorldSpaceLightPos0.xyz), i.worldNormal)) + 0.5;
				lighting.a = 1;
				float attenuation = SHADOW_ATTENUATION(i); 

				fixed4 col = _ObjectColor * lighting * attenuation;
                return col;
            }
            ENDCG
        }
    }
}
