Shader "Custom/Scrolling"
{
    Properties
    {
        _MainTex("Base (RGB)", 2D) = "white" {}
        _ScrollingSpeed("Distortion speed", Range(0,10)) = 0.5
        _Bright("Bright", Range(0,1)) = 0.4
    }
        SubShader{
            Tags { "RenderType" = "Opaque" }
            LOD 200

            CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _MainTex;
            float _ScrollingSpeed;
            float _Bright;

            struct Input {
                float2 uv_MainTex;
            };

            void surf(Input IN, inout SurfaceOutput o) {
                half4 c = tex2D(_MainTex, IN.uv_MainTex.y + float2(0, 3) + _Time / _ScrollingSpeed);

                o.Albedo = c.rgb / _Bright;
                o.Alpha = c.a;
            }
            ENDCG
        }
            FallBack "Diffuse"
}

