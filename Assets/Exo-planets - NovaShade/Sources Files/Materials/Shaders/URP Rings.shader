// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Exo-Planets/URP/Rings"
{
	Properties
	{
		[NoScaleOffset]_RingsTexture("Rings Texture", 2D) = "white" {}
		_Opacity("Opacity", Range( 0 , 1)) = 1
		_BaseColoRing("Base Color", Color) = (0,0,0,0)
		_Color1("ColorMore", Color) = (1,1,1,1)
		_Coloroffset("Color offset", Range( 0 , 1)) = 0
		[HideInInspector]_LightSourceRings("_LightSourceRings", Vector) = (1,0,0,0)
		_Size("Size", Range( 0 , 5)) = 0.6
		_ShadowIntensity("Shadow Intensity", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}

	SubShader
	{
		LOD 0

		
		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Transparent" "Queue"="Transparent" }
		
		Cull Off
		HLSLINCLUDE
		#pragma target 3.0
		ENDHLSL

		
		Pass
		{
			Name "Forward"
			Tags { "LightMode"="UniversalForward" }
			
			Blend SrcAlpha OneMinusSrcAlpha , One OneMinusSrcAlpha
			ZWrite Off
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA
			

			HLSLPROGRAM
			#define _RECEIVE_SHADOWS_OFF 1
			#define ASE_SRP_VERSION 70101

			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma vertex vert
			#pragma fragment frag


			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#pragma multi_compile_instancing


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#ifdef ASE_FOG
				float fogFactor : TEXCOORD0;
				#endif
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			sampler2D _RingsTexture;
			UNITY_INSTANCING_BUFFER_START(ExoPlanetsURPRings)
				UNITY_DEFINE_INSTANCED_PROP(float3, _LightSourceRings)
			UNITY_INSTANCING_BUFFER_END(ExoPlanetsURPRings)
			CBUFFER_START( UnityPerMaterial )
			float _Size;
			float4 _BaseColoRing;
			float4 _Color1;
			float _Coloroffset;
			float _ShadowIntensity;
			float _Opacity;
			CBUFFER_END


			
			VertexOutput vert ( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				o.ase_texcoord2 = v.vertex;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = ( v.vertex.xyz * _Size );
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.ase_normal = v.ase_normal;

				o.clipPos = TransformObjectToHClip( v.vertex.xyz );
				#ifdef ASE_FOG
				o.fogFactor = ComputeFogFactor( o.clipPos.z );
				#endif
				return o;
			}

			half4 frag ( VertexOutput IN  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				float2 uv_RingsTexture1 = IN.ase_texcoord1.xy;
				float4 tex2DNode1 = tex2D( _RingsTexture, uv_RingsTexture1 );
				float4 temp_output_49_0 = ( tex2DNode1 * _BaseColoRing );
				float4 blendOpSrc6 = temp_output_49_0;
				float4 blendOpDest6 = _Color1;
				float2 temp_cast_0 = (_Coloroffset).xx;
				float2 uv011 = IN.ase_texcoord1.xy * float2( 1,1 ) + temp_cast_0;
				float4 lerpResult9 = lerp( ( saturate( (( blendOpDest6 > 0.5 ) ? ( 1.0 - 2.0 * ( 1.0 - blendOpDest6 ) * ( 1.0 - blendOpSrc6 ) ) : ( 2.0 * blendOpDest6 * blendOpSrc6 ) ) )) , temp_output_49_0 , tex2D( _RingsTexture, uv011 ).a);
				float3 _LightSourceRings_Instance = UNITY_ACCESS_INSTANCED_PROP(ExoPlanetsURPRings,_LightSourceRings);
				float3 normalizeResult19 = normalize( _LightSourceRings_Instance );
				float3 LightSourceVector21 = ( normalizeResult19 / 1.0 );
				float3 objToWorldDir61 = mul( GetObjectToWorldMatrix(), float4( IN.ase_texcoord2.xyz, 0 ) ).xyz;
				float3 normalizeResult31 = normalize( objToWorldDir61 );
				float dotResult22 = dot( LightSourceVector21 , normalizeResult31 );
				float clampResult44 = clamp( ( dotResult22 + 0.45 ) , 0.0 , 1.0 );
				float clampResult77 = clamp( ( _ShadowIntensity + clampResult44 ) , 0.0 , 1.0 );
				float4 lerpResult28 = lerp( float4( 0,0,0,0 ) , lerpResult9 , clampResult77);
				float4 clampResult41 = clamp( ( lerpResult28 * _Color1.a ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
				
				float3 BakedAlbedo = 0;
				float3 BakedEmission = 0;
				float3 Color = clampResult41.rgb;
				float Alpha = ( tex2DNode1.a * _Opacity );
				float AlphaClipThreshold = 0.5;

				#ifdef _ALPHATEST_ON
					clip( Alpha - AlphaClipThreshold );
				#endif

				#ifdef ASE_FOG
					Color = MixFog( Color, IN.fogFactor );
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif

				return half4( Color, Alpha );
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			ZWrite On
			ColorMask 0

			HLSLPROGRAM
			#define _RECEIVE_SHADOWS_OFF 1
			#define ASE_SRP_VERSION 70101

			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma vertex vert
			#pragma fragment frag


			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			

			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			sampler2D _RingsTexture;
			UNITY_INSTANCING_BUFFER_START(ExoPlanetsURPRings)
			UNITY_INSTANCING_BUFFER_END(ExoPlanetsURPRings)
			CBUFFER_START( UnityPerMaterial )
			float _Size;
			float4 _BaseColoRing;
			float4 _Color1;
			float _Coloroffset;
			float _ShadowIntensity;
			float _Opacity;
			CBUFFER_END


			
			VertexOutput vert( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				o.ase_texcoord.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = ( v.vertex.xyz * _Size );
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				o.clipPos = TransformObjectToHClip(v.vertex.xyz);
				return o;
			}

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				float2 uv_RingsTexture1 = IN.ase_texcoord.xy;
				float4 tex2DNode1 = tex2D( _RingsTexture, uv_RingsTexture1 );
				
				float Alpha = ( tex2DNode1.a * _Opacity );
				float AlphaClipThreshold = 0.5;

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif
				return 0;
			}
			ENDHLSL
		}

	
	}
	CustomEditor "UnityEditor.ShaderGraph.PBRMasterGUI"
	Fallback "Hidden/InternalErrorShader"
	
}
/*ASEBEGIN
Version=17700
-1680;203;1680;989;-242.417;915.3004;1.038888;True;False
Node;AmplifyShaderEditor.CommentaryNode;15;-515.9631,-907.8758;Inherit;False;1011.591;371.1455;Light Source Vector from script;5;21;20;19;18;16;Light Source Vector;1,0.6068678,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;16;-482.8538,-842.2879;Inherit;False;304;234;Input is set via LightSource.cs;1;17;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;64;1505.919,720.8987;Inherit;False;Property;_Size;Size;6;0;Create;True;0;0;False;0;0.6;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;62;1491.919,503.8987;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;1215.683,368.9434;Float;False;Property;_Opacity;Opacity;1;0;Create;True;0;0;False;0;1;0.317;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-597.3553,-249.5238;Inherit;True;Property;_RingsTexture;Rings Texture;0;1;[NoScaleOffset];Create;True;0;0;False;0;-1;None;966045dcd1b1e5c448b8cbbed429f164;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;21;255.9721,-726.0272;Float;False;LightSourceVector;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;1638.458,274.4492;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;44;987.5806,-415.8224;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;12;108.3539,278.826;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;-1;None;966045dcd1b1e5c448b8cbbed429f164;True;0;False;white;Auto;False;Instance;1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TransformDirectionNode;61;-806.4595,-589.6123;Inherit;False;Object;World;False;Fast;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ClampOpNode;41;1611.875,-143.8365;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;29;-828.2434,-150.4851;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;22;565.5526,-620.2398;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;40;549.1597,-382.3046;Float;False;Constant;_Float1;Float 1;6;0;Create;True;0;0;False;0;0.45;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;31;-199.9165,-485.9353;Inherit;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BlendOpsNode;6;263.9862,-98.33589;Inherit;False;Overlay;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalizeNode;19;-110.3539,-844.7977;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;77;1234.555,-502.862;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;20;80.74569,-727.4617;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PosVertexDataNode;25;-1076.96,-475.5446;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;1455.529,-170.8495;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;9;772.5723,-222.2541;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-782.7291,330.1622;Float;False;Property;_Coloroffset;Color offset;4;0;Create;True;0;0;False;0;0;0.094;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;76;1118.199,-667.0061;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;75;807.1238,-758.15;Inherit;False;Property;_ShadowIntensity;Shadow Intensity;7;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;3;-216.4991,73.9577;Float;False;Property;_Color1;ColorMore;3;0;Create;False;0;0;False;0;1,1,1,1;0,0.9534544,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-409.3893,301.3984;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0.6,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;-61.4402,-219.21;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;39;845.9198,-462.371;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;17;-464.8538,-783.2879;Float;False;InstancedProperty;_LightSourceRings;_LightSourceRings;5;1;[HideInInspector];Create;True;0;0;False;0;1,0,0;7004.913,7098.083,0.02914729;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;18;-135.1235,-704.1375;Float;False;Constant;_Float2;Float 2;36;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;28;1152.514,-216.3713;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;1879.919,553.8987;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;58;-1096.459,-180.6123;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;50;-514.7902,84.12048;Inherit;False;Property;_BaseColoRing;Base Color;2;0;Create;False;0;0;False;0;0,0,0,0;0.5309999,0.5309999,0.5309999,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;72;2056.794,391.1125;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;3;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ShadowCaster;0;1;ShadowCaster;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;False;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=ShadowCaster;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;73;2056.794,391.1125;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;3;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;DepthOnly;0;2;DepthOnly;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;False;False;False;False;True;False;False;False;False;0;False;-1;False;True;1;False;-1;False;False;True;1;LightMode=DepthOnly;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;74;2056.794,391.1125;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;3;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;Meta;0;3;Meta;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;False;False;False;True;2;False;-1;False;False;False;False;False;True;1;LightMode=Meta;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;71;2102.633,63.22169;Float;False;True;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;3;Exo-Planets/URP/Rings;2992e84f91cbeb14eab234972e07ea9d;True;Forward;0;0;Forward;7;False;False;False;True;2;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;True;2;0;True;1;5;False;-1;10;False;-1;1;1;False;-1;10;False;-1;False;False;False;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;2;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=UniversalForward;False;0;Hidden/InternalErrorShader;0;0;Standard;10;Surface;1;  Blend;0;Two Sided;0;Cast Shadows;0;Receive Shadows;0;GPU Instancing;0;LOD CrossFade;0;Built-in Fog;0;Meta Pass;0;Vertex Position,InvertActionOnDeselection;1;0;4;True;False;True;False;False;;0
WireConnection;21;0;20;0
WireConnection;4;0;1;4
WireConnection;4;1;5;0
WireConnection;44;0;39;0
WireConnection;12;1;11;0
WireConnection;61;0;25;0
WireConnection;41;0;45;0
WireConnection;29;0;25;0
WireConnection;22;0;21;0
WireConnection;22;1;31;0
WireConnection;31;0;61;0
WireConnection;6;0;49;0
WireConnection;6;1;3;0
WireConnection;19;0;17;0
WireConnection;77;0;76;0
WireConnection;20;0;19;0
WireConnection;20;1;18;0
WireConnection;45;0;28;0
WireConnection;45;1;3;4
WireConnection;9;0;6;0
WireConnection;9;1;49;0
WireConnection;9;2;12;4
WireConnection;76;0;75;0
WireConnection;76;1;44;0
WireConnection;11;1;13;0
WireConnection;49;0;1;0
WireConnection;49;1;50;0
WireConnection;39;0;22;0
WireConnection;39;1;40;0
WireConnection;28;1;9;0
WireConnection;28;2;77;0
WireConnection;65;0;62;0
WireConnection;65;1;64;0
WireConnection;58;0;25;0
WireConnection;71;2;41;0
WireConnection;71;3;4;0
WireConnection;71;5;65;0
ASEEND*/
//CHKSM=978B9D1634B2B3F4ABDB1498693E88E0D5A3DEA0