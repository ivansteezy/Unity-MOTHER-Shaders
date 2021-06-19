Shader "Custom/DoubleOscillationScrolling"
{
    Properties
    {
        _MainTex("Base (RGB)", 2D) = "white" {}
        _MainTex2("Base (RGB)", 2D) = "white" {}
        _DistortionFrequency("Distortion frequency", Range(1,256)) = 50
        _DistortionScale("Distortion scale", Range(0,1)) = 0.1
        _DistortionSpeed("Distortion speed", Range(0,10)) = 0.5

        _ScrollingSpeed("scrolling speed", Range(0,10)) = 0.5
        _ScrollXSpeed("X", Range(0,10)) = 2
        _ScrollYSpeed("Y", Range(0,10)) = 3

        _Bright("Bright", Range(0,10)) = 0.6
    }
    SubShader{
        Tags { "RenderType" = "Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        sampler2D _MainTex2;
        float _DistortionFrequency;
        float _DistortionScale;
        float _DistortionSpeed;
        float _Bright;

        float _ScrollingSpeed;
        fixed _ScrollXSpeed;
        fixed _ScrollYSpeed;

        struct Input {
            float2 uv_MainTex;
            float2 uv_MainTex2;
        };

        void surf(Input IN, inout SurfaceOutput o) {
            float2 uv_MainTexOdd = float2(IN.uv_MainTex.x + 1, IN.uv_MainTex.y + 1);


            fixed2 scrolledUVx = IN.uv_MainTex;
            fixed2 scrolledUVy = IN.uv_MainTex;

            fixed xScrollValue = _ScrollXSpeed * _Time / _ScrollingSpeed;
            fixed yScrollValue = _ScrollYSpeed * _Time / _ScrollingSpeed;

            scrolledUVx += fixed2(yScrollValue, xScrollValue);
            scrolledUVy += fixed2(xScrollValue, yScrollValue);

            half4 c = tex2D(_MainTex, uv_MainTexOdd   + float2(_DistortionScale / 3, 0) *  sin((_Time * _DistortionSpeed / 1.3 + IN.uv_MainTex.y)  * _DistortionFrequency / 2) + scrolledUVx) +
                      tex2D(_MainTex2, IN.uv_MainTex2 + float2(_DistortionScale / 3, 0) * -sin((_Time * _DistortionSpeed / 1.3 + IN.uv_MainTex2.y) * _DistortionFrequency / 2) + scrolledUVy);


            o.Albedo = c.rgb / _Bright;
            o.Alpha = c.a;
        }
        ENDCG
        }
            FallBack "Diffuse"
}