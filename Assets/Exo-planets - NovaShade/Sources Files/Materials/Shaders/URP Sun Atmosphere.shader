// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Exo-Planets/URP/SunAtmosphere"
{
	Properties
	{
		_ExteriorIntensity("Exterior Intensity", Float) = 0.7
		_AtmosphereSize("Atmosphere Size", Range( -1 , 5)) = 2
		_Color0("Color 0", Color) = (0.9755421,0.2198126,0,0)

	}

	SubShader
	{
		LOD 0

		
		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Transparent" "Queue"="Transparent" }
		
		Cull Front
		HLSLINCLUDE
		#pragma target 3.0
		ENDHLSL

		
		Pass
		{
			Name "Forward"
			Tags { "LightMode"="UniversalForward" }
			
			Blend One One , One OneMinusSrcAlpha
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

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				
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

			CBUFFER_START( UnityPerMaterial )
			float _AtmosphereSize;
			float4 _Color0;
			float _ExteriorIntensity;
			CBUFFER_END


			
			VertexOutput vert ( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				o.ase_texcoord1.xyz = ase_worldPos;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord2.xyz = ase_worldNormal;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.w = 0;
				o.ase_texcoord2.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = ( (0.0 + (_AtmosphereSize - 0.0) * (1.0 - 0.0) / (3.0 - 0.0)) * ( v.vertex.xyz * 1 ) );
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

				float3 ase_worldPos = IN.ase_texcoord1.xyz;
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - ase_worldPos );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 ase_worldNormal = IN.ase_texcoord2.xyz;
				float dotResult162 = dot( ase_worldViewDir , ase_worldNormal );
				float clampResult164 = clamp( -dotResult162 , 0.0 , 1.0 );
				float3 temp_cast_0 = (clampResult164).xxx;
				float3 temp_cast_1 = (clampResult164).xxx;
				float3 gammaToLinear165 = FastSRGBToLinear( temp_cast_1 );
				float3 temp_cast_2 = (5.0).xxx;
				float4 blendOpSrc170 = _Color0;
				float4 blendOpDest170 = float4( pow( gammaToLinear165 , temp_cast_2 ) , 0.0 );
				float4 clampResult172 = clamp( ( blendOpSrc170 * blendOpDest170 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
				
				float3 BakedAlbedo = 0;
				float3 BakedEmission = 0;
				float3 Color = ( clampResult172 * _ExteriorIntensity ).rgb;
				float Alpha = 1;
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
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START( UnityPerMaterial )
			float _AtmosphereSize;
			float4 _Color0;
			float _ExteriorIntensity;
			CBUFFER_END


			
			VertexOutput vert( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = ( (0.0 + (_AtmosphereSize - 0.0) * (1.0 - 0.0) / (3.0 - 0.0)) * ( v.vertex.xyz * 1 ) );
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

				
				float Alpha = 1;
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
-1680;203;1680;989;97.64007;568.31;1.620229;True;False
Node;AmplifyShaderEditor.CommentaryNode;154;2979.121,414.6427;Inherit;False;728.4116;455.2193;Comment;4;159;158;157;156;First shader pass Output;0,0.7511432,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;169;2272.313,458.5973;Float;False;Property;_AtmosphereSize;Atmosphere Size;1;0;Create;True;0;0;False;0;2;1;-1;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;157;2994.323,751.1057;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;155;2171.862,188.0016;Inherit;False;346;136;Material Property;1;171;;0,1,0.3411765,1;0;0
Node;AmplifyShaderEditor.TFHCRemapNode;156;3004.544,569.2853;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;3;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleNode;158;3185.954,747.9562;Inherit;False;1;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DotProductOpNode;162;803.6415,139.194;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;173;527.1054,249.5905;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PowerNode;167;1507.31,149.487;Inherit;True;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;3;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BlendOpsNode;170;1984.336,35.16469;Inherit;False;Multiply;False;3;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.GammaToLinearNode;165;1252.687,156.566;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;164;1072.107,161.1285;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;163;932.4305,164.0563;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;160;1446.969,-159.0345;Float;False;Property;_Color0;Color 0;2;0;Create;True;0;0;False;0;0.9755421,0.2198126,0,0;0.9755421,0.2198126,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;171;2227.362,238.4498;Float;False;Property;_ExteriorIntensity;Exterior Intensity;0;0;Create;True;0;0;False;0;0.7;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;174;2568.221,68.86781;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;159;3307.664,624.2326;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;172;2266.846,28.40004;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;161;518.1757,66.7643;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;166;1239.684,271.6344;Float;False;Constant;_Float8;Float 8;11;0;Create;True;0;0;False;0;5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;182;3504.362,136.0926;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ShadowCaster;0;1;ShadowCaster;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;False;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=ShadowCaster;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;183;3504.362,136.0926;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;DepthOnly;0;2;DepthOnly;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;False;False;False;False;True;False;False;False;False;0;False;-1;False;True;1;False;-1;False;False;True;1;LightMode=DepthOnly;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;184;3504.362,136.0926;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;Meta;0;3;Meta;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;False;False;False;True;2;False;-1;False;False;False;False;False;True;1;LightMode=Meta;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;181;3676.052,74.55698;Float;False;True;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;3;Exo-Planets/URP/SunAtmosphere;2992e84f91cbeb14eab234972e07ea9d;True;Forward;0;0;Forward;7;False;False;False;True;1;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;True;2;0;True;1;1;False;-1;1;False;-1;1;1;False;-1;10;False;-1;False;False;False;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;2;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=UniversalForward;False;0;Hidden/InternalErrorShader;0;0;Standard;10;Surface;1;  Blend;2;Two Sided;2;Cast Shadows;0;Receive Shadows;0;GPU Instancing;0;LOD CrossFade;0;Built-in Fog;0;Meta Pass;0;Vertex Position,InvertActionOnDeselection;1;0;4;True;False;True;False;False;;0
WireConnection;156;0;169;0
WireConnection;158;0;157;0
WireConnection;162;0;161;0
WireConnection;162;1;173;0
WireConnection;167;0;165;0
WireConnection;167;1;166;0
WireConnection;170;0;160;0
WireConnection;170;1;167;0
WireConnection;165;0;164;0
WireConnection;164;0;163;0
WireConnection;163;0;162;0
WireConnection;174;0;172;0
WireConnection;174;1;171;0
WireConnection;159;0;156;0
WireConnection;159;1;158;0
WireConnection;172;0;170;0
WireConnection;181;2;174;0
WireConnection;181;5;159;0
ASEEND*/
//CHKSM=9DDED03F835385560DA8F6439A20622215E9AF18