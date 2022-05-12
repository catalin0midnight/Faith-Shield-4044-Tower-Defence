// Upgrade NOTE: upgraded instancing buffer 'HarbingerExhaust' to new syntax.

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Harbinger/Exhaust"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_MaskClipValue( "Mask Clip Value", Float ) = 1
		_Tint("Tint", Color) = (0,0,0,0)
		_Glow("Glow", Range( 0 , 10)) = 1
		_Exhaust("Exhaust", 2D) = "white" {}
		_UVTime("UVTime", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		Blend One One
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 5.0
		#pragma multi_compile_instancing
		#pragma surface surf StandardCustomLighting keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			fixed3 Albedo;
			fixed3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			fixed Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform sampler2D _Exhaust;
		uniform float4 _Exhaust_ST;
		uniform float _MaskClipValue = 1;

		UNITY_INSTANCING_BUFFER_START(HarbingerExhaust)
			UNITY_DEFINE_INSTANCED_PROP(float, _UVTime)
#define _UVTime_arr HarbingerExhaust
			UNITY_DEFINE_INSTANCED_PROP(float4, _Tint)
#define _Tint_arr HarbingerExhaust
			UNITY_DEFINE_INSTANCED_PROP(float, _Glow)
#define _Glow_arr HarbingerExhaust
		UNITY_INSTANCING_BUFFER_END(HarbingerExhaust)

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float _UVTime_Instance = UNITY_ACCESS_INSTANCED_PROP(_UVTime_arr, _UVTime);
			float2 uv_Exhaust = i.uv_texcoord * _Exhaust_ST.xy + _Exhaust_ST.zw;
			float4 _Tint_Instance = UNITY_ACCESS_INSTANCED_PROP(_Tint_arr, _Tint);
			float _Glow_Instance = UNITY_ACCESS_INSTANCED_PROP(_Glow_arr, _Glow);
			float3 componentMask11 = i.vertexColor.rgb;
			c.rgb = ( tex2D( _Exhaust, (abs( uv_Exhaust+( _Time.y * _UVTime_Instance ) * float2(0,1 ))) ) * _Tint_Instance * _Glow_Instance * i.vertexColor.a * float4( componentMask11 , 0.0 ) ).xyz;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
		}

		ENDCG
	}
	Fallback "Particles/Additive"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=12002
7;65;1857;968;2242.801;737;1.3;True;False
Node;AmplifyShaderEditor.TexturePropertyNode;16;-1621.401,-428.8996;Float;True;Property;_Exhaust;Exhaust;3;0;None;False;white;Auto;0;1;SAMPLER2D
Node;AmplifyShaderEditor.TimeNode;19;-1271.702,-185.8;Float;False;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;21;-1201.502,-19.39997;Float;False;InstancedProperty;_UVTime;UVTime;4;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-1283.398,-348.3003;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-988.3011,-124.7;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.PannerNode;13;-964.8975,-424.9996;Float;False;0;1;2;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.VertexColorNode;1;-508.8997,77.79994;Float;False;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;10;-615.1991,-55.99997;Float;False;InstancedProperty;_Glow;Glow;2;0;1;0;10;0;1;FLOAT
Node;AmplifyShaderEditor.ComponentMaskNode;11;-283.697,-8.999729;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.ColorNode;7;-557,-233;Float;False;InstancedProperty;_Tint;Tint;1;0;0,0,0,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;18;-652.9013,-467.8996;Float;True;Property;_TextureSample0;Texture Sample 0;4;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;281.5001,-240.0004;Float;False;5;5;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;3;FLOAT;0,0,0,0;False;4;FLOAT3;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;760,-320;Float;False;True;7;Float;ASEMaterialInspector;0;CustomLighting;Harbinger/Exhaust;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;True;True;Off;2;0;False;0;0;Custom;1;True;False;0;True;Transparent;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;False;4;One;One;0;Zero;Zero;OFF;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;Particles/Additive;0;-1;-1;-1;0;0;14;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;2;16;0
WireConnection;20;0;19;2
WireConnection;20;1;21;0
WireConnection;13;0;14;0
WireConnection;13;1;20;0
WireConnection;11;0;1;0
WireConnection;18;0;16;0
WireConnection;18;1;13;0
WireConnection;8;0;18;0
WireConnection;8;1;7;0
WireConnection;8;2;10;0
WireConnection;8;3;1;4
WireConnection;8;4;11;0
WireConnection;0;2;8;0
ASEEND*/
//CHKSM=B8239472510892E87217597C64A31E86357CCEE7