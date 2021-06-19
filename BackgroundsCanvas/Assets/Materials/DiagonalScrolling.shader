Shader "Custom/DiagonalScrolling"
{
    Properties
    {
        _MainTex("Base (RGB)", 2D) = "white" {}
        _ScrollingSpeed("Distortion speed", Range(0,10)) = 0.5
        _ScrollXSpeed("X", Range(0,10)) = 2
        _ScrollYSpeed("Y", Range(0,10)) = 3
        _Bright("Bright", Range(0,1)) = 0.4
    }
        SubShader{
            Tags { "RenderType" = "Opaque" }
            LOD 200

            CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _MainTex;
            float _ScrollingSpeed;
            fixed _ScrollXSpeed;
            fixed _ScrollYSpeed;
            float _Bright;

            struct Input {
                float2 uv_MainTex;
            };

            void surf(Input IN, inout SurfaceOutput o) {
                fixed2 scrolledUV = IN.uv_MainTex;

                fixed xScrollValue = _ScrollXSpeed * _Time / _ScrollingSpeed;
                fixed yScrollValue = _ScrollYSpeed * _Time / _ScrollingSpeed;

                scrolledUV += fixed2(xScrollValue, yScrollValue);

                half4 c = tex2D(_MainTex, scrolledUV);

                o.Albedo = c.rgb / _Bright;
                o.Alpha = c.a;
            }
            ENDCG
        }
            FallBack "Diffuse"
}


