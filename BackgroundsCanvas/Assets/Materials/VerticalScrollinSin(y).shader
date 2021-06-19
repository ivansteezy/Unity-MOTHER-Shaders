Shader "Custom/VerticalOscillationX"
{
    Properties
    {
        _MainTex("Base (RGB)", 2D) = "white" {}
        _DistortionFrequency("Distortion frequency", Range(1,256)) = 50
        _DistortionScale("Distortion scale", Range(0,1)) = 0.1
        _DistortionSpeed("Distortion speed", Range(0,10)) = 0.5
        _Bright("Bright", Range(0,1)) = 0.4
    }
        SubShader{
            Tags { "RenderType" = "Opaque" }
            LOD 200

            CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _MainTex;
            float _DistortionFrequency;
            float _DistortionScale;
            float _DistortionSpeed;
            float _Bright;

            struct Input {
                float2 uv_MainTex;
                float2 rotatedTex;
            };

            void surf(Input IN, inout SurfaceOutput o) {
                float2 mtex;
                IN.rotatedTex.x = IN.uv_MainTex.y;
                IN.rotatedTex.y = IN.uv_MainTex.x;

                half4 c = tex2D(_MainTex, IN.rotatedTex + float2(0, _DistortionScale / 3) * sin((_Time * _DistortionSpeed / 1.3 + IN.rotatedTex.y) * _DistortionFrequency / 2));
                o.Albedo = c.rgb / _Bright;
                o.Alpha = c.a;
            }
            ENDCG
        }
            FallBack "Diffuse"
}