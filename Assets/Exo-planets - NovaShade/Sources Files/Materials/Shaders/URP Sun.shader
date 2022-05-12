// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Exo-Planets/URP/Star"
{
	Properties
	{
		_Emissive1("Emissive 1", 2D) = "white" {}
		_Flowmap("Flowmap", 2D) = "white" {}
		_Flowpower("Flow power", Range( 0 , 1)) = 0.5
		_Flowspeed("Flow speed", Range( 0 , 0.1)) = 1
		_SubAtmospherescale("Sub Atmosphere scale", Float) = 1
		_SubAtmosphereIntensity("Sub Atmosphere Intensity", Float) = 1
		_StarColor1("Star Color", Color) = (1,0.7961294,0.441,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}

	SubShader
	{
		LOD 0

		
		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
		
		Cull Back
		HLSLINCLUDE
		#pragma target 3.0
		ENDHLSL

		
		Pass
		{
			Name "Forward"
			Tags { "LightMode"="UniversalForward" }
			
			Blend One Zero , One Zero
			ZWrite On
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
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			sampler2D _Emissive1;
			sampler2D _Flowmap;
			CBUFFER_START( UnityPerMaterial )
			float _SubAtmosphereIntensity;
			float _SubAtmospherescale;
			float _Flowpower;
			float4 _Flowmap_ST;
			float _Flowspeed;
			float4 _StarColor1;
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
				
				o.ase_texcoord3.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.w = 0;
				o.ase_texcoord2.w = 0;
				o.ase_texcoord3.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
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
				float fresnelNdotV2470 = dot( ase_worldNormal, ase_worldViewDir );
				float fresnelNode2470 = ( 0.0 + _SubAtmosphereIntensity * pow( max( 1.0 - fresnelNdotV2470 , 0.0001 ), _SubAtmospherescale ) );
				float saferPower2524 = max( fresnelNode2470 , 0.0001 );
				float temp_output_2524_0 = pow( saferPower2524 , 0.3 );
				float2 uv02455 = IN.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_2460_0 = ( uv02455 * 1.0 );
				float2 uv_Flowmap = IN.ase_texcoord3.xy * _Flowmap_ST.xy + _Flowmap_ST.zw;
				float2 temp_cast_0 = (0.0).xx;
				float2 temp_cast_1 = (1.0).xx;
				float2 temp_cast_2 = (-0.5).xx;
				float2 temp_cast_3 = (0.5).xx;
				float2 temp_output_2457_0 = ( ( _Flowpower * -1.0 ) * (temp_cast_2 + ((tex2D( _Flowmap, uv_Flowmap )).rg - temp_cast_0) * (temp_cast_3 - temp_cast_2) / (temp_cast_1 - temp_cast_0)) );
				float temp_output_2446_0 = ( _Flowspeed * ( _TimeParameters.y ) );
				float temp_output_2464_0 = frac( temp_output_2446_0 );
				float2 temp_cast_4 = (0.0).xx;
				float2 temp_cast_5 = (1.0).xx;
				float2 temp_cast_6 = (-0.5).xx;
				float2 temp_cast_7 = (0.5).xx;
				float2 appendResult2468 = (float2(0.5 , 0.0));
				float4 lerpResult2482 = lerp( tex2D( _Emissive1, ( temp_output_2460_0 + ( temp_output_2457_0 * temp_output_2464_0 ) ) ) , tex2D( _Emissive1, ( ( temp_output_2460_0 + ( temp_output_2457_0 * frac( ( temp_output_2446_0 + 0.5 ) ) ) ) + appendResult2468 ) ) , abs( ( ( temp_output_2464_0 - 0.5 ) / 0.5 ) ));
				float4 blendOpSrc2514 = lerpResult2482;
				float4 blendOpDest2514 = _StarColor1;
				float4 temp_output_2514_0 = ( saturate( (( blendOpDest2514 > 0.5 ) ? ( 1.0 - 2.0 * ( 1.0 - blendOpDest2514 ) * ( 1.0 - blendOpSrc2514 ) ) : ( 2.0 * blendOpDest2514 * blendOpSrc2514 ) ) ));
				float3 desaturateInitialColor2486 = ( temp_output_2524_0 + temp_output_2514_0 ).rgb;
				float desaturateDot2486 = dot( desaturateInitialColor2486, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar2486 = lerp( desaturateInitialColor2486, desaturateDot2486.xxx, 0.0 );
				
				float3 BakedAlbedo = 0;
				float3 BakedEmission = 0;
				float3 Color = desaturateVar2486;
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
			float _SubAtmosphereIntensity;
			float _SubAtmospherescale;
			float _Flowpower;
			float4 _Flowmap_ST;
			float _Flowspeed;
			float4 _StarColor1;
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
				float3 vertexValue = defaultVertexValue;
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
-1680;203;1680;989;11488.45;10745.18;1.172773;True;False
Node;AmplifyShaderEditor.SimpleAddOpNode;2469;-11433.67,-9858.386;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2472;-11832.26,-9416.686;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2451;-12617.47,-10501.99;Float;False;Constant;_Float7;Float 7;2;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2581;-10672.19,-9546.684;Float;False;Property;_StarColor1;Star Color;6;0;Create;True;0;0;False;0;1,0.7961294,0.441,0;1,0.7961294,0.441,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2461;-11594.31,-9606.796;Float;False;Constant;_Float11;Float 11;7;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;2444;-12788.67,-10373.99;Inherit;True;True;True;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;2480;-11142.17,-9881.885;Inherit;True;Property;_Emissive2;Emissive 2;0;0;Create;True;0;0;False;0;-1;fd527f070ef46b843b28d178b92373b5;fd527f070ef46b843b28d178b92373b5;True;0;False;white;Auto;False;Instance;2481;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;2514;-10120.59,-10126.21;Inherit;False;Overlay;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2442;-13108.97,-10373.99;Inherit;True;Property;_Flowmap;Flowmap;1;0;Create;True;0;0;False;0;-1;None;f449be548af003742af084e870607237;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2465;-12094.26,-9172.285;Float;False;Constant;_Float1;Float 1;6;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DesaturateOpNode;2486;-9464.986,-10266.3;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2447;-12739.27,-10620.29;Float;False;Property;_Flowpower;Flow power;2;0;Create;True;0;0;False;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2449;-12679.87,-10186.79;Float;False;Constant;_Float2;Float 2;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2475;-11179.61,-9640.596;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;2463;-11116.26,-10384.3;Float;False;Property;_SubAtmosphereIntensity;Sub Atmosphere Intensity;5;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2466;-11109.82,-10281.35;Float;False;Property;_SubAtmospherescale;Sub Atmosphere scale;4;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2482;-10756.06,-9930.785;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2476;-11383.27,-10125.39;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;2445;-12682.27,-9926.386;Float;False;Constant;_Float5;Float 5;2;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;2470;-10733.52,-10389.99;Inherit;False;Standard;WorldNormal;ViewDir;False;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2441;-12779.07,-9716.186;Float;False;Property;_Flowspeed;Flow speed;3;0;Create;True;0;0;False;0;1;0.1;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2481;-11129.77,-10154.79;Inherit;True;Property;_Emissive1;Emissive 1;0;0;Create;True;0;0;False;0;-1;fd527f070ef46b843b28d178b92373b5;fd527f070ef46b843b28d178b92373b5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2459;-11642.37,-9877.285;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FractNode;2458;-11896.87,-9681.485;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2462;-11603.41,-9523.596;Float;False;Constant;_Float12;Float 12;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2446;-12404.57,-9652.486;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2460;-11608.96,-10520.18;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2471;-11682.07,-10075.99;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;2456;-11863.76,-10429.18;Float;False;Constant;_Float6;Float 6;6;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2450;-12686.27,-10012.39;Float;False;Constant;_Float4;Float 4;2;0;Create;True;0;0;False;0;-0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2448;-12679.87,-10092.39;Float;False;Constant;_Float3;Float 3;2;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;2474;-11629.66,-9414.985;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2443;-12410.07,-9391.686;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;2440;-12654.57,-9611.486;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;2454;-12183.97,-9499.985;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;2478;-11435.26,-9414.486;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2453;-12438.27,-10575.59;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;2519;-9708.825,-10152.74;Inherit;False;Overlay;True;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;2468;-11408.41,-9575.596;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;2452;-12492.37,-10348.19;Inherit;True;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,0;False;3;FLOAT2;0,0;False;4;FLOAT2;1,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2576;-9771.371,-10379.25;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2455;-11883.27,-10575.49;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FractNode;2464;-12160.07,-9682.186;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2457;-12154.17,-10416.59;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;2524;-10385.51,-10368.82;Inherit;True;True;2;0;FLOAT;0;False;1;FLOAT;0.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2584;-9136.984,-10263.42;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ShadowCaster;0;1;ShadowCaster;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;False;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=ShadowCaster;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2586;-9136.984,-10263.42;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;Meta;0;3;Meta;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;False;False;False;True;2;False;-1;False;False;False;False;False;True;1;LightMode=Meta;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2585;-9136.984,-10263.42;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;DepthOnly;0;2;DepthOnly;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;False;False;False;False;True;False;False;False;False;0;False;-1;False;True;1;False;-1;False;False;True;1;LightMode=DepthOnly;False;0;Hidden/InternalErrorShader;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2583;-9131.094,-10266.37;Float;False;True;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;3;Exo-Planets/URP/Star;2992e84f91cbeb14eab234972e07ea9d;True;Forward;0;0;Forward;7;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;True;1;1;False;-1;0;False;-1;1;1;False;-1;0;False;-1;False;False;False;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=UniversalForward;False;0;Hidden/InternalErrorShader;0;0;Standard;10;Surface;0;  Blend;2;Two Sided;1;Cast Shadows;0;Receive Shadows;0;GPU Instancing;0;LOD CrossFade;0;Built-in Fog;0;Meta Pass;0;Vertex Position,InvertActionOnDeselection;1;0;4;True;False;True;False;False;;0
WireConnection;2469;0;2460;0
WireConnection;2469;1;2459;0
WireConnection;2472;0;2464;0
WireConnection;2472;1;2465;0
WireConnection;2444;0;2442;0
WireConnection;2480;1;2475;0
WireConnection;2514;0;2482;0
WireConnection;2514;1;2581;0
WireConnection;2486;0;2576;0
WireConnection;2475;0;2469;0
WireConnection;2475;1;2468;0
WireConnection;2482;0;2481;0
WireConnection;2482;1;2480;0
WireConnection;2482;2;2478;0
WireConnection;2476;0;2460;0
WireConnection;2476;1;2471;0
WireConnection;2470;2;2463;0
WireConnection;2470;3;2466;0
WireConnection;2481;1;2476;0
WireConnection;2459;0;2457;0
WireConnection;2459;1;2458;0
WireConnection;2458;0;2454;0
WireConnection;2446;0;2441;0
WireConnection;2446;1;2440;2
WireConnection;2460;0;2455;0
WireConnection;2460;1;2456;0
WireConnection;2471;0;2457;0
WireConnection;2471;1;2464;0
WireConnection;2474;0;2472;0
WireConnection;2474;1;2465;0
WireConnection;2454;0;2446;0
WireConnection;2454;1;2443;0
WireConnection;2478;0;2474;0
WireConnection;2453;0;2447;0
WireConnection;2453;1;2451;0
WireConnection;2519;0;2524;0
WireConnection;2519;1;2514;0
WireConnection;2468;0;2461;0
WireConnection;2468;1;2462;0
WireConnection;2452;0;2444;0
WireConnection;2452;1;2449;0
WireConnection;2452;2;2448;0
WireConnection;2452;3;2450;0
WireConnection;2452;4;2445;0
WireConnection;2576;0;2524;0
WireConnection;2576;1;2514;0
WireConnection;2464;0;2446;0
WireConnection;2457;0;2453;0
WireConnection;2457;1;2452;0
WireConnection;2524;0;2470;0
WireConnection;2583;2;2486;0
ASEEND*/
//CHKSM=E0C186BEA2B2587D0876C2312363CA8928F579B4