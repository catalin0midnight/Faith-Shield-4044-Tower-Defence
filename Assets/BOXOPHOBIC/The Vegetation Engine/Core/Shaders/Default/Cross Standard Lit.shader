// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Vegetation Engine/Default/Cross Standard Lit"
{
	Properties
	{
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[StyledCategory(Render Settings, 5, 10)]_RenderingCat("[ Rendering Cat ]", Float) = 0
		[Enum(Opaque,0,Transparent,1)]_RenderMode("Render Mode", Float) = 0
		[Enum(Off,0,On,1)]_RenderZWrite("Render ZWrite", Float) = 1
		[Enum(Both,0,Back,1,Front,2)]_RenderCull("Render Faces", Float) = 0
		[Enum(Flip,0,Mirror,1,Same,2)]_RenderNormals("Render Normals", Float) = 0
		[HideInInspector]_RenderQueue("Render Queue", Float) = 0
		[HideInInspector]_RenderPriority("Render Priority", Float) = 0
		[StyledSpace(10)]_SpaceRenderReceive("# Space Render Receive", Float) = 0
		[Enum(Off,0,On,1)]_RenderSpecular("Receive Specular", Float) = 1
		[Enum(Off,0,On,1)]_RenderDecals("Receive Decals", Float) = 0
		[Enum(Off,0,On,1)]_RenderSSR("Receive SSR/SSGI", Float) = 0
		[Enum(Off,0,On,1)][Space(10)]_RenderClip("Alpha Clipping", Float) = 1
		_Cutoff("Alpha Treshold", Range( 0 , 1)) = 0.5
		[StyledSpace(10)]_SpaceRenderFade("# Space Render Fade", Float) = 0
		_FadeVerticalValue("Fade by Vertical Angle", Range( 0 , 1)) = 0
		_FadeHorizontalValue("Fade by Horizontal Angle", Range( 0 , 1)) = 0
		[StyledCategory(Global Settings)]_GlobalCat("[ Global Cat ]", Float) = 0
		[StyledEnum(TVELayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_LayerColorsValue("Layer Colors", Float) = 0
		[StyledEnum(TVELayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_LayerExtrasValue("Layer Extras", Float) = 0
		[StyledEnum(TVELayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_LayerMotionValue("Layer Motion", Float) = 0
		[StyledEnum(TVELayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_LayerVertexValue("Layer Vertex", Float) = 0
		[StyledSpace(10)]_SpaceGlobalLayers("# Space Global Layers", Float) = 0
		[StyledMessage(Info, Procedural Variation in use. The Variation might not work as expected when switching from one LOD to another., _VertexVariationMode, 1 , 0, 10)]_MessageGlobalsVariation("# Message Globals Variation", Float) = 0
		_GlobalColors("Global Color", Range( 0 , 1)) = 1
		_GlobalOverlay("Global Overlay", Range( 0 , 1)) = 1
		_GlobalWetness("Global Wetness", Range( 0 , 1)) = 1
		_GlobalEmissive("Global Emissive", Range( 0 , 1)) = 1
		_GlobalSize("Global Size Fade", Range( 0 , 1)) = 1
		[StyledRemapSlider(_ColorsMaskMinValue, _ColorsMaskMaxValue, 0, 1, 10, 0)]_ColorsMaskRemap("Color Mask", Vector) = (0,0,0,0)
		[HideInInspector]_ColorsMaskMinValue("Color Mask Min Value", Range( 0 , 1)) = 0
		[HideInInspector]_ColorsMaskMaxValue("Color Mask Max Value", Range( 0 , 1)) = 0
		[StyledRemapSlider(_OverlayMaskMinValue, _OverlayMaskMaxValue, 0, 1, 10, 0)]_OverlayMaskRemap("Overlay Mask", Vector) = (0,0,0,0)
		[HideInInspector]_OverlayMaskMinValue("Overlay Mask Min Value", Range( 0 , 1)) = 0.45
		[HideInInspector]_OverlayMaskMaxValue("Overlay Mask Max Value", Range( 0 , 1)) = 0.55
		[StyledRemapSlider(_AlphaMaskMinValue, _AlphaMaskMaxValue, 0, 1, 10, 0)]_AlphaMaskRemap("Alpha Mask", Vector) = (0,0,0,0)
		[StyledSpace(10)]_SpaceGlobalPosition("# Space Global Position", Float) = 0
		[StyledToggle]_ColorsPositionMode("Use Pivot Position for Colors", Float) = 0
		[StyledToggle]_ExtrasPositionMode("Use Pivot Position for Extras", Float) = 0
		[StyledCategory(Main Settings)]_MainCat("[ Main Cat ]", Float) = 0
		[NoScaleOffset][StyledTextureSingleLine]_MainAlbedoTex("Main Albedo", 2D) = "white" {}
		[NoScaleOffset][StyledTextureSingleLine]_MainNormalTex("Main Normal", 2D) = "bump" {}
		[NoScaleOffset][StyledTextureSingleLine]_MainMaskTex("Main Mask", 2D) = "white" {}
		[Space(10)][StyledVector(9)]_MainUVs("Main UVs", Vector) = (1,1,0,0)
		[HDR]_MainColor("Main Color", Color) = (1,1,1,1)
		_MainNormalValue("Main Normal", Range( -8 , 8)) = 1
		_MainOcclusionValue("Main Occlusion", Range( 0 , 1)) = 1
		_MainSmoothnessValue("Main Smoothness", Range( 0 , 1)) = 1
		[StyledRemapSlider(_LeavesMaskMinValue, _LeavesMaskMaxValue, 0, 1)]_LeavesMaskRemap("Main Leaves Mask", Vector) = (0,0,0,2)
		[StyledCategory(Detail Settings)]_DetailCat("[ Detail Cat ]", Float) = 0
		[Enum(Off,0,On,1)]_DetailMode("Detail Mode", Float) = 0
		[Enum(Overlay,0,Replace,1)]_DetailBlendMode("Detail Blend", Float) = 1
		[Enum(Vertex Blue,0,Projection,1)]_DetailTypeMode("Detail Type", Float) = 0
		[StyledRemapSlider(_DetailBlendMinValue, _DetailBlendMaxValue,0,1)]_DetailBlendRemap("Detail Blending", Vector) = (0,0,0,0)
		[StyledCategory(Occlusion Settings)]_OcclusionCat("[ Occlusion Cat ]", Float) = 0
		[StyledRemapSlider(_VertexOcclusionMinValue, _VertexOcclusionMaxValue, 0, 1)]_VertexOcclusionRemap("Vertex Occlusion Mask", Vector) = (0,0,0,0)
		[StyledCategory(Subsurface Settings)]_SubsurfaceCat("[ Subsurface Cat ]", Float) = 0
		_SubsurfaceValue("Subsurface Intensity", Range( 0 , 1)) = 1
		[HDR]_SubsurfaceColor("Subsurface Color", Color) = (0.4,0.4,0.1,1)
		[StyledRemapSlider(_SubsurfaceMaskMinValue, _SubsurfaceMaskMaxValue,0,1)]_SubsurfaceMaskRemap("Subsurface Mask", Vector) = (0,0,0,0)
		[HideInInspector]_SubsurfaceMaskMinValue("Subsurface Mask Min Value", Range( 0 , 1)) = 0
		[HideInInspector]_SubsurfaceMaskMaxValue("Subsurface Mask Max Value", Range( 0 , 1)) = 1
		[Space(10)][DiffusionProfile]_SubsurfaceDiffusion("Subsurface Diffusion", Float) = 0
		[HideInInspector]_SubsurfaceDiffusion_Asset("Subsurface Diffusion", Vector) = (0,0,0,0)
		[HideInInspector][Space(10)][ASEDiffusionProfile(_SubsurfaceDiffusion)]_SubsurfaceDiffusion_asset("Subsurface Diffusion", Vector) = (0,0,0,0)
		[Space(10)]_MainLightScatteringValue("Subsurface Scattering Intensity", Range( 0 , 16)) = 8
		_MainLightAngleValue("Subsurface Scattering Angle", Range( 0 , 16)) = 8
		[Space(10)]_TranslucencyIntensityValue("Translucency Intensity", Range( 0 , 50)) = 1
		_TranslucencyNormalValue("Translucency Normal", Range( 0 , 1)) = 0.1
		_TranslucencyScatteringValue("Translucency Scattering", Range( 1 , 50)) = 2
		_TranslucencyDirectValue("Translucency Direct", Range( 0 , 1)) = 1
		_TranslucencyAmbientValue("Translucency Ambient", Range( 0 , 1)) = 0.2
		_TranslucencyShadowValue("Translucency Shadow", Range( 0 , 1)) = 1
		[StyledMessage(Warning,  Translucency is not supported in HDRP. Diffusion Profiles will be used instead., 10, 5)]_MessageTranslucencyHD("# Translucency HD Message", Float) = 0
		[StyledCategory(Gradient Settings)]_GradientCat("[ Gradient Cat ]", Float) = 0
		[HDR]_GradientColorOne("Gradient Color One", Color) = (1,1,1,1)
		[HDR]_GradientColorTwo("Gradient Color Two", Color) = (1,1,1,1)
		[StyledRemapSlider(_GradientMinValue, _GradientMaxValue, 0, 1)]_GradientMaskRemap("Gradient Mask", Vector) = (0,0,0,0)
		[HideInInspector]_GradientMinValue("Gradient Mask Min", Range( 0 , 1)) = 0
		[HideInInspector]_GradientMaxValue("Gradient Mask Max ", Range( 0 , 1)) = 1
		[StyledCategory(Noise Settings)]_NoiseCat("[ Noise Cat ]", Float) = 0
		[HDR]_NoiseColorOne("Noise Color One", Color) = (1,1,1,1)
		[HDR]_NoiseColorTwo("Noise Color Two", Color) = (1,1,1,1)
		[StyledRemapSlider(_NoiseMinValue, _NoiseMaxValue, 0, 1)]_NoiseMaskRemap("Noise Mask", Vector) = (0,0,0,0)
		[HideInInspector]_NoiseMinValue("Noise Mask Min", Range( 0 , 1)) = 0
		[HideInInspector]_NoiseMaxValue("Noise Mask Max ", Range( 0 , 1)) = 1
		_NoiseScaleValue("Noise Scale", Range( 0 , 1)) = 0.01
		[StyledCategory(Emissive Settings)]_EmissiveCat("[ Emissive Cat]", Float) = 0
		[NoScaleOffset][StyledTextureSingleLine]_EmissiveTex("Emissive Texture", 2D) = "white" {}
		[Space(10)][StyledVector(9)]_EmissiveUVs("Emissive UVs", Vector) = (1,1,0,0)
		[Enum(None,0,Any,10,Baked,20,Realtime,30)]_EmissiveFlagMode("Emissive Baking", Float) = 0
		[HDR]_EmissiveColor("Emissive Color", Color) = (0,0,0,0)
		[StyledEmissiveIntensity]_EmissiveIntensityParams("Emissive Intensity", Vector) = (1,1,1,0)
		[StyledCategory(Perspective Settings)]_PerspectiveCat("[ Perspective Cat ]", Float) = 0
		[StyledCategory(Size Fade Settings)]_SizeFadeCat("[ Size Fade Cat ]", Float) = 0
		[StyledMessage(Info, The Size Fade feature is recommended to be used to fade out vegetation at a distance in combination with the LOD Groups or with a 3rd party culling system., _SizeFadeMode, 1, 0, 10)]_MessageSizeFade("# Message Size Fade", Float) = 0
		[StyledCategory(Motion Settings)]_MotionCat("[ Motion Cat ]", Float) = 0
		[StyledMessage(Info, Procedural variation in use. Use the Scale settings if the Variation is breaking the bending and rolling animation., _VertexVariationMode, 1 , 0, 10)]_MessageMotionVariation("# Message Motion Variation", Float) = 0
		[StyledSpace(10)]_SpaceMotionHighlight("# SpaceMotionHighlight", Float) = 0
		_MotionAmplitude_10("Primary Bending", Range( 0 , 1)) = 0.05
		[IntRange]_MotionSpeed_10("Primary Speed", Range( 0 , 40)) = 2
		_MotionScale_10("Primary Scale", Range( 0 , 20)) = 0
		_MotionVariation_10("Primary Variation", Range( 0 , 20)) = 0
		[Space(10)]_InteractionAmplitude("Interaction Amplitude", Range( 0 , 10)) = 1
		_InteractionMaskValue("Interaction Use Mask", Range( 0 , 1)) = 0
		[ASEEnd][StyledSpace(10)]_SpaceMotionLocals("# SpaceMotionLocals", Float) = 0
		[HideInInspector]_MaxBoundsInfo("_MaxBoundsInfo", Vector) = (1,1,1,1)
		[HideInInspector]_render_normals_options("_render_normals_options", Vector) = (1,1,1,0)
		[HideInInspector]_Color("Legacy Color", Color) = (0,0,0,0)
		[HideInInspector]_MainTex("Legacy MainTex", 2D) = "white" {}
		[HideInInspector]_BumpMap("Legacy BumpMap", 2D) = "white" {}
		[HideInInspector]_LayerReactValue("Legacy Layer React", Float) = 0
		[HideInInspector]_VertexRollingMode("Legacy Vertex Rolling", Float) = 1
		[HideInInspector][StyledToggle]_VertexDataMode("_VertexDataMode", Float) = 0
		[HideInInspector][StyledToggle]_VertexDynamicMode("_VertexDynamicMode", Float) = 0
		[HideInInspector]_VertexVariationMode("_VertexVariationMode", Float) = 0
		[HideInInspector]_VertexMasksMode("_VertexMasksMode", Float) = 0
		[HideInInspector]_IsTVEShader("_IsTVEShader", Float) = 1
		[HideInInspector]_IsVersion("_IsVersion", Float) = 630
		[HideInInspector]_HasEmissive("_HasEmissive", Float) = 0
		[HideInInspector]_HasGradient("_HasGradient", Float) = 0
		[HideInInspector]_HasOcclusion("_HasOcclusion", Float) = 0
		[HideInInspector]_IsStandardShader("_IsStandardShader", Float) = 1
		[HideInInspector]_IsCrossShader("_IsCrossShader", Float) = 1
		[HideInInspector]_render_cull("_render_cull", Float) = 0
		[HideInInspector]_render_src("_render_src", Float) = 1
		[HideInInspector]_render_dst("_render_dst", Float) = 0
		[HideInInspector]_render_zw("_render_zw", Float) = 1

		[HideInInspector]_QueueOffset("_QueueOffset", Float) = 0
        [HideInInspector]_QueueControl("_QueueControl", Float) = -1
        [HideInInspector][NoScaleOffset]unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}
		//_TransmissionShadow( "Transmission Shadow", Range( 0, 1 ) ) = 0.5
		//_TransStrength( "Trans Strength", Range( 0, 50 ) ) = 1
		//_TransNormal( "Trans Normal Distortion", Range( 0, 1 ) ) = 0.5
		//_TransScattering( "Trans Scattering", Range( 1, 50 ) ) = 2
		//_TransDirect( "Trans Direct", Range( 0, 1 ) ) = 0.9
		//_TransAmbient( "Trans Ambient", Range( 0, 1 ) ) = 0.1
		//_TransShadow( "Trans Shadow", Range( 0, 1 ) ) = 0.5
		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25
	}

	SubShader
	{
		LOD 0

		
		
		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
		Cull [_render_cull]
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		AlphaToMask Off
		
		HLSLINCLUDE
		#pragma target 4.0

		#pragma prefer_hlslcc gles
		#pragma exclude_renderers d3d11_9x 

		#ifndef ASE_TESS_FUNCS
		#define ASE_TESS_FUNCS
		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}
		
		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlane (float3 pos, float4 plane)
		{
			float d = dot (float4(pos,1.0f), plane);
			return d;
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlane(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlane(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlane(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlane(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		#endif //ASE_TESS_FUNCS

		ENDHLSL

		
		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="UniversalForward" }
			
			Blend [_render_src] [_render_dst], One Zero
			ColorMask RGBA
			

			HLSLPROGRAM

			#define _SPECULAR_SETUP 1
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#pragma multi_compile _ DOTS_INSTANCING_ON
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 120100


			// -------------------------------------
			// Universal Pipeline keywords
			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
			#pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
			#pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
			#pragma multi_compile_fragment _ _SHADOWS_SOFT
			#pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
			#pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
			#pragma multi_compile_fragment _ _LIGHT_LAYERS
			#pragma multi_compile_fragment _ _LIGHT_COOKIES
			#pragma multi_compile _ _CLUSTERED_RENDERING

			// -------------------------------------
			// Unity defined keywords
			#pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
			#pragma multi_compile _ SHADOWS_SHADOWMASK
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ LIGHTMAP_ON
			#pragma multi_compile _ DYNAMICLIGHTMAP_ON
			#pragma multi_compile_fragment _ DEBUG_DISPLAY

			//--------------------------------------
			#pragma instancing_options renderinglayer

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_FORWARD

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(UNITY_INSTANCING_ENABLED) && defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL)
			    #define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#pragma shader_feature_local TVE_ALPHA_CLIP
			#pragma shader_feature_local TVE_VERTEX_DATA_BATCHED
			//TVE Shader Type Defines
			#define TVE_IS_VEGETATION_SHADER
			//TVE Pipeline Defines
			#define THE_VEGETATION_ENGINE
			#define TVE_IS_UNIVERSAL_PIPELINE
			//TVE Injection Defines
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				float4 lightmapUVOrVertexSH : TEXCOORD0;
				half4 fogFactorAndVertexLight : TEXCOORD1;
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
				float4 shadowCoord : TEXCOORD2;
				#endif
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				float4 screenPos : TEXCOORD6;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON)
				float2 dynamicLightmapUV : TEXCOORD7;
				#endif
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_texcoord9 : TEXCOORD9;
				float4 ase_texcoord10 : TEXCOORD10;
				float4 ase_texcoord11 : TEXCOORD11;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _GradientMaskRemap;
			half4 _SubsurfaceColor;
			half4 _ColorsMaskRemap;
			half4 _VertexOcclusionRemap;
			float4 _NoiseMaskRemap;
			half4 _OverlayMaskRemap;
			half4 _SubsurfaceMaskRemap;
			float4 _Color;
			half4 _AlphaMaskRemap;
			half4 _NoiseColorTwo;
			half4 _GradientColorTwo;
			half4 _GradientColorOne;
			float4 _SubsurfaceDiffusion_asset;
			float4 _EmissiveIntensityParams;
			half4 _EmissiveUVs;
			half4 _DetailBlendRemap;
			float4 _MaxBoundsInfo;
			half4 _MainUVs;
			half4 _LeavesMaskRemap;
			half4 _MainColor;
			float4 _SubsurfaceDiffusion_Asset;
			half4 _NoiseColorOne;
			half4 _EmissiveColor;
			half3 _render_normals_options;
			half _GradientMaxValue;
			half _InteractionMaskValue;
			half _GlobalSize;
			half _LayerVertexValue;
			half _VertexDataMode;
			half _InteractionAmplitude;
			float _MotionScale_10;
			half _VertexDynamicMode;
			half _MotionVariation_10;
			float _MotionSpeed_10;
			half _MotionAmplitude_10;
			half _LayerMotionValue;
			half _render_zw;
			half _IsStandardShader;
			half _GradientMinValue;
			half _render_src;
			half _ColorsPositionMode;
			half _NoiseMinValue;
			half _MainOcclusionValue;
			half _GlobalWetness;
			half _MainSmoothnessValue;
			half _RenderSpecular;
			half _GlobalEmissive;
			half _MainNormalValue;
			half _OverlayMaskMaxValue;
			half _OverlayMaskMinValue;
			half _LayerExtrasValue;
			half _ExtrasPositionMode;
			half _NoiseScaleValue;
			half _GlobalOverlay;
			half _MainLightAngleValue;
			half _SubsurfaceMaskMaxValue;
			half _SubsurfaceMaskMinValue;
			half _SubsurfaceValue;
			half _ColorsMaskMaxValue;
			half _ColorsMaskMinValue;
			half _GlobalColors;
			half _LayerColorsValue;
			half _IsCrossShader;
			half _NoiseMaxValue;
			half _MainLightScatteringValue;
			half _SpaceMotionHighlight;
			half _SpaceGlobalPosition;
			half _DetailTypeMode;
			half _RenderPriority;
			half _RenderZWrite;
			half _HasGradient;
			float _SubsurfaceDiffusion;
			half _IsVersion;
			half _MotionCat;
			half _DetailBlendMode;
			half _SpaceRenderReceive;
			half _RenderCull;
			half _HasEmissive;
			half _VertexMasksMode;
			half _SizeFadeCat;
			half _SubsurfaceCat;
			half _PerspectiveCat;
			half _DetailCat;
			half _RenderingCat;
			half _RenderMode;
			half _GradientCat;
			half _DetailMode;
			half _EmissiveCat;
			half _RenderQueue;
			half _render_dst;
			half _render_cull;
			half _GlobalCat;
			half _RenderNormals;
			half _SpaceRenderFade;
			half _OcclusionCat;
			half _MessageTranslucencyHD;
			half _TranslucencyDirectValue;
			half _SpaceMotionLocals;
			half _TranslucencyShadowValue;
			half _FadeHorizontalValue;
			half _SpaceGlobalLayers;
			half _IsTVEShader;
			half _MessageSizeFade;
			half _TranslucencyAmbientValue;
			half _TranslucencyIntensityValue;
			half _RenderSSR;
			half _RenderDecals;
			half _TranslucencyScatteringValue;
			half _TranslucencyNormalValue;
			half _MessageMotionVariation;
			half _VertexVariationMode;
			half _MessageGlobalsVariation;
			half _MainCat;
			half _VertexRollingMode;
			half _Cutoff;
			half _NoiseCat;
			half _EmissiveFlagMode;
			half _HasOcclusion;
			half _LayerReactValue;
			half _RenderClip;
			half _FadeVerticalValue;
			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _MainTex;
			half TVE_Enabled;
			sampler2D _BumpMap;
			half4 TVE_MotionParams;
			TEXTURE2D_ARRAY(TVE_MotionTex);
			half4 TVE_MotionCoords;
			SAMPLER(samplerTVE_MotionTex);
			float TVE_MotionUsage[10];
			half4 TVE_MotionParamsMin;
			half4 TVE_MotionParamsMax;
			sampler2D TVE_NoiseTex;
			half4 TVE_NoiseParams;
			half4 TVE_VertexParams;
			TEXTURE2D_ARRAY(TVE_VertexTex);
			half4 TVE_VertexCoords;
			SAMPLER(samplerTVE_VertexTex);
			float TVE_VertexUsage[10];
			half _DisableSRPBatcher;
			sampler3D TVE_WorldTex3D;
			sampler2D _MainAlbedoTex;
			half4 TVE_ColorsParams;
			TEXTURE2D_ARRAY(TVE_ColorsTex);
			half4 TVE_ColorsCoords;
			SAMPLER(samplerTVE_ColorsTex);
			float TVE_ColorsUsage[10];
			sampler2D _MainMaskTex;
			half4 TVE_MainLightParams;
			half3 TVE_MainLightDirection;
			half4 TVE_OverlayColor;
			half4 TVE_ExtrasParams;
			TEXTURE2D_ARRAY(TVE_ExtrasTex);
			half4 TVE_ExtrasCoords;
			SAMPLER(samplerTVE_ExtrasTex);
			float TVE_ExtrasUsage[10];
			sampler2D _MainNormalTex;
			sampler2D _EmissiveTex;
			half TVE_OverlaySmoothness;
			sampler3D TVE_ScreenTex3D;
			half TVE_ScreenTexCoord;


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float3 VertexPosition3588_g55655 = v.vertex.xyz;
				half3 Mesh_PivotsOS2291_g55655 = half3(0,0,0);
				float3 temp_output_2283_0_g55655 = ( VertexPosition3588_g55655 - Mesh_PivotsOS2291_g55655 );
				half3 VertexPos40_g62634 = temp_output_2283_0_g55655;
				float3 appendResult74_g62634 = (float3(VertexPos40_g62634.x , 0.0 , 0.0));
				half3 VertexPosRotationAxis50_g62634 = appendResult74_g62634;
				float3 break84_g62634 = VertexPos40_g62634;
				float3 appendResult81_g62634 = (float3(0.0 , break84_g62634.y , break84_g62634.z));
				half3 VertexPosOtherAxis82_g62634 = appendResult81_g62634;
				float4 temp_output_91_19_g62645 = TVE_MotionCoords;
				float4x4 break19_g62677 = GetObjectToWorldMatrix();
				float3 appendResult20_g62677 = (float3(break19_g62677[ 0 ][ 3 ] , break19_g62677[ 1 ][ 3 ] , break19_g62677[ 2 ][ 3 ]));
				half3 ObjectData20_g62678 = appendResult20_g62677;
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				half3 WorldData19_g62678 = ase_worldPos;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62678 = WorldData19_g62678;
				#else
				float3 staticSwitch14_g62678 = ObjectData20_g62678;
				#endif
				float3 temp_output_114_0_g62677 = staticSwitch14_g62678;
				float3 vertexToFrag4224_g55655 = temp_output_114_0_g62677;
				half3 ObjectData20_g62665 = vertexToFrag4224_g55655;
				float3 vertexToFrag3890_g55655 = ase_worldPos;
				half3 WorldData19_g62665 = vertexToFrag3890_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62665 = WorldData19_g62665;
				#else
				float3 staticSwitch14_g62665 = ObjectData20_g62665;
				#endif
				float3 ObjectPosition4223_g55655 = staticSwitch14_g62665;
				float3 Position83_g62645 = ObjectPosition4223_g55655;
				float temp_output_84_0_g62645 = _LayerMotionValue;
				float4 lerpResult87_g62645 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, samplerTVE_MotionTex, ( (temp_output_91_19_g62645).zw + ( (temp_output_91_19_g62645).xy * (Position83_g62645).xz ) ),temp_output_84_0_g62645, 0.0 ) , TVE_MotionUsage[(int)temp_output_84_0_g62645]);
				half4 Global_Motion_Params3909_g55655 = lerpResult87_g62645;
				float4 break322_g62615 = Global_Motion_Params3909_g55655;
				float3 appendResult397_g62615 = (float3(break322_g62615.x , 0.0 , break322_g62615.y));
				float3 temp_output_398_0_g62615 = (appendResult397_g62615*2.0 + -1.0);
				float3 ase_parentObjectScale = ( 1.0 / float3( length( GetWorldToObjectMatrix()[ 0 ].xyz ), length( GetWorldToObjectMatrix()[ 1 ].xyz ), length( GetWorldToObjectMatrix()[ 2 ].xyz ) ) );
				half2 Global_MotionDirectionOS39_g55655 = (( mul( GetWorldToObjectMatrix(), float4( temp_output_398_0_g62615 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half ObjectData20_g62639 = 3.14;
				float Bounds_Height374_g55655 = _MaxBoundsInfo.y;
				half WorldData19_g62639 = ( Bounds_Height374_g55655 * 3.14 );
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62639 = WorldData19_g62639;
				#else
				float staticSwitch14_g62639 = ObjectData20_g62639;
				#endif
				float Motion_Max_Bending1133_g55655 = staticSwitch14_g62639;
				half Mesh_Motion_1082_g55655 = v.ase_texcoord3.x;
				half Motion_10_Mask4617_g55655 = ( _MotionAmplitude_10 * Motion_Max_Bending1133_g55655 * Mesh_Motion_1082_g55655 );
				half Input_Speed62_g62605 = _MotionSpeed_10;
				float mulTime373_g62605 = _TimeParameters.x * Input_Speed62_g62605;
				float3 break111_g62621 = ObjectPosition4223_g55655;
				float Mesh_Variation16_g55655 = v.ase_color.r;
				half VertexDynamicMode4798_g55655 = _VertexDynamicMode;
				float lerpResult4795_g55655 = lerp( frac( ( v.ase_color.r + ( break111_g62621.x + break111_g62621.z ) ) ) , Mesh_Variation16_g55655 , VertexDynamicMode4798_g55655);
				half ObjectData20_g62614 = lerpResult4795_g55655;
				half WorldData19_g62614 = Mesh_Variation16_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62614 = WorldData19_g62614;
				#else
				float staticSwitch14_g62614 = ObjectData20_g62614;
				#endif
				half Motion_Variation3073_g55655 = staticSwitch14_g62614;
				half Motion_10_Variation4581_g55655 = ( _MotionVariation_10 * Motion_Variation3073_g55655 );
				half Motion_Variation284_g62605 = Motion_10_Variation4581_g55655;
				float Motion_Scale287_g62605 = ( _MotionScale_10 * ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z ) );
				half Sine_MinusOneToOne281_g62605 = sin( ( mulTime373_g62605 + Motion_Variation284_g62605 + Motion_Scale287_g62605 ) );
				half Input_WindSquash419_g62605 = 0.2;
				half Wind_Power369_g62615 = break322_g62615.z;
				float lerpResult376_g62615 = lerp( TVE_MotionParamsMin.x , TVE_MotionParamsMax.x , Wind_Power369_g62615);
				half Wind_Stop420_g62615 = saturate( ( Wind_Power369_g62615 * 10.0 ) );
				half Global_MotionPower_103106_g55655 = ( lerpResult376_g62615 * Wind_Stop420_g62615 );
				half Input_WindPower327_g62605 = Global_MotionPower_103106_g55655;
				float lerpResult321_g62605 = lerp( Sine_MinusOneToOne281_g62605 , (Sine_MinusOneToOne281_g62605*Input_WindSquash419_g62605 + 1.0) , Input_WindPower327_g62605);
				half Motion_10_SinWaveAm4570_g55655 = lerpResult321_g62605;
				float2 panner437_g62615 = ( _TimeParameters.x * (TVE_NoiseParams).xy + ( (ObjectPosition4223_g55655).xz * TVE_NoiseParams.z ));
				float saferPower446_g62615 = abs( abs( tex2Dlod( TVE_NoiseTex, float4( panner437_g62615, 0, 0.0) ).r ) );
				float lerpResult448_g62615 = lerp( TVE_MotionParamsMin.w , TVE_MotionParamsMax.w , Wind_Power369_g62615);
				half Global_MotionNoise34_g55655 = pow( saferPower446_g62615 , lerpResult448_g62615 );
				half Motion_10_Bending2258_g55655 = ( Motion_10_Mask4617_g55655 * Motion_10_SinWaveAm4570_g55655 * Global_MotionPower_103106_g55655 * Global_MotionNoise34_g55655 );
				half Interaction_Amplitude4137_g55655 = _InteractionAmplitude;
				float lerpResult4494_g55655 = lerp( 1.0 , Mesh_Motion_1082_g55655 , _InteractionMaskValue);
				half ObjectData20_g62620 = lerpResult4494_g55655;
				half WorldData19_g62620 = Mesh_Motion_1082_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62620 = WorldData19_g62620;
				#else
				float staticSwitch14_g62620 = ObjectData20_g62620;
				#endif
				half Motion_10_Interaction53_g55655 = ( Interaction_Amplitude4137_g55655 * Motion_Max_Bending1133_g55655 * staticSwitch14_g62620 );
				half Global_InteractionMask66_g55655 = ( break322_g62615.w * break322_g62615.w );
				float lerpResult4685_g55655 = lerp( Motion_10_Bending2258_g55655 , Motion_10_Interaction53_g55655 , saturate( ( Global_InteractionMask66_g55655 * Interaction_Amplitude4137_g55655 ) ));
				float2 break4603_g55655 = ( Global_MotionDirectionOS39_g55655 * lerpResult4685_g55655 );
				half Vertex_ZAxisRotatin190_g55655 = break4603_g55655.y;
				half Angle44_g62634 = Vertex_ZAxisRotatin190_g55655;
				half3 VertexPos40_g62631 = ( VertexPosRotationAxis50_g62634 + ( VertexPosOtherAxis82_g62634 * cos( Angle44_g62634 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g62634 ) * sin( Angle44_g62634 ) ) );
				float3 appendResult74_g62631 = (float3(0.0 , 0.0 , VertexPos40_g62631.z));
				half3 VertexPosRotationAxis50_g62631 = appendResult74_g62631;
				float3 break84_g62631 = VertexPos40_g62631;
				float3 appendResult81_g62631 = (float3(break84_g62631.x , break84_g62631.y , 0.0));
				half3 VertexPosOtherAxis82_g62631 = appendResult81_g62631;
				half Vertex_XAxisRotation216_g55655 = break4603_g55655.x;
				half Angle44_g62631 = -Vertex_XAxisRotation216_g55655;
				float3 Vertex_Motion_Object833_g55655 = ( VertexPosRotationAxis50_g62631 + ( VertexPosOtherAxis82_g62631 * cos( Angle44_g62631 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g62631 ) * sin( Angle44_g62631 ) ) );
				float3 temp_output_3474_0_g55655 = ( VertexPosition3588_g55655 - Mesh_PivotsOS2291_g55655 );
				float3 appendResult2043_g55655 = (float3(Vertex_XAxisRotation216_g55655 , 0.0 , Vertex_ZAxisRotatin190_g55655));
				float3 Vertex_Motion_World1118_g55655 = ( temp_output_3474_0_g55655 + appendResult2043_g55655 );
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch3312_g55655 = Vertex_Motion_World1118_g55655;
				#else
				float3 staticSwitch3312_g55655 = ( Vertex_Motion_Object833_g55655 + ( 0.0 * _VertexDataMode ) );
				#endif
				float4 temp_output_94_19_g62640 = TVE_VertexCoords;
				float3 Position83_g62640 = ObjectPosition4223_g55655;
				float temp_output_84_0_g62640 = _LayerVertexValue;
				float4 lerpResult87_g62640 = lerp( TVE_VertexParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, samplerTVE_VertexTex, ( (temp_output_94_19_g62640).zw + ( (temp_output_94_19_g62640).xy * (Position83_g62640).xz ) ),temp_output_84_0_g62640, 0.0 ) , TVE_VertexUsage[(int)temp_output_84_0_g62640]);
				half4 Global_Object_Params4173_g55655 = lerpResult87_g62640;
				half Global_VertexSize174_g55655 = Global_Object_Params4173_g55655.w;
				float lerpResult16_g62663 = lerp( 0.0 , _GlobalSize , TVE_Enabled);
				float lerpResult346_g55655 = lerp( 1.0 , Global_VertexSize174_g55655 , lerpResult16_g62663);
				float3 appendResult3480_g55655 = (float3(lerpResult346_g55655 , lerpResult346_g55655 , lerpResult346_g55655));
				half3 ObjectData20_g62676 = appendResult3480_g55655;
				half3 _Vector11 = half3(1,1,1);
				half3 WorldData19_g62676 = _Vector11;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62676 = WorldData19_g62676;
				#else
				float3 staticSwitch14_g62676 = ObjectData20_g62676;
				#endif
				half3 Vertex_Size1741_g55655 = staticSwitch14_g62676;
				half3 _Vector5 = half3(1,1,1);
				float3 Vertex_SizeFade1740_g55655 = _Vector5;
				half3 Grass_Perspective2661_g55655 = half3(0,0,0);
				float3 Final_VertexPosition890_g55655 = ( ( ( staticSwitch3312_g55655 * Vertex_Size1741_g55655 * Vertex_SizeFade1740_g55655 ) + Mesh_PivotsOS2291_g55655 + Grass_Perspective2661_g55655 ) + _DisableSRPBatcher );
				
				half Mesh_Height1524_g55655 = v.ase_color.a;
				float temp_output_7_0_g62660 = _GradientMinValue;
				half Gradient_Tint2784_g55655 = saturate( ( ( Mesh_Height1524_g55655 - temp_output_7_0_g62660 ) / ( _GradientMaxValue - temp_output_7_0_g62660 ) ) );
				float vertexToFrag11_g62658 = Gradient_Tint2784_g55655;
				o.ase_texcoord8.x = vertexToFrag11_g62658;
				float3 temp_cast_8 = (_NoiseScaleValue).xxx;
				float3 WorldPosition3905_g55655 = vertexToFrag3890_g55655;
				float temp_output_7_0_g62667 = _NoiseMinValue;
				half Noise_Tint2802_g55655 = saturate( ( ( tex3Dlod( TVE_WorldTex3D, float4( ( temp_cast_8 * WorldPosition3905_g55655 * 0.1 ), 0.0) ).r - temp_output_7_0_g62667 ) / ( _NoiseMaxValue - temp_output_7_0_g62667 ) ) );
				float vertexToFrag11_g62662 = Noise_Tint2802_g55655;
				o.ase_texcoord8.y = vertexToFrag11_g62662;
				float2 vertexToFrag11_g62604 = ( ( v.texcoord.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord8.zw = vertexToFrag11_g62604;
				o.ase_texcoord9.xyz = vertexToFrag3890_g55655;
				o.ase_texcoord10.xyz = vertexToFrag4224_g55655;
				
				float2 vertexToFrag11_g62644 = ( ( v.texcoord.xy * (_EmissiveUVs).xy ) + (_EmissiveUVs).zw );
				o.ase_texcoord11.xy = vertexToFrag11_g62644;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord9.w = 0;
				o.ase_texcoord10.w = 0;
				o.ase_texcoord11.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = Final_VertexPosition890_g55655;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float3 positionVS = TransformWorldToView( positionWS );
				float4 positionCS = TransformWorldToHClip( positionWS );

				VertexNormalInputs normalInput = GetVertexNormalInputs( v.ase_normal, v.ase_tangent );

				o.tSpace0 = float4( normalInput.normalWS, positionWS.x);
				o.tSpace1 = float4( normalInput.tangentWS, positionWS.y);
				o.tSpace2 = float4( normalInput.bitangentWS, positionWS.z);

				#if defined(LIGHTMAP_ON)
				OUTPUT_LIGHTMAP_UV( v.texcoord1, unity_LightmapST, o.lightmapUVOrVertexSH.xy );
				#endif

				#if defined(DYNAMICLIGHTMAP_ON)
				o.dynamicLightmapUV.xy = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif

				#if !defined(LIGHTMAP_ON)
				OUTPUT_SH( normalInput.normalWS.xyz, o.lightmapUVOrVertexSH.xyz );
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					o.lightmapUVOrVertexSH.zw = v.texcoord;
					o.lightmapUVOrVertexSH.xy = v.texcoord * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif

				half3 vertexLight = VertexLighting( positionWS, normalInput.normalWS );
				#ifdef ASE_FOG
					half fogFactor = ComputeFogFactor( positionCS.z );
				#else
					half fogFactor = 0;
				#endif
				o.fogFactorAndVertexLight = half4(fogFactor, vertexLight);
				
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
				VertexPositionInputs vertexInput = (VertexPositionInputs)0;
				vertexInput.positionWS = positionWS;
				vertexInput.positionCS = positionCS;
				o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				
				o.clipPos = positionCS;
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				o.screenPos = ComputeScreenPos(positionCS);
				#endif
				return o;
			}
			
			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_tangent = v.ase_tangent;
				o.texcoord = v.texcoord;
				o.texcoord1 = v.texcoord1;
				o.texcoord2 = v.texcoord2;
				o.texcoord = v.texcoord;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				o.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				o.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE)
				#define ASE_SV_DEPTH SV_DepthLessEqual  
			#else
				#define ASE_SV_DEPTH SV_Depth
			#endif

			half4 frag ( VertexOutput IN 
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						, FRONT_FACE_TYPE ase_vface : FRONT_FACE_SEMANTIC ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float2 sampleCoords = (IN.lightmapUVOrVertexSH.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					float3 WorldNormal = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					float3 WorldTangent = -cross(GetObjectToWorldMatrix()._13_23_33, WorldNormal);
					float3 WorldBiTangent = cross(WorldNormal, -WorldTangent);
				#else
					float3 WorldNormal = normalize( IN.tSpace0.xyz );
					float3 WorldTangent = IN.tSpace1.xyz;
					float3 WorldBiTangent = IN.tSpace2.xyz;
				#endif
				float3 WorldPosition = float3(IN.tSpace0.w,IN.tSpace1.w,IN.tSpace2.w);
				float3 WorldViewDirection = _WorldSpaceCameraPos.xyz  - WorldPosition;
				float4 ShadowCoords = float4( 0, 0, 0, 0 );
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				float4 ScreenPos = IN.screenPos;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					ShadowCoords = IN.shadowCoord;
				#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
				#endif
	
				WorldViewDirection = SafeNormalize( WorldViewDirection );

				float vertexToFrag11_g62658 = IN.ase_texcoord8.x;
				float3 lerpResult2779_g55655 = lerp( (_GradientColorTwo).rgb , (_GradientColorOne).rgb , vertexToFrag11_g62658);
				float vertexToFrag11_g62662 = IN.ase_texcoord8.y;
				float3 lerpResult2800_g55655 = lerp( (_NoiseColorTwo).rgb , (_NoiseColorOne).rgb , vertexToFrag11_g62662);
				half Leaves_Mask4511_g55655 = 1.0;
				float3 lerpResult4521_g55655 = lerp( float3( 1,1,1 ) , ( lerpResult2779_g55655 * lerpResult2800_g55655 * float3(1,1,1) ) , Leaves_Mask4511_g55655);
				float3 lerpResult4519_g55655 = lerp( float3( 1,1,1 ) , (_MainColor).rgb , Leaves_Mask4511_g55655);
				float2 vertexToFrag11_g62604 = IN.ase_texcoord8.zw;
				half2 Main_UVs15_g55655 = vertexToFrag11_g62604;
				float4 tex2DNode29_g55655 = tex2D( _MainAlbedoTex, Main_UVs15_g55655 );
				half3 Main_Albedo99_g55655 = ( lerpResult4519_g55655 * (tex2DNode29_g55655).rgb );
				half3 Blend_Albedo265_g55655 = Main_Albedo99_g55655;
				half3 Blend_AlbedoTinted2808_g55655 = ( lerpResult4521_g55655 * Blend_Albedo265_g55655 );
				float dotResult3616_g55655 = dot( Blend_AlbedoTinted2808_g55655 , float3(0.2126,0.7152,0.0722) );
				float3 temp_cast_0 = (dotResult3616_g55655).xxx;
				float4 temp_output_91_19_g62668 = TVE_ColorsCoords;
				float3 vertexToFrag3890_g55655 = IN.ase_texcoord9.xyz;
				float3 WorldPosition3905_g55655 = vertexToFrag3890_g55655;
				float3 vertexToFrag4224_g55655 = IN.ase_texcoord10.xyz;
				half3 ObjectData20_g62665 = vertexToFrag4224_g55655;
				half3 WorldData19_g62665 = vertexToFrag3890_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62665 = WorldData19_g62665;
				#else
				float3 staticSwitch14_g62665 = ObjectData20_g62665;
				#endif
				float3 ObjectPosition4223_g55655 = staticSwitch14_g62665;
				float3 lerpResult4822_g55655 = lerp( WorldPosition3905_g55655 , ObjectPosition4223_g55655 , _ColorsPositionMode);
				float3 Position58_g62668 = lerpResult4822_g55655;
				float temp_output_82_0_g62668 = _LayerColorsValue;
				float4 lerpResult88_g62668 = lerp( TVE_ColorsParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ColorsTex, samplerTVE_ColorsTex, ( (temp_output_91_19_g62668).zw + ( (temp_output_91_19_g62668).xy * (Position58_g62668).xz ) ),temp_output_82_0_g62668 ) , TVE_ColorsUsage[(int)temp_output_82_0_g62668]);
				half Global_ColorsTex_A1701_g55655 = (lerpResult88_g62668).a;
				half Global_Colors_Influence3668_g55655 = saturate( Global_ColorsTex_A1701_g55655 );
				float3 lerpResult3618_g55655 = lerp( Blend_AlbedoTinted2808_g55655 , temp_cast_0 , Global_Colors_Influence3668_g55655);
				half3 Global_ColorsTex_RGB1700_g55655 = (lerpResult88_g62668).rgb;
				#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch1_g62681 = 2.0;
				#else
				float staticSwitch1_g62681 = 4.594794;
				#endif
				half3 Global_Colors1954_g55655 = ( Global_ColorsTex_RGB1700_g55655 * staticSwitch1_g62681 );
				half Global_Colors_Value3650_g55655 = _GlobalColors;
				float4 tex2DNode35_g55655 = tex2D( _MainMaskTex, Main_UVs15_g55655 );
				half Main_Mask57_g55655 = tex2DNode35_g55655.b;
				float temp_output_7_0_g62654 = _ColorsMaskMinValue;
				half Global_Colors_Mask3692_g55655 = saturate( ( ( Main_Mask57_g55655 - temp_output_7_0_g62654 ) / ( _ColorsMaskMaxValue - temp_output_7_0_g62654 ) ) );
				float lerpResult16_g62624 = lerp( 0.0 , ( Global_Colors_Value3650_g55655 * Global_Colors_Mask3692_g55655 ) , TVE_Enabled);
				float3 lerpResult3628_g55655 = lerp( Blend_AlbedoTinted2808_g55655 , ( lerpResult3618_g55655 * Global_Colors1954_g55655 ) , lerpResult16_g62624);
				half3 Blend_AlbedoColored863_g55655 = lerpResult3628_g55655;
				float3 temp_output_799_0_g55655 = (_SubsurfaceColor).rgb;
				float dotResult3930_g55655 = dot( temp_output_799_0_g55655 , float3(0.2126,0.7152,0.0722) );
				float3 temp_cast_3 = (dotResult3930_g55655).xxx;
				float3 lerpResult3932_g55655 = lerp( temp_output_799_0_g55655 , temp_cast_3 , Global_Colors_Influence3668_g55655);
				float3 lerpResult3942_g55655 = lerp( temp_output_799_0_g55655 , ( lerpResult3932_g55655 * Global_Colors1954_g55655 ) , ( Global_Colors_Value3650_g55655 * Global_Colors_Mask3692_g55655 ));
				half3 Subsurface_Color1722_g55655 = lerpResult3942_g55655;
				half MainLight_Subsurface4041_g55655 = TVE_MainLightParams.a;
				half Subsurface_Intensity1752_g55655 = ( _SubsurfaceValue * MainLight_Subsurface4041_g55655 );
				float temp_output_7_0_g62675 = _SubsurfaceMaskMinValue;
				half Subsurface_Mask1557_g55655 = saturate( ( ( Main_Mask57_g55655 - temp_output_7_0_g62675 ) / ( _SubsurfaceMaskMaxValue - temp_output_7_0_g62675 ) ) );
				half3 Subsurface_Transmission884_g55655 = ( Subsurface_Color1722_g55655 * Subsurface_Intensity1752_g55655 * Subsurface_Mask1557_g55655 );
				half3 MainLight_Direction3926_g55655 = TVE_MainLightDirection;
				float3 normalizeResult2169_g55655 = normalize( WorldViewDirection );
				float3 ViewDir_Normalized3963_g55655 = normalizeResult2169_g55655;
				float dotResult785_g55655 = dot( -MainLight_Direction3926_g55655 , ViewDir_Normalized3963_g55655 );
				float saferPower1624_g55655 = abs( (dotResult785_g55655*0.5 + 0.5) );
				#ifdef UNITY_PASS_FORWARDADD
				float staticSwitch1602_g55655 = 0.0;
				#else
				float staticSwitch1602_g55655 = ( pow( saferPower1624_g55655 , _MainLightAngleValue ) * _MainLightScatteringValue );
				#endif
				half Mask_Subsurface_View782_g55655 = staticSwitch1602_g55655;
				half3 Subsurface_Scattering1693_g55655 = ( Subsurface_Transmission884_g55655 * Blend_AlbedoColored863_g55655 * Mask_Subsurface_View782_g55655 );
				half3 Blend_AlbedoAndSubsurface149_g55655 = ( Blend_AlbedoColored863_g55655 + Subsurface_Scattering1693_g55655 );
				half3 Global_OverlayColor1758_g55655 = (TVE_OverlayColor).rgb;
				half Main_AlbedoTex_G3526_g55655 = tex2DNode29_g55655.g;
				float4 temp_output_93_19_g62635 = TVE_ExtrasCoords;
				float3 lerpResult4827_g55655 = lerp( WorldPosition3905_g55655 , ObjectPosition4223_g55655 , _ExtrasPositionMode);
				float3 Position82_g62635 = lerpResult4827_g55655;
				float temp_output_84_0_g62635 = _LayerExtrasValue;
				float4 lerpResult88_g62635 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ExtrasTex, samplerTVE_ExtrasTex, ( (temp_output_93_19_g62635).zw + ( (temp_output_93_19_g62635).xy * (Position82_g62635).xz ) ),temp_output_84_0_g62635 ) , TVE_ExtrasUsage[(int)temp_output_84_0_g62635]);
				float4 break89_g62635 = lerpResult88_g62635;
				half Global_Extras_Overlay156_g55655 = break89_g62635.b;
				half Overlay_Variation4560_g55655 = 1.0;
				half Overlay_Commons1365_g55655 = ( _GlobalOverlay * Global_Extras_Overlay156_g55655 * Overlay_Variation4560_g55655 );
				float temp_output_7_0_g62666 = _OverlayMaskMinValue;
				half Overlay_Mask269_g55655 = saturate( ( ( ( ( 0.5 + Main_AlbedoTex_G3526_g55655 ) * Overlay_Commons1365_g55655 ) - temp_output_7_0_g62666 ) / ( _OverlayMaskMaxValue - temp_output_7_0_g62666 ) ) );
				float3 lerpResult336_g55655 = lerp( Blend_AlbedoAndSubsurface149_g55655 , Global_OverlayColor1758_g55655 , Overlay_Mask269_g55655);
				half3 Final_Albedo359_g55655 = lerpResult336_g55655;
				
				float3 unpack4112_g55655 = UnpackNormalScale( tex2D( _MainNormalTex, Main_UVs15_g55655 ), _MainNormalValue );
				unpack4112_g55655.z = lerp( 1, unpack4112_g55655.z, saturate(_MainNormalValue) );
				half3 Main_Normal137_g55655 = unpack4112_g55655;
				float3 temp_output_13_0_g62598 = Main_Normal137_g55655;
				float3 switchResult12_g62598 = (((ase_vface>0)?(temp_output_13_0_g62598):(( temp_output_13_0_g62598 * _render_normals_options ))));
				half3 Blend_Normal312_g55655 = switchResult12_g62598;
				half3 Final_Normal366_g55655 = Blend_Normal312_g55655;
				
				float4 temp_output_4214_0_g55655 = ( _EmissiveColor * _EmissiveIntensityParams.x );
				float2 vertexToFrag11_g62644 = IN.ase_texcoord11.xy;
				half2 Emissive_UVs2468_g55655 = vertexToFrag11_g62644;
				half Global_Extras_Emissive4203_g55655 = break89_g62635.r;
				float lerpResult4206_g55655 = lerp( 1.0 , Global_Extras_Emissive4203_g55655 , _GlobalEmissive);
				half3 Final_Emissive2476_g55655 = ( (( temp_output_4214_0_g55655 * tex2D( _EmissiveTex, Emissive_UVs2468_g55655 ) )).rgb * lerpResult4206_g55655 );
				
				float3 temp_cast_7 = (( 0.04 * _RenderSpecular )).xxx;
				
				half Main_Smoothness227_g55655 = ( tex2DNode35_g55655.a * _MainSmoothnessValue );
				half Blend_Smoothness314_g55655 = Main_Smoothness227_g55655;
				half Global_OverlaySmoothness311_g55655 = TVE_OverlaySmoothness;
				float lerpResult343_g55655 = lerp( Blend_Smoothness314_g55655 , Global_OverlaySmoothness311_g55655 , Overlay_Mask269_g55655);
				half Final_Smoothness371_g55655 = lerpResult343_g55655;
				half Global_Extras_Wetness305_g55655 = break89_g62635.g;
				float lerpResult3673_g55655 = lerp( 0.0 , Global_Extras_Wetness305_g55655 , _GlobalWetness);
				half Final_SmoothnessAndWetness4130_g55655 = saturate( ( Final_Smoothness371_g55655 + lerpResult3673_g55655 ) );
				
				float lerpResult240_g55655 = lerp( 1.0 , tex2DNode35_g55655.g , _MainOcclusionValue);
				half Main_Occlusion247_g55655 = lerpResult240_g55655;
				half Blend_Occlusion323_g55655 = Main_Occlusion247_g55655;
				
				float localCustomAlphaClip3735_g55655 = ( 0.0 );
				float3 normalizeResult3971_g55655 = normalize( cross( ddy( WorldPosition ) , ddx( WorldPosition ) ) );
				float3 NormalsWS_Derivates3972_g55655 = normalizeResult3971_g55655;
				float dotResult2161_g55655 = dot( ViewDir_Normalized3963_g55655 , NormalsWS_Derivates3972_g55655 );
				float dotResult2212_g55655 = dot( ViewDir_Normalized3963_g55655 , float3(0,1,0) );
				half Mask_HView2656_g55655 = dotResult2212_g55655;
				float lerpResult2221_g55655 = lerp( _FadeHorizontalValue , _FadeVerticalValue , Mask_HView2656_g55655);
				float lerpResult3992_g55655 = lerp( 1.0 , saturate( abs( dotResult2161_g55655 ) ) , lerpResult2221_g55655);
				half Fade_Billboard2175_g55655 = lerpResult3992_g55655;
				float temp_output_41_0_g62674 = ( 1.0 * Fade_Billboard2175_g55655 );
				half Final_AlphaFade3727_g55655 = saturate( ( temp_output_41_0_g62674 + ( temp_output_41_0_g62674 * tex3D( TVE_ScreenTex3D, ( TVE_ScreenTexCoord * WorldPosition3905_g55655 ) ).r ) ) );
				float Main_Alpha316_g55655 = ( _MainColor.a * tex2DNode29_g55655.a );
				half AlphaTreshold2132_g55655 = _Cutoff;
				#ifdef TVE_ALPHA_CLIP
				float staticSwitch3792_g55655 = ( Main_Alpha316_g55655 - ( AlphaTreshold2132_g55655 - 0.5 ) );
				#else
				float staticSwitch3792_g55655 = Main_Alpha316_g55655;
				#endif
				half Final_Alpha3754_g55655 = staticSwitch3792_g55655;
				float temp_output_661_0_g55655 = ( Final_AlphaFade3727_g55655 * Final_Alpha3754_g55655 );
				float Alpha3735_g55655 = temp_output_661_0_g55655;
				float Treshold3735_g55655 = 0.5;
				{
				#if TVE_ALPHA_CLIP
				clip(Alpha3735_g55655 - Treshold3735_g55655);
				#endif
				}
				half Final_Clip914_g55655 = saturate( Alpha3735_g55655 );
				
				float3 Albedo = Final_Albedo359_g55655;
				float3 Normal = Final_Normal366_g55655;
				float3 Emission = Final_Emissive2476_g55655;
				float3 Specular = temp_cast_7;
				float Metallic = 0;
				float Smoothness = Final_SmoothnessAndWetness4130_g55655;
				float Occlusion = Blend_Occlusion323_g55655;
				float Alpha = Final_Clip914_g55655;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;
				float3 BakedGI = 0;
				float3 RefractionColor = 1;
				float RefractionIndex = 1;
				float3 Transmission = 1;
				float3 Translucency = 1;
				#ifdef ASE_DEPTH_WRITE_ON
				float DepthValue = 0;
				#endif
				
				#ifdef _CLEARCOAT
				float CoatMask = 0;
				float CoatSmoothness = 0;
				#endif


				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				InputData inputData = (InputData)0;
				inputData.positionWS = WorldPosition;
				inputData.viewDirectionWS = WorldViewDirection;
				

				#ifdef _NORMALMAP
					#if _NORMAL_DROPOFF_TS
					inputData.normalWS = TransformTangentToWorld(Normal, half3x3( WorldTangent, WorldBiTangent, WorldNormal ));
					#elif _NORMAL_DROPOFF_OS
					inputData.normalWS = TransformObjectToWorldNormal(Normal);
					#elif _NORMAL_DROPOFF_WS
					inputData.normalWS = Normal;
					#endif
					inputData.normalWS = NormalizeNormalPerPixel(inputData.normalWS);
				#else
					inputData.normalWS = WorldNormal;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					inputData.shadowCoord = ShadowCoords;
				#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					inputData.shadowCoord = TransformWorldToShadowCoord(inputData.positionWS);
				#else
					inputData.shadowCoord = float4(0, 0, 0, 0);
				#endif


				#ifdef ASE_FOG
					inputData.fogCoord = IN.fogFactorAndVertexLight.x;
				#endif

				inputData.vertexLighting = IN.fogFactorAndVertexLight.yzw;
				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float3 SH = SampleSH(inputData.normalWS.xyz);
				#else
					float3 SH = IN.lightmapUVOrVertexSH.xyz;
				#endif

				#if defined(DYNAMICLIGHTMAP_ON)
				inputData.bakedGI = SAMPLE_GI(IN.lightmapUVOrVertexSH.xy, IN.dynamicLightmapUV.xy, SH, inputData.normalWS);
				#else
				inputData.bakedGI = SAMPLE_GI( IN.lightmapUVOrVertexSH.xy, SH, inputData.normalWS );
				#endif

				#ifdef _ASE_BAKEDGI
					inputData.bakedGI = BakedGI;
				#endif
				
				inputData.normalizedScreenSpaceUV = GetNormalizedScreenSpaceUV(IN.clipPos);
				inputData.shadowMask = SAMPLE_SHADOWMASK(IN.lightmapUVOrVertexSH.xy);

				#if defined(DEBUG_DISPLAY)
					#if defined(DYNAMICLIGHTMAP_ON)
						inputData.dynamicLightmapUV = IN.dynamicLightmapUV.xy;
					#endif

					#if defined(LIGHTMAP_ON)
						inputData.staticLightmapUV = IN.lightmapUVOrVertexSH.xy;
					#else
						inputData.vertexSH = SH;
					#endif
				#endif

				SurfaceData surfaceData;
				surfaceData.albedo              = Albedo;
				surfaceData.metallic            = saturate(Metallic);
				surfaceData.specular            = Specular;
				surfaceData.smoothness          = saturate(Smoothness),
				surfaceData.occlusion           = Occlusion,
				surfaceData.emission            = Emission,
				surfaceData.alpha               = saturate(Alpha);
				surfaceData.normalTS            = Normal;
				surfaceData.clearCoatMask       = 0;
				surfaceData.clearCoatSmoothness = 1;


				#ifdef _CLEARCOAT
					surfaceData.clearCoatMask       = saturate(CoatMask);
					surfaceData.clearCoatSmoothness = saturate(CoatSmoothness);
				#endif

				#ifdef _DBUFFER
					ApplyDecalToSurfaceData(IN.clipPos, surfaceData, inputData);
				#endif

				half4 color = UniversalFragmentPBR( inputData, surfaceData);

				#ifdef _TRANSMISSION_ASE
				{
					float shadow = _TransmissionShadow;

					Light mainLight = GetMainLight( inputData.shadowCoord );
					float3 mainAtten = mainLight.color * mainLight.distanceAttenuation;
					mainAtten = lerp( mainAtten, mainAtten * mainLight.shadowAttenuation, shadow );
					half3 mainTransmission = max(0 , -dot(inputData.normalWS, mainLight.direction)) * mainAtten * Transmission;
					color.rgb += Albedo * mainTransmission;

					#ifdef _ADDITIONAL_LIGHTS
						int transPixelLightCount = GetAdditionalLightsCount();
						for (int i = 0; i < transPixelLightCount; ++i)
						{
							Light light = GetAdditionalLight(i, inputData.positionWS);
							float3 atten = light.color * light.distanceAttenuation;
							atten = lerp( atten, atten * light.shadowAttenuation, shadow );

							half3 transmission = max(0 , -dot(inputData.normalWS, light.direction)) * atten * Transmission;
							color.rgb += Albedo * transmission;
						}
					#endif
				}
				#endif

				#ifdef _TRANSLUCENCY_ASE
				{
					float shadow = _TransShadow;
					float normal = _TransNormal;
					float scattering = _TransScattering;
					float direct = _TransDirect;
					float ambient = _TransAmbient;
					float strength = _TransStrength;

					Light mainLight = GetMainLight( inputData.shadowCoord );
					float3 mainAtten = mainLight.color * mainLight.distanceAttenuation;
					mainAtten = lerp( mainAtten, mainAtten * mainLight.shadowAttenuation, shadow );

					half3 mainLightDir = mainLight.direction + inputData.normalWS * normal;
					half mainVdotL = pow( saturate( dot( inputData.viewDirectionWS, -mainLightDir ) ), scattering );
					half3 mainTranslucency = mainAtten * ( mainVdotL * direct + inputData.bakedGI * ambient ) * Translucency;
					color.rgb += Albedo * mainTranslucency * strength;

					#ifdef _ADDITIONAL_LIGHTS
						int transPixelLightCount = GetAdditionalLightsCount();
						for (int i = 0; i < transPixelLightCount; ++i)
						{
							Light light = GetAdditionalLight(i, inputData.positionWS);
							float3 atten = light.color * light.distanceAttenuation;
							atten = lerp( atten, atten * light.shadowAttenuation, shadow );

							half3 lightDir = light.direction + inputData.normalWS * normal;
							half VdotL = pow( saturate( dot( inputData.viewDirectionWS, -lightDir ) ), scattering );
							half3 translucency = atten * ( VdotL * direct + inputData.bakedGI * ambient ) * Translucency;
							color.rgb += Albedo * translucency * strength;
						}
					#endif
				}
				#endif

				#ifdef _REFRACTION_ASE
					float4 projScreenPos = ScreenPos / ScreenPos.w;
					float3 refractionOffset = ( RefractionIndex - 1.0 ) * mul( UNITY_MATRIX_V, float4( WorldNormal,0 ) ).xyz * ( 1.0 - dot( WorldNormal, WorldViewDirection ) );
					projScreenPos.xy += refractionOffset.xy;
					float3 refraction = SHADERGRAPH_SAMPLE_SCENE_COLOR( projScreenPos.xy ) * RefractionColor;
					color.rgb = lerp( refraction, color.rgb, color.a );
					color.a = 1;
				#endif

				#ifdef ASE_FINAL_COLOR_ALPHA_MULTIPLY
					color.rgb *= color.a;
				#endif

				#ifdef ASE_FOG
					#ifdef TERRAIN_SPLAT_ADDPASS
						color.rgb = MixFogColor(color.rgb, half3( 0, 0, 0 ), IN.fogFactorAndVertexLight.x );
					#else
						color.rgb = MixFog(color.rgb, IN.fogFactorAndVertexLight.x);
					#endif
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif

				return color;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			ZWrite On
			ZTest LEqual
			AlphaToMask Off
			ColorMask 0

			HLSLPROGRAM
			
			#define _SPECULAR_SETUP 1
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#pragma multi_compile _ DOTS_INSTANCING_ON
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 120100

			
			#pragma vertex vert
			#pragma fragment frag

			// -------------------------------------
			// Universal Pipeline keywords

			// This is used during shadow map generation to differentiate between directional and punctual light shadows, as they use different formulas to apply Normal Bias
			#pragma multi_compile_vertex _ _CASTING_PUNCTUAL_LIGHT_SHADOW

			#define SHADERPASS SHADERPASS_SHADOWCASTER

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#pragma shader_feature_local TVE_ALPHA_CLIP
			#pragma shader_feature_local TVE_VERTEX_DATA_BATCHED
			//TVE Shader Type Defines
			#define TVE_IS_VEGETATION_SHADER
			//TVE Pipeline Defines
			#define THE_VEGETATION_ENGINE
			#define TVE_IS_UNIVERSAL_PIPELINE
			//TVE Injection Defines
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _GradientMaskRemap;
			half4 _SubsurfaceColor;
			half4 _ColorsMaskRemap;
			half4 _VertexOcclusionRemap;
			float4 _NoiseMaskRemap;
			half4 _OverlayMaskRemap;
			half4 _SubsurfaceMaskRemap;
			float4 _Color;
			half4 _AlphaMaskRemap;
			half4 _NoiseColorTwo;
			half4 _GradientColorTwo;
			half4 _GradientColorOne;
			float4 _SubsurfaceDiffusion_asset;
			float4 _EmissiveIntensityParams;
			half4 _EmissiveUVs;
			half4 _DetailBlendRemap;
			float4 _MaxBoundsInfo;
			half4 _MainUVs;
			half4 _LeavesMaskRemap;
			half4 _MainColor;
			float4 _SubsurfaceDiffusion_Asset;
			half4 _NoiseColorOne;
			half4 _EmissiveColor;
			half3 _render_normals_options;
			half _GradientMaxValue;
			half _InteractionMaskValue;
			half _GlobalSize;
			half _LayerVertexValue;
			half _VertexDataMode;
			half _InteractionAmplitude;
			float _MotionScale_10;
			half _VertexDynamicMode;
			half _MotionVariation_10;
			float _MotionSpeed_10;
			half _MotionAmplitude_10;
			half _LayerMotionValue;
			half _render_zw;
			half _IsStandardShader;
			half _GradientMinValue;
			half _render_src;
			half _ColorsPositionMode;
			half _NoiseMinValue;
			half _MainOcclusionValue;
			half _GlobalWetness;
			half _MainSmoothnessValue;
			half _RenderSpecular;
			half _GlobalEmissive;
			half _MainNormalValue;
			half _OverlayMaskMaxValue;
			half _OverlayMaskMinValue;
			half _LayerExtrasValue;
			half _ExtrasPositionMode;
			half _NoiseScaleValue;
			half _GlobalOverlay;
			half _MainLightAngleValue;
			half _SubsurfaceMaskMaxValue;
			half _SubsurfaceMaskMinValue;
			half _SubsurfaceValue;
			half _ColorsMaskMaxValue;
			half _ColorsMaskMinValue;
			half _GlobalColors;
			half _LayerColorsValue;
			half _IsCrossShader;
			half _NoiseMaxValue;
			half _MainLightScatteringValue;
			half _SpaceMotionHighlight;
			half _SpaceGlobalPosition;
			half _DetailTypeMode;
			half _RenderPriority;
			half _RenderZWrite;
			half _HasGradient;
			float _SubsurfaceDiffusion;
			half _IsVersion;
			half _MotionCat;
			half _DetailBlendMode;
			half _SpaceRenderReceive;
			half _RenderCull;
			half _HasEmissive;
			half _VertexMasksMode;
			half _SizeFadeCat;
			half _SubsurfaceCat;
			half _PerspectiveCat;
			half _DetailCat;
			half _RenderingCat;
			half _RenderMode;
			half _GradientCat;
			half _DetailMode;
			half _EmissiveCat;
			half _RenderQueue;
			half _render_dst;
			half _render_cull;
			half _GlobalCat;
			half _RenderNormals;
			half _SpaceRenderFade;
			half _OcclusionCat;
			half _MessageTranslucencyHD;
			half _TranslucencyDirectValue;
			half _SpaceMotionLocals;
			half _TranslucencyShadowValue;
			half _FadeHorizontalValue;
			half _SpaceGlobalLayers;
			half _IsTVEShader;
			half _MessageSizeFade;
			half _TranslucencyAmbientValue;
			half _TranslucencyIntensityValue;
			half _RenderSSR;
			half _RenderDecals;
			half _TranslucencyScatteringValue;
			half _TranslucencyNormalValue;
			half _MessageMotionVariation;
			half _VertexVariationMode;
			half _MessageGlobalsVariation;
			half _MainCat;
			half _VertexRollingMode;
			half _Cutoff;
			half _NoiseCat;
			half _EmissiveFlagMode;
			half _HasOcclusion;
			half _LayerReactValue;
			half _RenderClip;
			half _FadeVerticalValue;
			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _MainTex;
			half TVE_Enabled;
			sampler2D _BumpMap;
			half4 TVE_MotionParams;
			TEXTURE2D_ARRAY(TVE_MotionTex);
			half4 TVE_MotionCoords;
			SAMPLER(samplerTVE_MotionTex);
			float TVE_MotionUsage[10];
			half4 TVE_MotionParamsMin;
			half4 TVE_MotionParamsMax;
			sampler2D TVE_NoiseTex;
			half4 TVE_NoiseParams;
			half4 TVE_VertexParams;
			TEXTURE2D_ARRAY(TVE_VertexTex);
			half4 TVE_VertexCoords;
			SAMPLER(samplerTVE_VertexTex);
			float TVE_VertexUsage[10];
			half _DisableSRPBatcher;
			sampler3D TVE_ScreenTex3D;
			half TVE_ScreenTexCoord;
			sampler2D _MainAlbedoTex;


			
			float3 _LightDirection;
			float3 _LightPosition;

			VertexOutput VertexFunction( VertexInput v )
			{
				VertexOutput o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				float3 VertexPosition3588_g55655 = v.vertex.xyz;
				half3 Mesh_PivotsOS2291_g55655 = half3(0,0,0);
				float3 temp_output_2283_0_g55655 = ( VertexPosition3588_g55655 - Mesh_PivotsOS2291_g55655 );
				half3 VertexPos40_g62634 = temp_output_2283_0_g55655;
				float3 appendResult74_g62634 = (float3(VertexPos40_g62634.x , 0.0 , 0.0));
				half3 VertexPosRotationAxis50_g62634 = appendResult74_g62634;
				float3 break84_g62634 = VertexPos40_g62634;
				float3 appendResult81_g62634 = (float3(0.0 , break84_g62634.y , break84_g62634.z));
				half3 VertexPosOtherAxis82_g62634 = appendResult81_g62634;
				float4 temp_output_91_19_g62645 = TVE_MotionCoords;
				float4x4 break19_g62677 = GetObjectToWorldMatrix();
				float3 appendResult20_g62677 = (float3(break19_g62677[ 0 ][ 3 ] , break19_g62677[ 1 ][ 3 ] , break19_g62677[ 2 ][ 3 ]));
				half3 ObjectData20_g62678 = appendResult20_g62677;
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				half3 WorldData19_g62678 = ase_worldPos;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62678 = WorldData19_g62678;
				#else
				float3 staticSwitch14_g62678 = ObjectData20_g62678;
				#endif
				float3 temp_output_114_0_g62677 = staticSwitch14_g62678;
				float3 vertexToFrag4224_g55655 = temp_output_114_0_g62677;
				half3 ObjectData20_g62665 = vertexToFrag4224_g55655;
				float3 vertexToFrag3890_g55655 = ase_worldPos;
				half3 WorldData19_g62665 = vertexToFrag3890_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62665 = WorldData19_g62665;
				#else
				float3 staticSwitch14_g62665 = ObjectData20_g62665;
				#endif
				float3 ObjectPosition4223_g55655 = staticSwitch14_g62665;
				float3 Position83_g62645 = ObjectPosition4223_g55655;
				float temp_output_84_0_g62645 = _LayerMotionValue;
				float4 lerpResult87_g62645 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, samplerTVE_MotionTex, ( (temp_output_91_19_g62645).zw + ( (temp_output_91_19_g62645).xy * (Position83_g62645).xz ) ),temp_output_84_0_g62645, 0.0 ) , TVE_MotionUsage[(int)temp_output_84_0_g62645]);
				half4 Global_Motion_Params3909_g55655 = lerpResult87_g62645;
				float4 break322_g62615 = Global_Motion_Params3909_g55655;
				float3 appendResult397_g62615 = (float3(break322_g62615.x , 0.0 , break322_g62615.y));
				float3 temp_output_398_0_g62615 = (appendResult397_g62615*2.0 + -1.0);
				float3 ase_parentObjectScale = ( 1.0 / float3( length( GetWorldToObjectMatrix()[ 0 ].xyz ), length( GetWorldToObjectMatrix()[ 1 ].xyz ), length( GetWorldToObjectMatrix()[ 2 ].xyz ) ) );
				half2 Global_MotionDirectionOS39_g55655 = (( mul( GetWorldToObjectMatrix(), float4( temp_output_398_0_g62615 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half ObjectData20_g62639 = 3.14;
				float Bounds_Height374_g55655 = _MaxBoundsInfo.y;
				half WorldData19_g62639 = ( Bounds_Height374_g55655 * 3.14 );
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62639 = WorldData19_g62639;
				#else
				float staticSwitch14_g62639 = ObjectData20_g62639;
				#endif
				float Motion_Max_Bending1133_g55655 = staticSwitch14_g62639;
				half Mesh_Motion_1082_g55655 = v.ase_texcoord3.x;
				half Motion_10_Mask4617_g55655 = ( _MotionAmplitude_10 * Motion_Max_Bending1133_g55655 * Mesh_Motion_1082_g55655 );
				half Input_Speed62_g62605 = _MotionSpeed_10;
				float mulTime373_g62605 = _TimeParameters.x * Input_Speed62_g62605;
				float3 break111_g62621 = ObjectPosition4223_g55655;
				float Mesh_Variation16_g55655 = v.ase_color.r;
				half VertexDynamicMode4798_g55655 = _VertexDynamicMode;
				float lerpResult4795_g55655 = lerp( frac( ( v.ase_color.r + ( break111_g62621.x + break111_g62621.z ) ) ) , Mesh_Variation16_g55655 , VertexDynamicMode4798_g55655);
				half ObjectData20_g62614 = lerpResult4795_g55655;
				half WorldData19_g62614 = Mesh_Variation16_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62614 = WorldData19_g62614;
				#else
				float staticSwitch14_g62614 = ObjectData20_g62614;
				#endif
				half Motion_Variation3073_g55655 = staticSwitch14_g62614;
				half Motion_10_Variation4581_g55655 = ( _MotionVariation_10 * Motion_Variation3073_g55655 );
				half Motion_Variation284_g62605 = Motion_10_Variation4581_g55655;
				float Motion_Scale287_g62605 = ( _MotionScale_10 * ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z ) );
				half Sine_MinusOneToOne281_g62605 = sin( ( mulTime373_g62605 + Motion_Variation284_g62605 + Motion_Scale287_g62605 ) );
				half Input_WindSquash419_g62605 = 0.2;
				half Wind_Power369_g62615 = break322_g62615.z;
				float lerpResult376_g62615 = lerp( TVE_MotionParamsMin.x , TVE_MotionParamsMax.x , Wind_Power369_g62615);
				half Wind_Stop420_g62615 = saturate( ( Wind_Power369_g62615 * 10.0 ) );
				half Global_MotionPower_103106_g55655 = ( lerpResult376_g62615 * Wind_Stop420_g62615 );
				half Input_WindPower327_g62605 = Global_MotionPower_103106_g55655;
				float lerpResult321_g62605 = lerp( Sine_MinusOneToOne281_g62605 , (Sine_MinusOneToOne281_g62605*Input_WindSquash419_g62605 + 1.0) , Input_WindPower327_g62605);
				half Motion_10_SinWaveAm4570_g55655 = lerpResult321_g62605;
				float2 panner437_g62615 = ( _TimeParameters.x * (TVE_NoiseParams).xy + ( (ObjectPosition4223_g55655).xz * TVE_NoiseParams.z ));
				float saferPower446_g62615 = abs( abs( tex2Dlod( TVE_NoiseTex, float4( panner437_g62615, 0, 0.0) ).r ) );
				float lerpResult448_g62615 = lerp( TVE_MotionParamsMin.w , TVE_MotionParamsMax.w , Wind_Power369_g62615);
				half Global_MotionNoise34_g55655 = pow( saferPower446_g62615 , lerpResult448_g62615 );
				half Motion_10_Bending2258_g55655 = ( Motion_10_Mask4617_g55655 * Motion_10_SinWaveAm4570_g55655 * Global_MotionPower_103106_g55655 * Global_MotionNoise34_g55655 );
				half Interaction_Amplitude4137_g55655 = _InteractionAmplitude;
				float lerpResult4494_g55655 = lerp( 1.0 , Mesh_Motion_1082_g55655 , _InteractionMaskValue);
				half ObjectData20_g62620 = lerpResult4494_g55655;
				half WorldData19_g62620 = Mesh_Motion_1082_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62620 = WorldData19_g62620;
				#else
				float staticSwitch14_g62620 = ObjectData20_g62620;
				#endif
				half Motion_10_Interaction53_g55655 = ( Interaction_Amplitude4137_g55655 * Motion_Max_Bending1133_g55655 * staticSwitch14_g62620 );
				half Global_InteractionMask66_g55655 = ( break322_g62615.w * break322_g62615.w );
				float lerpResult4685_g55655 = lerp( Motion_10_Bending2258_g55655 , Motion_10_Interaction53_g55655 , saturate( ( Global_InteractionMask66_g55655 * Interaction_Amplitude4137_g55655 ) ));
				float2 break4603_g55655 = ( Global_MotionDirectionOS39_g55655 * lerpResult4685_g55655 );
				half Vertex_ZAxisRotatin190_g55655 = break4603_g55655.y;
				half Angle44_g62634 = Vertex_ZAxisRotatin190_g55655;
				half3 VertexPos40_g62631 = ( VertexPosRotationAxis50_g62634 + ( VertexPosOtherAxis82_g62634 * cos( Angle44_g62634 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g62634 ) * sin( Angle44_g62634 ) ) );
				float3 appendResult74_g62631 = (float3(0.0 , 0.0 , VertexPos40_g62631.z));
				half3 VertexPosRotationAxis50_g62631 = appendResult74_g62631;
				float3 break84_g62631 = VertexPos40_g62631;
				float3 appendResult81_g62631 = (float3(break84_g62631.x , break84_g62631.y , 0.0));
				half3 VertexPosOtherAxis82_g62631 = appendResult81_g62631;
				half Vertex_XAxisRotation216_g55655 = break4603_g55655.x;
				half Angle44_g62631 = -Vertex_XAxisRotation216_g55655;
				float3 Vertex_Motion_Object833_g55655 = ( VertexPosRotationAxis50_g62631 + ( VertexPosOtherAxis82_g62631 * cos( Angle44_g62631 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g62631 ) * sin( Angle44_g62631 ) ) );
				float3 temp_output_3474_0_g55655 = ( VertexPosition3588_g55655 - Mesh_PivotsOS2291_g55655 );
				float3 appendResult2043_g55655 = (float3(Vertex_XAxisRotation216_g55655 , 0.0 , Vertex_ZAxisRotatin190_g55655));
				float3 Vertex_Motion_World1118_g55655 = ( temp_output_3474_0_g55655 + appendResult2043_g55655 );
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch3312_g55655 = Vertex_Motion_World1118_g55655;
				#else
				float3 staticSwitch3312_g55655 = ( Vertex_Motion_Object833_g55655 + ( 0.0 * _VertexDataMode ) );
				#endif
				float4 temp_output_94_19_g62640 = TVE_VertexCoords;
				float3 Position83_g62640 = ObjectPosition4223_g55655;
				float temp_output_84_0_g62640 = _LayerVertexValue;
				float4 lerpResult87_g62640 = lerp( TVE_VertexParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, samplerTVE_VertexTex, ( (temp_output_94_19_g62640).zw + ( (temp_output_94_19_g62640).xy * (Position83_g62640).xz ) ),temp_output_84_0_g62640, 0.0 ) , TVE_VertexUsage[(int)temp_output_84_0_g62640]);
				half4 Global_Object_Params4173_g55655 = lerpResult87_g62640;
				half Global_VertexSize174_g55655 = Global_Object_Params4173_g55655.w;
				float lerpResult16_g62663 = lerp( 0.0 , _GlobalSize , TVE_Enabled);
				float lerpResult346_g55655 = lerp( 1.0 , Global_VertexSize174_g55655 , lerpResult16_g62663);
				float3 appendResult3480_g55655 = (float3(lerpResult346_g55655 , lerpResult346_g55655 , lerpResult346_g55655));
				half3 ObjectData20_g62676 = appendResult3480_g55655;
				half3 _Vector11 = half3(1,1,1);
				half3 WorldData19_g62676 = _Vector11;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62676 = WorldData19_g62676;
				#else
				float3 staticSwitch14_g62676 = ObjectData20_g62676;
				#endif
				half3 Vertex_Size1741_g55655 = staticSwitch14_g62676;
				half3 _Vector5 = half3(1,1,1);
				float3 Vertex_SizeFade1740_g55655 = _Vector5;
				half3 Grass_Perspective2661_g55655 = half3(0,0,0);
				float3 Final_VertexPosition890_g55655 = ( ( ( staticSwitch3312_g55655 * Vertex_Size1741_g55655 * Vertex_SizeFade1740_g55655 ) + Mesh_PivotsOS2291_g55655 + Grass_Perspective2661_g55655 ) + _DisableSRPBatcher );
				
				o.ase_texcoord2.xyz = vertexToFrag3890_g55655;
				float2 vertexToFrag11_g62604 = ( ( v.ase_texcoord.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord3.xy = vertexToFrag11_g62604;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord2.w = 0;
				o.ase_texcoord3.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = Final_VertexPosition890_g55655;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif
				float3 normalWS = TransformObjectToWorldDir(v.ase_normal);


			#if _CASTING_PUNCTUAL_LIGHT_SHADOW
				float3 lightDirectionWS = normalize(_LightPosition - positionWS);
			#else
				float3 lightDirectionWS = _LightDirection;
			#endif

				float4 clipPos = TransformWorldToHClip(ApplyShadowBias(positionWS, normalWS, lightDirectionWS));
			
			#if UNITY_REVERSED_Z
				clipPos.z = min(clipPos.z, UNITY_NEAR_CLIP_VALUE);
			#else
				clipPos.z = max(clipPos.z, UNITY_NEAR_CLIP_VALUE);
			#endif


				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = clipPos;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				o.clipPos = clipPos;
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE)
				#define ASE_SV_DEPTH SV_DepthLessEqual  
			#else
				#define ASE_SV_DEPTH SV_Depth
			#endif

			half4 frag(	VertexOutput IN 
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						 ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );
				
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float localCustomAlphaClip3735_g55655 = ( 0.0 );
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 normalizeResult2169_g55655 = normalize( ase_worldViewDir );
				float3 ViewDir_Normalized3963_g55655 = normalizeResult2169_g55655;
				float3 normalizeResult3971_g55655 = normalize( cross( ddy( WorldPosition ) , ddx( WorldPosition ) ) );
				float3 NormalsWS_Derivates3972_g55655 = normalizeResult3971_g55655;
				float dotResult2161_g55655 = dot( ViewDir_Normalized3963_g55655 , NormalsWS_Derivates3972_g55655 );
				float dotResult2212_g55655 = dot( ViewDir_Normalized3963_g55655 , float3(0,1,0) );
				half Mask_HView2656_g55655 = dotResult2212_g55655;
				float lerpResult2221_g55655 = lerp( _FadeHorizontalValue , _FadeVerticalValue , Mask_HView2656_g55655);
				float lerpResult3992_g55655 = lerp( 1.0 , saturate( abs( dotResult2161_g55655 ) ) , lerpResult2221_g55655);
				half Fade_Billboard2175_g55655 = lerpResult3992_g55655;
				float temp_output_41_0_g62674 = ( 1.0 * Fade_Billboard2175_g55655 );
				float3 vertexToFrag3890_g55655 = IN.ase_texcoord2.xyz;
				float3 WorldPosition3905_g55655 = vertexToFrag3890_g55655;
				half Final_AlphaFade3727_g55655 = saturate( ( temp_output_41_0_g62674 + ( temp_output_41_0_g62674 * tex3D( TVE_ScreenTex3D, ( TVE_ScreenTexCoord * WorldPosition3905_g55655 ) ).r ) ) );
				float2 vertexToFrag11_g62604 = IN.ase_texcoord3.xy;
				half2 Main_UVs15_g55655 = vertexToFrag11_g62604;
				float4 tex2DNode29_g55655 = tex2D( _MainAlbedoTex, Main_UVs15_g55655 );
				float Main_Alpha316_g55655 = ( _MainColor.a * tex2DNode29_g55655.a );
				half AlphaTreshold2132_g55655 = _Cutoff;
				#ifdef TVE_ALPHA_CLIP
				float staticSwitch3792_g55655 = ( Main_Alpha316_g55655 - ( AlphaTreshold2132_g55655 - 0.5 ) );
				#else
				float staticSwitch3792_g55655 = Main_Alpha316_g55655;
				#endif
				half Final_Alpha3754_g55655 = staticSwitch3792_g55655;
				float temp_output_661_0_g55655 = ( Final_AlphaFade3727_g55655 * Final_Alpha3754_g55655 );
				float Alpha3735_g55655 = temp_output_661_0_g55655;
				float Treshold3735_g55655 = 0.5;
				{
				#if TVE_ALPHA_CLIP
				clip(Alpha3735_g55655 - Treshold3735_g55655);
				#endif
				}
				half Final_Clip914_g55655 = saturate( Alpha3735_g55655 );
				
				float Alpha = Final_Clip914_g55655;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;
				#ifdef ASE_DEPTH_WRITE_ON
				float DepthValue = 0;
				#endif

				#ifdef _ALPHATEST_ON
					#ifdef _ALPHATEST_SHADOW_ON
						clip(Alpha - AlphaClipThresholdShadow);
					#else
						clip(Alpha - AlphaClipThreshold);
					#endif
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif
				return 0;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			ZWrite On
			ColorMask 0
			AlphaToMask Off

			HLSLPROGRAM
			
			#define _SPECULAR_SETUP 1
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#pragma multi_compile _ DOTS_INSTANCING_ON
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 120100

			
			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_DEPTHONLY
        
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#pragma shader_feature_local TVE_ALPHA_CLIP
			#pragma shader_feature_local TVE_VERTEX_DATA_BATCHED
			//TVE Shader Type Defines
			#define TVE_IS_VEGETATION_SHADER
			//TVE Pipeline Defines
			#define THE_VEGETATION_ENGINE
			#define TVE_IS_UNIVERSAL_PIPELINE
			//TVE Injection Defines
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _GradientMaskRemap;
			half4 _SubsurfaceColor;
			half4 _ColorsMaskRemap;
			half4 _VertexOcclusionRemap;
			float4 _NoiseMaskRemap;
			half4 _OverlayMaskRemap;
			half4 _SubsurfaceMaskRemap;
			float4 _Color;
			half4 _AlphaMaskRemap;
			half4 _NoiseColorTwo;
			half4 _GradientColorTwo;
			half4 _GradientColorOne;
			float4 _SubsurfaceDiffusion_asset;
			float4 _EmissiveIntensityParams;
			half4 _EmissiveUVs;
			half4 _DetailBlendRemap;
			float4 _MaxBoundsInfo;
			half4 _MainUVs;
			half4 _LeavesMaskRemap;
			half4 _MainColor;
			float4 _SubsurfaceDiffusion_Asset;
			half4 _NoiseColorOne;
			half4 _EmissiveColor;
			half3 _render_normals_options;
			half _GradientMaxValue;
			half _InteractionMaskValue;
			half _GlobalSize;
			half _LayerVertexValue;
			half _VertexDataMode;
			half _InteractionAmplitude;
			float _MotionScale_10;
			half _VertexDynamicMode;
			half _MotionVariation_10;
			float _MotionSpeed_10;
			half _MotionAmplitude_10;
			half _LayerMotionValue;
			half _render_zw;
			half _IsStandardShader;
			half _GradientMinValue;
			half _render_src;
			half _ColorsPositionMode;
			half _NoiseMinValue;
			half _MainOcclusionValue;
			half _GlobalWetness;
			half _MainSmoothnessValue;
			half _RenderSpecular;
			half _GlobalEmissive;
			half _MainNormalValue;
			half _OverlayMaskMaxValue;
			half _OverlayMaskMinValue;
			half _LayerExtrasValue;
			half _ExtrasPositionMode;
			half _NoiseScaleValue;
			half _GlobalOverlay;
			half _MainLightAngleValue;
			half _SubsurfaceMaskMaxValue;
			half _SubsurfaceMaskMinValue;
			half _SubsurfaceValue;
			half _ColorsMaskMaxValue;
			half _ColorsMaskMinValue;
			half _GlobalColors;
			half _LayerColorsValue;
			half _IsCrossShader;
			half _NoiseMaxValue;
			half _MainLightScatteringValue;
			half _SpaceMotionHighlight;
			half _SpaceGlobalPosition;
			half _DetailTypeMode;
			half _RenderPriority;
			half _RenderZWrite;
			half _HasGradient;
			float _SubsurfaceDiffusion;
			half _IsVersion;
			half _MotionCat;
			half _DetailBlendMode;
			half _SpaceRenderReceive;
			half _RenderCull;
			half _HasEmissive;
			half _VertexMasksMode;
			half _SizeFadeCat;
			half _SubsurfaceCat;
			half _PerspectiveCat;
			half _DetailCat;
			half _RenderingCat;
			half _RenderMode;
			half _GradientCat;
			half _DetailMode;
			half _EmissiveCat;
			half _RenderQueue;
			half _render_dst;
			half _render_cull;
			half _GlobalCat;
			half _RenderNormals;
			half _SpaceRenderFade;
			half _OcclusionCat;
			half _MessageTranslucencyHD;
			half _TranslucencyDirectValue;
			half _SpaceMotionLocals;
			half _TranslucencyShadowValue;
			half _FadeHorizontalValue;
			half _SpaceGlobalLayers;
			half _IsTVEShader;
			half _MessageSizeFade;
			half _TranslucencyAmbientValue;
			half _TranslucencyIntensityValue;
			half _RenderSSR;
			half _RenderDecals;
			half _TranslucencyScatteringValue;
			half _TranslucencyNormalValue;
			half _MessageMotionVariation;
			half _VertexVariationMode;
			half _MessageGlobalsVariation;
			half _MainCat;
			half _VertexRollingMode;
			half _Cutoff;
			half _NoiseCat;
			half _EmissiveFlagMode;
			half _HasOcclusion;
			half _LayerReactValue;
			half _RenderClip;
			half _FadeVerticalValue;
			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _MainTex;
			half TVE_Enabled;
			sampler2D _BumpMap;
			half4 TVE_MotionParams;
			TEXTURE2D_ARRAY(TVE_MotionTex);
			half4 TVE_MotionCoords;
			SAMPLER(samplerTVE_MotionTex);
			float TVE_MotionUsage[10];
			half4 TVE_MotionParamsMin;
			half4 TVE_MotionParamsMax;
			sampler2D TVE_NoiseTex;
			half4 TVE_NoiseParams;
			half4 TVE_VertexParams;
			TEXTURE2D_ARRAY(TVE_VertexTex);
			half4 TVE_VertexCoords;
			SAMPLER(samplerTVE_VertexTex);
			float TVE_VertexUsage[10];
			half _DisableSRPBatcher;
			sampler3D TVE_ScreenTex3D;
			half TVE_ScreenTexCoord;
			sampler2D _MainAlbedoTex;


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float3 VertexPosition3588_g55655 = v.vertex.xyz;
				half3 Mesh_PivotsOS2291_g55655 = half3(0,0,0);
				float3 temp_output_2283_0_g55655 = ( VertexPosition3588_g55655 - Mesh_PivotsOS2291_g55655 );
				half3 VertexPos40_g62634 = temp_output_2283_0_g55655;
				float3 appendResult74_g62634 = (float3(VertexPos40_g62634.x , 0.0 , 0.0));
				half3 VertexPosRotationAxis50_g62634 = appendResult74_g62634;
				float3 break84_g62634 = VertexPos40_g62634;
				float3 appendResult81_g62634 = (float3(0.0 , break84_g62634.y , break84_g62634.z));
				half3 VertexPosOtherAxis82_g62634 = appendResult81_g62634;
				float4 temp_output_91_19_g62645 = TVE_MotionCoords;
				float4x4 break19_g62677 = GetObjectToWorldMatrix();
				float3 appendResult20_g62677 = (float3(break19_g62677[ 0 ][ 3 ] , break19_g62677[ 1 ][ 3 ] , break19_g62677[ 2 ][ 3 ]));
				half3 ObjectData20_g62678 = appendResult20_g62677;
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				half3 WorldData19_g62678 = ase_worldPos;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62678 = WorldData19_g62678;
				#else
				float3 staticSwitch14_g62678 = ObjectData20_g62678;
				#endif
				float3 temp_output_114_0_g62677 = staticSwitch14_g62678;
				float3 vertexToFrag4224_g55655 = temp_output_114_0_g62677;
				half3 ObjectData20_g62665 = vertexToFrag4224_g55655;
				float3 vertexToFrag3890_g55655 = ase_worldPos;
				half3 WorldData19_g62665 = vertexToFrag3890_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62665 = WorldData19_g62665;
				#else
				float3 staticSwitch14_g62665 = ObjectData20_g62665;
				#endif
				float3 ObjectPosition4223_g55655 = staticSwitch14_g62665;
				float3 Position83_g62645 = ObjectPosition4223_g55655;
				float temp_output_84_0_g62645 = _LayerMotionValue;
				float4 lerpResult87_g62645 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, samplerTVE_MotionTex, ( (temp_output_91_19_g62645).zw + ( (temp_output_91_19_g62645).xy * (Position83_g62645).xz ) ),temp_output_84_0_g62645, 0.0 ) , TVE_MotionUsage[(int)temp_output_84_0_g62645]);
				half4 Global_Motion_Params3909_g55655 = lerpResult87_g62645;
				float4 break322_g62615 = Global_Motion_Params3909_g55655;
				float3 appendResult397_g62615 = (float3(break322_g62615.x , 0.0 , break322_g62615.y));
				float3 temp_output_398_0_g62615 = (appendResult397_g62615*2.0 + -1.0);
				float3 ase_parentObjectScale = ( 1.0 / float3( length( GetWorldToObjectMatrix()[ 0 ].xyz ), length( GetWorldToObjectMatrix()[ 1 ].xyz ), length( GetWorldToObjectMatrix()[ 2 ].xyz ) ) );
				half2 Global_MotionDirectionOS39_g55655 = (( mul( GetWorldToObjectMatrix(), float4( temp_output_398_0_g62615 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half ObjectData20_g62639 = 3.14;
				float Bounds_Height374_g55655 = _MaxBoundsInfo.y;
				half WorldData19_g62639 = ( Bounds_Height374_g55655 * 3.14 );
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62639 = WorldData19_g62639;
				#else
				float staticSwitch14_g62639 = ObjectData20_g62639;
				#endif
				float Motion_Max_Bending1133_g55655 = staticSwitch14_g62639;
				half Mesh_Motion_1082_g55655 = v.ase_texcoord3.x;
				half Motion_10_Mask4617_g55655 = ( _MotionAmplitude_10 * Motion_Max_Bending1133_g55655 * Mesh_Motion_1082_g55655 );
				half Input_Speed62_g62605 = _MotionSpeed_10;
				float mulTime373_g62605 = _TimeParameters.x * Input_Speed62_g62605;
				float3 break111_g62621 = ObjectPosition4223_g55655;
				float Mesh_Variation16_g55655 = v.ase_color.r;
				half VertexDynamicMode4798_g55655 = _VertexDynamicMode;
				float lerpResult4795_g55655 = lerp( frac( ( v.ase_color.r + ( break111_g62621.x + break111_g62621.z ) ) ) , Mesh_Variation16_g55655 , VertexDynamicMode4798_g55655);
				half ObjectData20_g62614 = lerpResult4795_g55655;
				half WorldData19_g62614 = Mesh_Variation16_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62614 = WorldData19_g62614;
				#else
				float staticSwitch14_g62614 = ObjectData20_g62614;
				#endif
				half Motion_Variation3073_g55655 = staticSwitch14_g62614;
				half Motion_10_Variation4581_g55655 = ( _MotionVariation_10 * Motion_Variation3073_g55655 );
				half Motion_Variation284_g62605 = Motion_10_Variation4581_g55655;
				float Motion_Scale287_g62605 = ( _MotionScale_10 * ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z ) );
				half Sine_MinusOneToOne281_g62605 = sin( ( mulTime373_g62605 + Motion_Variation284_g62605 + Motion_Scale287_g62605 ) );
				half Input_WindSquash419_g62605 = 0.2;
				half Wind_Power369_g62615 = break322_g62615.z;
				float lerpResult376_g62615 = lerp( TVE_MotionParamsMin.x , TVE_MotionParamsMax.x , Wind_Power369_g62615);
				half Wind_Stop420_g62615 = saturate( ( Wind_Power369_g62615 * 10.0 ) );
				half Global_MotionPower_103106_g55655 = ( lerpResult376_g62615 * Wind_Stop420_g62615 );
				half Input_WindPower327_g62605 = Global_MotionPower_103106_g55655;
				float lerpResult321_g62605 = lerp( Sine_MinusOneToOne281_g62605 , (Sine_MinusOneToOne281_g62605*Input_WindSquash419_g62605 + 1.0) , Input_WindPower327_g62605);
				half Motion_10_SinWaveAm4570_g55655 = lerpResult321_g62605;
				float2 panner437_g62615 = ( _TimeParameters.x * (TVE_NoiseParams).xy + ( (ObjectPosition4223_g55655).xz * TVE_NoiseParams.z ));
				float saferPower446_g62615 = abs( abs( tex2Dlod( TVE_NoiseTex, float4( panner437_g62615, 0, 0.0) ).r ) );
				float lerpResult448_g62615 = lerp( TVE_MotionParamsMin.w , TVE_MotionParamsMax.w , Wind_Power369_g62615);
				half Global_MotionNoise34_g55655 = pow( saferPower446_g62615 , lerpResult448_g62615 );
				half Motion_10_Bending2258_g55655 = ( Motion_10_Mask4617_g55655 * Motion_10_SinWaveAm4570_g55655 * Global_MotionPower_103106_g55655 * Global_MotionNoise34_g55655 );
				half Interaction_Amplitude4137_g55655 = _InteractionAmplitude;
				float lerpResult4494_g55655 = lerp( 1.0 , Mesh_Motion_1082_g55655 , _InteractionMaskValue);
				half ObjectData20_g62620 = lerpResult4494_g55655;
				half WorldData19_g62620 = Mesh_Motion_1082_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62620 = WorldData19_g62620;
				#else
				float staticSwitch14_g62620 = ObjectData20_g62620;
				#endif
				half Motion_10_Interaction53_g55655 = ( Interaction_Amplitude4137_g55655 * Motion_Max_Bending1133_g55655 * staticSwitch14_g62620 );
				half Global_InteractionMask66_g55655 = ( break322_g62615.w * break322_g62615.w );
				float lerpResult4685_g55655 = lerp( Motion_10_Bending2258_g55655 , Motion_10_Interaction53_g55655 , saturate( ( Global_InteractionMask66_g55655 * Interaction_Amplitude4137_g55655 ) ));
				float2 break4603_g55655 = ( Global_MotionDirectionOS39_g55655 * lerpResult4685_g55655 );
				half Vertex_ZAxisRotatin190_g55655 = break4603_g55655.y;
				half Angle44_g62634 = Vertex_ZAxisRotatin190_g55655;
				half3 VertexPos40_g62631 = ( VertexPosRotationAxis50_g62634 + ( VertexPosOtherAxis82_g62634 * cos( Angle44_g62634 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g62634 ) * sin( Angle44_g62634 ) ) );
				float3 appendResult74_g62631 = (float3(0.0 , 0.0 , VertexPos40_g62631.z));
				half3 VertexPosRotationAxis50_g62631 = appendResult74_g62631;
				float3 break84_g62631 = VertexPos40_g62631;
				float3 appendResult81_g62631 = (float3(break84_g62631.x , break84_g62631.y , 0.0));
				half3 VertexPosOtherAxis82_g62631 = appendResult81_g62631;
				half Vertex_XAxisRotation216_g55655 = break4603_g55655.x;
				half Angle44_g62631 = -Vertex_XAxisRotation216_g55655;
				float3 Vertex_Motion_Object833_g55655 = ( VertexPosRotationAxis50_g62631 + ( VertexPosOtherAxis82_g62631 * cos( Angle44_g62631 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g62631 ) * sin( Angle44_g62631 ) ) );
				float3 temp_output_3474_0_g55655 = ( VertexPosition3588_g55655 - Mesh_PivotsOS2291_g55655 );
				float3 appendResult2043_g55655 = (float3(Vertex_XAxisRotation216_g55655 , 0.0 , Vertex_ZAxisRotatin190_g55655));
				float3 Vertex_Motion_World1118_g55655 = ( temp_output_3474_0_g55655 + appendResult2043_g55655 );
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch3312_g55655 = Vertex_Motion_World1118_g55655;
				#else
				float3 staticSwitch3312_g55655 = ( Vertex_Motion_Object833_g55655 + ( 0.0 * _VertexDataMode ) );
				#endif
				float4 temp_output_94_19_g62640 = TVE_VertexCoords;
				float3 Position83_g62640 = ObjectPosition4223_g55655;
				float temp_output_84_0_g62640 = _LayerVertexValue;
				float4 lerpResult87_g62640 = lerp( TVE_VertexParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, samplerTVE_VertexTex, ( (temp_output_94_19_g62640).zw + ( (temp_output_94_19_g62640).xy * (Position83_g62640).xz ) ),temp_output_84_0_g62640, 0.0 ) , TVE_VertexUsage[(int)temp_output_84_0_g62640]);
				half4 Global_Object_Params4173_g55655 = lerpResult87_g62640;
				half Global_VertexSize174_g55655 = Global_Object_Params4173_g55655.w;
				float lerpResult16_g62663 = lerp( 0.0 , _GlobalSize , TVE_Enabled);
				float lerpResult346_g55655 = lerp( 1.0 , Global_VertexSize174_g55655 , lerpResult16_g62663);
				float3 appendResult3480_g55655 = (float3(lerpResult346_g55655 , lerpResult346_g55655 , lerpResult346_g55655));
				half3 ObjectData20_g62676 = appendResult3480_g55655;
				half3 _Vector11 = half3(1,1,1);
				half3 WorldData19_g62676 = _Vector11;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62676 = WorldData19_g62676;
				#else
				float3 staticSwitch14_g62676 = ObjectData20_g62676;
				#endif
				half3 Vertex_Size1741_g55655 = staticSwitch14_g62676;
				half3 _Vector5 = half3(1,1,1);
				float3 Vertex_SizeFade1740_g55655 = _Vector5;
				half3 Grass_Perspective2661_g55655 = half3(0,0,0);
				float3 Final_VertexPosition890_g55655 = ( ( ( staticSwitch3312_g55655 * Vertex_Size1741_g55655 * Vertex_SizeFade1740_g55655 ) + Mesh_PivotsOS2291_g55655 + Grass_Perspective2661_g55655 ) + _DisableSRPBatcher );
				
				o.ase_texcoord2.xyz = vertexToFrag3890_g55655;
				float2 vertexToFrag11_g62604 = ( ( v.ase_texcoord.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord3.xy = vertexToFrag11_g62604;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord2.w = 0;
				o.ase_texcoord3.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = Final_VertexPosition890_g55655;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;
				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float4 positionCS = TransformWorldToHClip( positionWS );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				o.clipPos = positionCS;
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE)
				#define ASE_SV_DEPTH SV_DepthLessEqual  
			#else
				#define ASE_SV_DEPTH SV_Depth
			#endif
			half4 frag(	VertexOutput IN 
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						 ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float localCustomAlphaClip3735_g55655 = ( 0.0 );
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 normalizeResult2169_g55655 = normalize( ase_worldViewDir );
				float3 ViewDir_Normalized3963_g55655 = normalizeResult2169_g55655;
				float3 normalizeResult3971_g55655 = normalize( cross( ddy( WorldPosition ) , ddx( WorldPosition ) ) );
				float3 NormalsWS_Derivates3972_g55655 = normalizeResult3971_g55655;
				float dotResult2161_g55655 = dot( ViewDir_Normalized3963_g55655 , NormalsWS_Derivates3972_g55655 );
				float dotResult2212_g55655 = dot( ViewDir_Normalized3963_g55655 , float3(0,1,0) );
				half Mask_HView2656_g55655 = dotResult2212_g55655;
				float lerpResult2221_g55655 = lerp( _FadeHorizontalValue , _FadeVerticalValue , Mask_HView2656_g55655);
				float lerpResult3992_g55655 = lerp( 1.0 , saturate( abs( dotResult2161_g55655 ) ) , lerpResult2221_g55655);
				half Fade_Billboard2175_g55655 = lerpResult3992_g55655;
				float temp_output_41_0_g62674 = ( 1.0 * Fade_Billboard2175_g55655 );
				float3 vertexToFrag3890_g55655 = IN.ase_texcoord2.xyz;
				float3 WorldPosition3905_g55655 = vertexToFrag3890_g55655;
				half Final_AlphaFade3727_g55655 = saturate( ( temp_output_41_0_g62674 + ( temp_output_41_0_g62674 * tex3D( TVE_ScreenTex3D, ( TVE_ScreenTexCoord * WorldPosition3905_g55655 ) ).r ) ) );
				float2 vertexToFrag11_g62604 = IN.ase_texcoord3.xy;
				half2 Main_UVs15_g55655 = vertexToFrag11_g62604;
				float4 tex2DNode29_g55655 = tex2D( _MainAlbedoTex, Main_UVs15_g55655 );
				float Main_Alpha316_g55655 = ( _MainColor.a * tex2DNode29_g55655.a );
				half AlphaTreshold2132_g55655 = _Cutoff;
				#ifdef TVE_ALPHA_CLIP
				float staticSwitch3792_g55655 = ( Main_Alpha316_g55655 - ( AlphaTreshold2132_g55655 - 0.5 ) );
				#else
				float staticSwitch3792_g55655 = Main_Alpha316_g55655;
				#endif
				half Final_Alpha3754_g55655 = staticSwitch3792_g55655;
				float temp_output_661_0_g55655 = ( Final_AlphaFade3727_g55655 * Final_Alpha3754_g55655 );
				float Alpha3735_g55655 = temp_output_661_0_g55655;
				float Treshold3735_g55655 = 0.5;
				{
				#if TVE_ALPHA_CLIP
				clip(Alpha3735_g55655 - Treshold3735_g55655);
				#endif
				}
				half Final_Clip914_g55655 = saturate( Alpha3735_g55655 );
				
				float Alpha = Final_Clip914_g55655;
				float AlphaClipThreshold = 0.5;
				#ifdef ASE_DEPTH_WRITE_ON
				float DepthValue = 0;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif
				#ifdef ASE_DEPTH_WRITE_ON
				outputDepth = DepthValue;
				#endif

				return 0;
			}
			ENDHLSL
		}
		
		
		Pass
		{
			
			Name "Meta"
			Tags { "LightMode"="Meta" }

			Cull Off

			HLSLPROGRAM
			
			#define _SPECULAR_SETUP 1
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#pragma multi_compile _ DOTS_INSTANCING_ON
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 120100

			
			#pragma vertex vert
			#pragma fragment frag

			#pragma shader_feature EDITOR_VISUALIZATION

			#define SHADERPASS SHADERPASS_META

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#pragma shader_feature_local TVE_ALPHA_CLIP
			#pragma shader_feature_local TVE_VERTEX_DATA_BATCHED
			//TVE Shader Type Defines
			#define TVE_IS_VEGETATION_SHADER
			//TVE Pipeline Defines
			#define THE_VEGETATION_ENGINE
			#define TVE_IS_UNIVERSAL_PIPELINE
			//TVE Injection Defines
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 texcoord0 : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				#ifdef EDITOR_VISUALIZATION
				float4 VizUV : TEXCOORD2;
				float4 LightCoord : TEXCOORD3;
				#endif
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _GradientMaskRemap;
			half4 _SubsurfaceColor;
			half4 _ColorsMaskRemap;
			half4 _VertexOcclusionRemap;
			float4 _NoiseMaskRemap;
			half4 _OverlayMaskRemap;
			half4 _SubsurfaceMaskRemap;
			float4 _Color;
			half4 _AlphaMaskRemap;
			half4 _NoiseColorTwo;
			half4 _GradientColorTwo;
			half4 _GradientColorOne;
			float4 _SubsurfaceDiffusion_asset;
			float4 _EmissiveIntensityParams;
			half4 _EmissiveUVs;
			half4 _DetailBlendRemap;
			float4 _MaxBoundsInfo;
			half4 _MainUVs;
			half4 _LeavesMaskRemap;
			half4 _MainColor;
			float4 _SubsurfaceDiffusion_Asset;
			half4 _NoiseColorOne;
			half4 _EmissiveColor;
			half3 _render_normals_options;
			half _GradientMaxValue;
			half _InteractionMaskValue;
			half _GlobalSize;
			half _LayerVertexValue;
			half _VertexDataMode;
			half _InteractionAmplitude;
			float _MotionScale_10;
			half _VertexDynamicMode;
			half _MotionVariation_10;
			float _MotionSpeed_10;
			half _MotionAmplitude_10;
			half _LayerMotionValue;
			half _render_zw;
			half _IsStandardShader;
			half _GradientMinValue;
			half _render_src;
			half _ColorsPositionMode;
			half _NoiseMinValue;
			half _MainOcclusionValue;
			half _GlobalWetness;
			half _MainSmoothnessValue;
			half _RenderSpecular;
			half _GlobalEmissive;
			half _MainNormalValue;
			half _OverlayMaskMaxValue;
			half _OverlayMaskMinValue;
			half _LayerExtrasValue;
			half _ExtrasPositionMode;
			half _NoiseScaleValue;
			half _GlobalOverlay;
			half _MainLightAngleValue;
			half _SubsurfaceMaskMaxValue;
			half _SubsurfaceMaskMinValue;
			half _SubsurfaceValue;
			half _ColorsMaskMaxValue;
			half _ColorsMaskMinValue;
			half _GlobalColors;
			half _LayerColorsValue;
			half _IsCrossShader;
			half _NoiseMaxValue;
			half _MainLightScatteringValue;
			half _SpaceMotionHighlight;
			half _SpaceGlobalPosition;
			half _DetailTypeMode;
			half _RenderPriority;
			half _RenderZWrite;
			half _HasGradient;
			float _SubsurfaceDiffusion;
			half _IsVersion;
			half _MotionCat;
			half _DetailBlendMode;
			half _SpaceRenderReceive;
			half _RenderCull;
			half _HasEmissive;
			half _VertexMasksMode;
			half _SizeFadeCat;
			half _SubsurfaceCat;
			half _PerspectiveCat;
			half _DetailCat;
			half _RenderingCat;
			half _RenderMode;
			half _GradientCat;
			half _DetailMode;
			half _EmissiveCat;
			half _RenderQueue;
			half _render_dst;
			half _render_cull;
			half _GlobalCat;
			half _RenderNormals;
			half _SpaceRenderFade;
			half _OcclusionCat;
			half _MessageTranslucencyHD;
			half _TranslucencyDirectValue;
			half _SpaceMotionLocals;
			half _TranslucencyShadowValue;
			half _FadeHorizontalValue;
			half _SpaceGlobalLayers;
			half _IsTVEShader;
			half _MessageSizeFade;
			half _TranslucencyAmbientValue;
			half _TranslucencyIntensityValue;
			half _RenderSSR;
			half _RenderDecals;
			half _TranslucencyScatteringValue;
			half _TranslucencyNormalValue;
			half _MessageMotionVariation;
			half _VertexVariationMode;
			half _MessageGlobalsVariation;
			half _MainCat;
			half _VertexRollingMode;
			half _Cutoff;
			half _NoiseCat;
			half _EmissiveFlagMode;
			half _HasOcclusion;
			half _LayerReactValue;
			half _RenderClip;
			half _FadeVerticalValue;
			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _MainTex;
			half TVE_Enabled;
			sampler2D _BumpMap;
			half4 TVE_MotionParams;
			TEXTURE2D_ARRAY(TVE_MotionTex);
			half4 TVE_MotionCoords;
			SAMPLER(samplerTVE_MotionTex);
			float TVE_MotionUsage[10];
			half4 TVE_MotionParamsMin;
			half4 TVE_MotionParamsMax;
			sampler2D TVE_NoiseTex;
			half4 TVE_NoiseParams;
			half4 TVE_VertexParams;
			TEXTURE2D_ARRAY(TVE_VertexTex);
			half4 TVE_VertexCoords;
			SAMPLER(samplerTVE_VertexTex);
			float TVE_VertexUsage[10];
			half _DisableSRPBatcher;
			sampler3D TVE_WorldTex3D;
			sampler2D _MainAlbedoTex;
			half4 TVE_ColorsParams;
			TEXTURE2D_ARRAY(TVE_ColorsTex);
			half4 TVE_ColorsCoords;
			SAMPLER(samplerTVE_ColorsTex);
			float TVE_ColorsUsage[10];
			sampler2D _MainMaskTex;
			half4 TVE_MainLightParams;
			half3 TVE_MainLightDirection;
			half4 TVE_OverlayColor;
			half4 TVE_ExtrasParams;
			TEXTURE2D_ARRAY(TVE_ExtrasTex);
			half4 TVE_ExtrasCoords;
			SAMPLER(samplerTVE_ExtrasTex);
			float TVE_ExtrasUsage[10];
			sampler2D _EmissiveTex;
			sampler3D TVE_ScreenTex3D;
			half TVE_ScreenTexCoord;


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float3 VertexPosition3588_g55655 = v.vertex.xyz;
				half3 Mesh_PivotsOS2291_g55655 = half3(0,0,0);
				float3 temp_output_2283_0_g55655 = ( VertexPosition3588_g55655 - Mesh_PivotsOS2291_g55655 );
				half3 VertexPos40_g62634 = temp_output_2283_0_g55655;
				float3 appendResult74_g62634 = (float3(VertexPos40_g62634.x , 0.0 , 0.0));
				half3 VertexPosRotationAxis50_g62634 = appendResult74_g62634;
				float3 break84_g62634 = VertexPos40_g62634;
				float3 appendResult81_g62634 = (float3(0.0 , break84_g62634.y , break84_g62634.z));
				half3 VertexPosOtherAxis82_g62634 = appendResult81_g62634;
				float4 temp_output_91_19_g62645 = TVE_MotionCoords;
				float4x4 break19_g62677 = GetObjectToWorldMatrix();
				float3 appendResult20_g62677 = (float3(break19_g62677[ 0 ][ 3 ] , break19_g62677[ 1 ][ 3 ] , break19_g62677[ 2 ][ 3 ]));
				half3 ObjectData20_g62678 = appendResult20_g62677;
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				half3 WorldData19_g62678 = ase_worldPos;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62678 = WorldData19_g62678;
				#else
				float3 staticSwitch14_g62678 = ObjectData20_g62678;
				#endif
				float3 temp_output_114_0_g62677 = staticSwitch14_g62678;
				float3 vertexToFrag4224_g55655 = temp_output_114_0_g62677;
				half3 ObjectData20_g62665 = vertexToFrag4224_g55655;
				float3 vertexToFrag3890_g55655 = ase_worldPos;
				half3 WorldData19_g62665 = vertexToFrag3890_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62665 = WorldData19_g62665;
				#else
				float3 staticSwitch14_g62665 = ObjectData20_g62665;
				#endif
				float3 ObjectPosition4223_g55655 = staticSwitch14_g62665;
				float3 Position83_g62645 = ObjectPosition4223_g55655;
				float temp_output_84_0_g62645 = _LayerMotionValue;
				float4 lerpResult87_g62645 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, samplerTVE_MotionTex, ( (temp_output_91_19_g62645).zw + ( (temp_output_91_19_g62645).xy * (Position83_g62645).xz ) ),temp_output_84_0_g62645, 0.0 ) , TVE_MotionUsage[(int)temp_output_84_0_g62645]);
				half4 Global_Motion_Params3909_g55655 = lerpResult87_g62645;
				float4 break322_g62615 = Global_Motion_Params3909_g55655;
				float3 appendResult397_g62615 = (float3(break322_g62615.x , 0.0 , break322_g62615.y));
				float3 temp_output_398_0_g62615 = (appendResult397_g62615*2.0 + -1.0);
				float3 ase_parentObjectScale = ( 1.0 / float3( length( GetWorldToObjectMatrix()[ 0 ].xyz ), length( GetWorldToObjectMatrix()[ 1 ].xyz ), length( GetWorldToObjectMatrix()[ 2 ].xyz ) ) );
				half2 Global_MotionDirectionOS39_g55655 = (( mul( GetWorldToObjectMatrix(), float4( temp_output_398_0_g62615 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half ObjectData20_g62639 = 3.14;
				float Bounds_Height374_g55655 = _MaxBoundsInfo.y;
				half WorldData19_g62639 = ( Bounds_Height374_g55655 * 3.14 );
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62639 = WorldData19_g62639;
				#else
				float staticSwitch14_g62639 = ObjectData20_g62639;
				#endif
				float Motion_Max_Bending1133_g55655 = staticSwitch14_g62639;
				half Mesh_Motion_1082_g55655 = v.ase_texcoord3.x;
				half Motion_10_Mask4617_g55655 = ( _MotionAmplitude_10 * Motion_Max_Bending1133_g55655 * Mesh_Motion_1082_g55655 );
				half Input_Speed62_g62605 = _MotionSpeed_10;
				float mulTime373_g62605 = _TimeParameters.x * Input_Speed62_g62605;
				float3 break111_g62621 = ObjectPosition4223_g55655;
				float Mesh_Variation16_g55655 = v.ase_color.r;
				half VertexDynamicMode4798_g55655 = _VertexDynamicMode;
				float lerpResult4795_g55655 = lerp( frac( ( v.ase_color.r + ( break111_g62621.x + break111_g62621.z ) ) ) , Mesh_Variation16_g55655 , VertexDynamicMode4798_g55655);
				half ObjectData20_g62614 = lerpResult4795_g55655;
				half WorldData19_g62614 = Mesh_Variation16_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62614 = WorldData19_g62614;
				#else
				float staticSwitch14_g62614 = ObjectData20_g62614;
				#endif
				half Motion_Variation3073_g55655 = staticSwitch14_g62614;
				half Motion_10_Variation4581_g55655 = ( _MotionVariation_10 * Motion_Variation3073_g55655 );
				half Motion_Variation284_g62605 = Motion_10_Variation4581_g55655;
				float Motion_Scale287_g62605 = ( _MotionScale_10 * ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z ) );
				half Sine_MinusOneToOne281_g62605 = sin( ( mulTime373_g62605 + Motion_Variation284_g62605 + Motion_Scale287_g62605 ) );
				half Input_WindSquash419_g62605 = 0.2;
				half Wind_Power369_g62615 = break322_g62615.z;
				float lerpResult376_g62615 = lerp( TVE_MotionParamsMin.x , TVE_MotionParamsMax.x , Wind_Power369_g62615);
				half Wind_Stop420_g62615 = saturate( ( Wind_Power369_g62615 * 10.0 ) );
				half Global_MotionPower_103106_g55655 = ( lerpResult376_g62615 * Wind_Stop420_g62615 );
				half Input_WindPower327_g62605 = Global_MotionPower_103106_g55655;
				float lerpResult321_g62605 = lerp( Sine_MinusOneToOne281_g62605 , (Sine_MinusOneToOne281_g62605*Input_WindSquash419_g62605 + 1.0) , Input_WindPower327_g62605);
				half Motion_10_SinWaveAm4570_g55655 = lerpResult321_g62605;
				float2 panner437_g62615 = ( _TimeParameters.x * (TVE_NoiseParams).xy + ( (ObjectPosition4223_g55655).xz * TVE_NoiseParams.z ));
				float saferPower446_g62615 = abs( abs( tex2Dlod( TVE_NoiseTex, float4( panner437_g62615, 0, 0.0) ).r ) );
				float lerpResult448_g62615 = lerp( TVE_MotionParamsMin.w , TVE_MotionParamsMax.w , Wind_Power369_g62615);
				half Global_MotionNoise34_g55655 = pow( saferPower446_g62615 , lerpResult448_g62615 );
				half Motion_10_Bending2258_g55655 = ( Motion_10_Mask4617_g55655 * Motion_10_SinWaveAm4570_g55655 * Global_MotionPower_103106_g55655 * Global_MotionNoise34_g55655 );
				half Interaction_Amplitude4137_g55655 = _InteractionAmplitude;
				float lerpResult4494_g55655 = lerp( 1.0 , Mesh_Motion_1082_g55655 , _InteractionMaskValue);
				half ObjectData20_g62620 = lerpResult4494_g55655;
				half WorldData19_g62620 = Mesh_Motion_1082_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62620 = WorldData19_g62620;
				#else
				float staticSwitch14_g62620 = ObjectData20_g62620;
				#endif
				half Motion_10_Interaction53_g55655 = ( Interaction_Amplitude4137_g55655 * Motion_Max_Bending1133_g55655 * staticSwitch14_g62620 );
				half Global_InteractionMask66_g55655 = ( break322_g62615.w * break322_g62615.w );
				float lerpResult4685_g55655 = lerp( Motion_10_Bending2258_g55655 , Motion_10_Interaction53_g55655 , saturate( ( Global_InteractionMask66_g55655 * Interaction_Amplitude4137_g55655 ) ));
				float2 break4603_g55655 = ( Global_MotionDirectionOS39_g55655 * lerpResult4685_g55655 );
				half Vertex_ZAxisRotatin190_g55655 = break4603_g55655.y;
				half Angle44_g62634 = Vertex_ZAxisRotatin190_g55655;
				half3 VertexPos40_g62631 = ( VertexPosRotationAxis50_g62634 + ( VertexPosOtherAxis82_g62634 * cos( Angle44_g62634 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g62634 ) * sin( Angle44_g62634 ) ) );
				float3 appendResult74_g62631 = (float3(0.0 , 0.0 , VertexPos40_g62631.z));
				half3 VertexPosRotationAxis50_g62631 = appendResult74_g62631;
				float3 break84_g62631 = VertexPos40_g62631;
				float3 appendResult81_g62631 = (float3(break84_g62631.x , break84_g62631.y , 0.0));
				half3 VertexPosOtherAxis82_g62631 = appendResult81_g62631;
				half Vertex_XAxisRotation216_g55655 = break4603_g55655.x;
				half Angle44_g62631 = -Vertex_XAxisRotation216_g55655;
				float3 Vertex_Motion_Object833_g55655 = ( VertexPosRotationAxis50_g62631 + ( VertexPosOtherAxis82_g62631 * cos( Angle44_g62631 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g62631 ) * sin( Angle44_g62631 ) ) );
				float3 temp_output_3474_0_g55655 = ( VertexPosition3588_g55655 - Mesh_PivotsOS2291_g55655 );
				float3 appendResult2043_g55655 = (float3(Vertex_XAxisRotation216_g55655 , 0.0 , Vertex_ZAxisRotatin190_g55655));
				float3 Vertex_Motion_World1118_g55655 = ( temp_output_3474_0_g55655 + appendResult2043_g55655 );
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch3312_g55655 = Vertex_Motion_World1118_g55655;
				#else
				float3 staticSwitch3312_g55655 = ( Vertex_Motion_Object833_g55655 + ( 0.0 * _VertexDataMode ) );
				#endif
				float4 temp_output_94_19_g62640 = TVE_VertexCoords;
				float3 Position83_g62640 = ObjectPosition4223_g55655;
				float temp_output_84_0_g62640 = _LayerVertexValue;
				float4 lerpResult87_g62640 = lerp( TVE_VertexParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, samplerTVE_VertexTex, ( (temp_output_94_19_g62640).zw + ( (temp_output_94_19_g62640).xy * (Position83_g62640).xz ) ),temp_output_84_0_g62640, 0.0 ) , TVE_VertexUsage[(int)temp_output_84_0_g62640]);
				half4 Global_Object_Params4173_g55655 = lerpResult87_g62640;
				half Global_VertexSize174_g55655 = Global_Object_Params4173_g55655.w;
				float lerpResult16_g62663 = lerp( 0.0 , _GlobalSize , TVE_Enabled);
				float lerpResult346_g55655 = lerp( 1.0 , Global_VertexSize174_g55655 , lerpResult16_g62663);
				float3 appendResult3480_g55655 = (float3(lerpResult346_g55655 , lerpResult346_g55655 , lerpResult346_g55655));
				half3 ObjectData20_g62676 = appendResult3480_g55655;
				half3 _Vector11 = half3(1,1,1);
				half3 WorldData19_g62676 = _Vector11;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62676 = WorldData19_g62676;
				#else
				float3 staticSwitch14_g62676 = ObjectData20_g62676;
				#endif
				half3 Vertex_Size1741_g55655 = staticSwitch14_g62676;
				half3 _Vector5 = half3(1,1,1);
				float3 Vertex_SizeFade1740_g55655 = _Vector5;
				half3 Grass_Perspective2661_g55655 = half3(0,0,0);
				float3 Final_VertexPosition890_g55655 = ( ( ( staticSwitch3312_g55655 * Vertex_Size1741_g55655 * Vertex_SizeFade1740_g55655 ) + Mesh_PivotsOS2291_g55655 + Grass_Perspective2661_g55655 ) + _DisableSRPBatcher );
				
				half Mesh_Height1524_g55655 = v.ase_color.a;
				float temp_output_7_0_g62660 = _GradientMinValue;
				half Gradient_Tint2784_g55655 = saturate( ( ( Mesh_Height1524_g55655 - temp_output_7_0_g62660 ) / ( _GradientMaxValue - temp_output_7_0_g62660 ) ) );
				float vertexToFrag11_g62658 = Gradient_Tint2784_g55655;
				o.ase_texcoord4.x = vertexToFrag11_g62658;
				float3 temp_cast_8 = (_NoiseScaleValue).xxx;
				float3 WorldPosition3905_g55655 = vertexToFrag3890_g55655;
				float temp_output_7_0_g62667 = _NoiseMinValue;
				half Noise_Tint2802_g55655 = saturate( ( ( tex3Dlod( TVE_WorldTex3D, float4( ( temp_cast_8 * WorldPosition3905_g55655 * 0.1 ), 0.0) ).r - temp_output_7_0_g62667 ) / ( _NoiseMaxValue - temp_output_7_0_g62667 ) ) );
				float vertexToFrag11_g62662 = Noise_Tint2802_g55655;
				o.ase_texcoord4.y = vertexToFrag11_g62662;
				float2 vertexToFrag11_g62604 = ( ( v.texcoord0.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord4.zw = vertexToFrag11_g62604;
				o.ase_texcoord5.xyz = vertexToFrag3890_g55655;
				o.ase_texcoord6.xyz = vertexToFrag4224_g55655;
				
				float2 vertexToFrag11_g62644 = ( ( v.texcoord0.xy * (_EmissiveUVs).xy ) + (_EmissiveUVs).zw );
				o.ase_texcoord7.xy = vertexToFrag11_g62644;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord5.w = 0;
				o.ase_texcoord6.w = 0;
				o.ase_texcoord7.zw = 0;
				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = Final_VertexPosition890_g55655;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif

				o.clipPos = MetaVertexPosition( v.vertex, v.texcoord1.xy, v.texcoord1.xy, unity_LightmapST, unity_DynamicLightmapST );

			#ifdef EDITOR_VISUALIZATION
				float2 VizUV = 0;
				float4 LightCoord = 0;
				UnityEditorVizData(v.vertex.xyz, v.texcoord0.xy, v.texcoord1.xy, v.texcoord2.xy, VizUV, LightCoord);
				o.VizUV = float4(VizUV, 0, 0);
				o.LightCoord = LightCoord;
			#endif

			#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				VertexPositionInputs vertexInput = (VertexPositionInputs)0;
				vertexInput.positionWS = positionWS;
				vertexInput.positionCS = o.clipPos;
				o.shadowCoord = GetShadowCoord( vertexInput );
			#endif
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 texcoord0 : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.texcoord0 = v.texcoord0;
				o.texcoord1 = v.texcoord1;
				o.texcoord2 = v.texcoord2;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.texcoord0 = patch[0].texcoord0 * bary.x + patch[1].texcoord0 * bary.y + patch[2].texcoord0 * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float vertexToFrag11_g62658 = IN.ase_texcoord4.x;
				float3 lerpResult2779_g55655 = lerp( (_GradientColorTwo).rgb , (_GradientColorOne).rgb , vertexToFrag11_g62658);
				float vertexToFrag11_g62662 = IN.ase_texcoord4.y;
				float3 lerpResult2800_g55655 = lerp( (_NoiseColorTwo).rgb , (_NoiseColorOne).rgb , vertexToFrag11_g62662);
				half Leaves_Mask4511_g55655 = 1.0;
				float3 lerpResult4521_g55655 = lerp( float3( 1,1,1 ) , ( lerpResult2779_g55655 * lerpResult2800_g55655 * float3(1,1,1) ) , Leaves_Mask4511_g55655);
				float3 lerpResult4519_g55655 = lerp( float3( 1,1,1 ) , (_MainColor).rgb , Leaves_Mask4511_g55655);
				float2 vertexToFrag11_g62604 = IN.ase_texcoord4.zw;
				half2 Main_UVs15_g55655 = vertexToFrag11_g62604;
				float4 tex2DNode29_g55655 = tex2D( _MainAlbedoTex, Main_UVs15_g55655 );
				half3 Main_Albedo99_g55655 = ( lerpResult4519_g55655 * (tex2DNode29_g55655).rgb );
				half3 Blend_Albedo265_g55655 = Main_Albedo99_g55655;
				half3 Blend_AlbedoTinted2808_g55655 = ( lerpResult4521_g55655 * Blend_Albedo265_g55655 );
				float dotResult3616_g55655 = dot( Blend_AlbedoTinted2808_g55655 , float3(0.2126,0.7152,0.0722) );
				float3 temp_cast_0 = (dotResult3616_g55655).xxx;
				float4 temp_output_91_19_g62668 = TVE_ColorsCoords;
				float3 vertexToFrag3890_g55655 = IN.ase_texcoord5.xyz;
				float3 WorldPosition3905_g55655 = vertexToFrag3890_g55655;
				float3 vertexToFrag4224_g55655 = IN.ase_texcoord6.xyz;
				half3 ObjectData20_g62665 = vertexToFrag4224_g55655;
				half3 WorldData19_g62665 = vertexToFrag3890_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62665 = WorldData19_g62665;
				#else
				float3 staticSwitch14_g62665 = ObjectData20_g62665;
				#endif
				float3 ObjectPosition4223_g55655 = staticSwitch14_g62665;
				float3 lerpResult4822_g55655 = lerp( WorldPosition3905_g55655 , ObjectPosition4223_g55655 , _ColorsPositionMode);
				float3 Position58_g62668 = lerpResult4822_g55655;
				float temp_output_82_0_g62668 = _LayerColorsValue;
				float4 lerpResult88_g62668 = lerp( TVE_ColorsParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ColorsTex, samplerTVE_ColorsTex, ( (temp_output_91_19_g62668).zw + ( (temp_output_91_19_g62668).xy * (Position58_g62668).xz ) ),temp_output_82_0_g62668 ) , TVE_ColorsUsage[(int)temp_output_82_0_g62668]);
				half Global_ColorsTex_A1701_g55655 = (lerpResult88_g62668).a;
				half Global_Colors_Influence3668_g55655 = saturate( Global_ColorsTex_A1701_g55655 );
				float3 lerpResult3618_g55655 = lerp( Blend_AlbedoTinted2808_g55655 , temp_cast_0 , Global_Colors_Influence3668_g55655);
				half3 Global_ColorsTex_RGB1700_g55655 = (lerpResult88_g62668).rgb;
				#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch1_g62681 = 2.0;
				#else
				float staticSwitch1_g62681 = 4.594794;
				#endif
				half3 Global_Colors1954_g55655 = ( Global_ColorsTex_RGB1700_g55655 * staticSwitch1_g62681 );
				half Global_Colors_Value3650_g55655 = _GlobalColors;
				float4 tex2DNode35_g55655 = tex2D( _MainMaskTex, Main_UVs15_g55655 );
				half Main_Mask57_g55655 = tex2DNode35_g55655.b;
				float temp_output_7_0_g62654 = _ColorsMaskMinValue;
				half Global_Colors_Mask3692_g55655 = saturate( ( ( Main_Mask57_g55655 - temp_output_7_0_g62654 ) / ( _ColorsMaskMaxValue - temp_output_7_0_g62654 ) ) );
				float lerpResult16_g62624 = lerp( 0.0 , ( Global_Colors_Value3650_g55655 * Global_Colors_Mask3692_g55655 ) , TVE_Enabled);
				float3 lerpResult3628_g55655 = lerp( Blend_AlbedoTinted2808_g55655 , ( lerpResult3618_g55655 * Global_Colors1954_g55655 ) , lerpResult16_g62624);
				half3 Blend_AlbedoColored863_g55655 = lerpResult3628_g55655;
				float3 temp_output_799_0_g55655 = (_SubsurfaceColor).rgb;
				float dotResult3930_g55655 = dot( temp_output_799_0_g55655 , float3(0.2126,0.7152,0.0722) );
				float3 temp_cast_3 = (dotResult3930_g55655).xxx;
				float3 lerpResult3932_g55655 = lerp( temp_output_799_0_g55655 , temp_cast_3 , Global_Colors_Influence3668_g55655);
				float3 lerpResult3942_g55655 = lerp( temp_output_799_0_g55655 , ( lerpResult3932_g55655 * Global_Colors1954_g55655 ) , ( Global_Colors_Value3650_g55655 * Global_Colors_Mask3692_g55655 ));
				half3 Subsurface_Color1722_g55655 = lerpResult3942_g55655;
				half MainLight_Subsurface4041_g55655 = TVE_MainLightParams.a;
				half Subsurface_Intensity1752_g55655 = ( _SubsurfaceValue * MainLight_Subsurface4041_g55655 );
				float temp_output_7_0_g62675 = _SubsurfaceMaskMinValue;
				half Subsurface_Mask1557_g55655 = saturate( ( ( Main_Mask57_g55655 - temp_output_7_0_g62675 ) / ( _SubsurfaceMaskMaxValue - temp_output_7_0_g62675 ) ) );
				half3 Subsurface_Transmission884_g55655 = ( Subsurface_Color1722_g55655 * Subsurface_Intensity1752_g55655 * Subsurface_Mask1557_g55655 );
				half3 MainLight_Direction3926_g55655 = TVE_MainLightDirection;
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 normalizeResult2169_g55655 = normalize( ase_worldViewDir );
				float3 ViewDir_Normalized3963_g55655 = normalizeResult2169_g55655;
				float dotResult785_g55655 = dot( -MainLight_Direction3926_g55655 , ViewDir_Normalized3963_g55655 );
				float saferPower1624_g55655 = abs( (dotResult785_g55655*0.5 + 0.5) );
				#ifdef UNITY_PASS_FORWARDADD
				float staticSwitch1602_g55655 = 0.0;
				#else
				float staticSwitch1602_g55655 = ( pow( saferPower1624_g55655 , _MainLightAngleValue ) * _MainLightScatteringValue );
				#endif
				half Mask_Subsurface_View782_g55655 = staticSwitch1602_g55655;
				half3 Subsurface_Scattering1693_g55655 = ( Subsurface_Transmission884_g55655 * Blend_AlbedoColored863_g55655 * Mask_Subsurface_View782_g55655 );
				half3 Blend_AlbedoAndSubsurface149_g55655 = ( Blend_AlbedoColored863_g55655 + Subsurface_Scattering1693_g55655 );
				half3 Global_OverlayColor1758_g55655 = (TVE_OverlayColor).rgb;
				half Main_AlbedoTex_G3526_g55655 = tex2DNode29_g55655.g;
				float4 temp_output_93_19_g62635 = TVE_ExtrasCoords;
				float3 lerpResult4827_g55655 = lerp( WorldPosition3905_g55655 , ObjectPosition4223_g55655 , _ExtrasPositionMode);
				float3 Position82_g62635 = lerpResult4827_g55655;
				float temp_output_84_0_g62635 = _LayerExtrasValue;
				float4 lerpResult88_g62635 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ExtrasTex, samplerTVE_ExtrasTex, ( (temp_output_93_19_g62635).zw + ( (temp_output_93_19_g62635).xy * (Position82_g62635).xz ) ),temp_output_84_0_g62635 ) , TVE_ExtrasUsage[(int)temp_output_84_0_g62635]);
				float4 break89_g62635 = lerpResult88_g62635;
				half Global_Extras_Overlay156_g55655 = break89_g62635.b;
				half Overlay_Variation4560_g55655 = 1.0;
				half Overlay_Commons1365_g55655 = ( _GlobalOverlay * Global_Extras_Overlay156_g55655 * Overlay_Variation4560_g55655 );
				float temp_output_7_0_g62666 = _OverlayMaskMinValue;
				half Overlay_Mask269_g55655 = saturate( ( ( ( ( 0.5 + Main_AlbedoTex_G3526_g55655 ) * Overlay_Commons1365_g55655 ) - temp_output_7_0_g62666 ) / ( _OverlayMaskMaxValue - temp_output_7_0_g62666 ) ) );
				float3 lerpResult336_g55655 = lerp( Blend_AlbedoAndSubsurface149_g55655 , Global_OverlayColor1758_g55655 , Overlay_Mask269_g55655);
				half3 Final_Albedo359_g55655 = lerpResult336_g55655;
				
				float4 temp_output_4214_0_g55655 = ( _EmissiveColor * _EmissiveIntensityParams.x );
				float2 vertexToFrag11_g62644 = IN.ase_texcoord7.xy;
				half2 Emissive_UVs2468_g55655 = vertexToFrag11_g62644;
				half Global_Extras_Emissive4203_g55655 = break89_g62635.r;
				float lerpResult4206_g55655 = lerp( 1.0 , Global_Extras_Emissive4203_g55655 , _GlobalEmissive);
				half3 Final_Emissive2476_g55655 = ( (( temp_output_4214_0_g55655 * tex2D( _EmissiveTex, Emissive_UVs2468_g55655 ) )).rgb * lerpResult4206_g55655 );
				
				float localCustomAlphaClip3735_g55655 = ( 0.0 );
				float3 normalizeResult3971_g55655 = normalize( cross( ddy( WorldPosition ) , ddx( WorldPosition ) ) );
				float3 NormalsWS_Derivates3972_g55655 = normalizeResult3971_g55655;
				float dotResult2161_g55655 = dot( ViewDir_Normalized3963_g55655 , NormalsWS_Derivates3972_g55655 );
				float dotResult2212_g55655 = dot( ViewDir_Normalized3963_g55655 , float3(0,1,0) );
				half Mask_HView2656_g55655 = dotResult2212_g55655;
				float lerpResult2221_g55655 = lerp( _FadeHorizontalValue , _FadeVerticalValue , Mask_HView2656_g55655);
				float lerpResult3992_g55655 = lerp( 1.0 , saturate( abs( dotResult2161_g55655 ) ) , lerpResult2221_g55655);
				half Fade_Billboard2175_g55655 = lerpResult3992_g55655;
				float temp_output_41_0_g62674 = ( 1.0 * Fade_Billboard2175_g55655 );
				half Final_AlphaFade3727_g55655 = saturate( ( temp_output_41_0_g62674 + ( temp_output_41_0_g62674 * tex3D( TVE_ScreenTex3D, ( TVE_ScreenTexCoord * WorldPosition3905_g55655 ) ).r ) ) );
				float Main_Alpha316_g55655 = ( _MainColor.a * tex2DNode29_g55655.a );
				half AlphaTreshold2132_g55655 = _Cutoff;
				#ifdef TVE_ALPHA_CLIP
				float staticSwitch3792_g55655 = ( Main_Alpha316_g55655 - ( AlphaTreshold2132_g55655 - 0.5 ) );
				#else
				float staticSwitch3792_g55655 = Main_Alpha316_g55655;
				#endif
				half Final_Alpha3754_g55655 = staticSwitch3792_g55655;
				float temp_output_661_0_g55655 = ( Final_AlphaFade3727_g55655 * Final_Alpha3754_g55655 );
				float Alpha3735_g55655 = temp_output_661_0_g55655;
				float Treshold3735_g55655 = 0.5;
				{
				#if TVE_ALPHA_CLIP
				clip(Alpha3735_g55655 - Treshold3735_g55655);
				#endif
				}
				half Final_Clip914_g55655 = saturate( Alpha3735_g55655 );
				
				
				float3 Albedo = Final_Albedo359_g55655;
				float3 Emission = Final_Emissive2476_g55655;
				float Alpha = Final_Clip914_g55655;
				float AlphaClipThreshold = 0.5;

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				MetaInput metaInput = (MetaInput)0;
				metaInput.Albedo = Albedo;
				metaInput.Emission = Emission;
			#ifdef EDITOR_VISUALIZATION
				metaInput.VizUV = IN.VizUV.xy;
				metaInput.LightCoord = IN.LightCoord;
			#endif
				
				return MetaFragment(metaInput);
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "Universal2D"
			Tags { "LightMode"="Universal2D" }

			Blend [_render_src] [_render_dst], One Zero
			ColorMask RGBA

			HLSLPROGRAM
			
			#define _SPECULAR_SETUP 1
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#pragma multi_compile _ DOTS_INSTANCING_ON
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 120100

			
			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_2D
        
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
			
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#pragma shader_feature_local TVE_ALPHA_CLIP
			#pragma shader_feature_local TVE_VERTEX_DATA_BATCHED
			//TVE Shader Type Defines
			#define TVE_IS_VEGETATION_SHADER
			//TVE Pipeline Defines
			#define THE_VEGETATION_ENGINE
			#define TVE_IS_UNIVERSAL_PIPELINE
			//TVE Injection Defines
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _GradientMaskRemap;
			half4 _SubsurfaceColor;
			half4 _ColorsMaskRemap;
			half4 _VertexOcclusionRemap;
			float4 _NoiseMaskRemap;
			half4 _OverlayMaskRemap;
			half4 _SubsurfaceMaskRemap;
			float4 _Color;
			half4 _AlphaMaskRemap;
			half4 _NoiseColorTwo;
			half4 _GradientColorTwo;
			half4 _GradientColorOne;
			float4 _SubsurfaceDiffusion_asset;
			float4 _EmissiveIntensityParams;
			half4 _EmissiveUVs;
			half4 _DetailBlendRemap;
			float4 _MaxBoundsInfo;
			half4 _MainUVs;
			half4 _LeavesMaskRemap;
			half4 _MainColor;
			float4 _SubsurfaceDiffusion_Asset;
			half4 _NoiseColorOne;
			half4 _EmissiveColor;
			half3 _render_normals_options;
			half _GradientMaxValue;
			half _InteractionMaskValue;
			half _GlobalSize;
			half _LayerVertexValue;
			half _VertexDataMode;
			half _InteractionAmplitude;
			float _MotionScale_10;
			half _VertexDynamicMode;
			half _MotionVariation_10;
			float _MotionSpeed_10;
			half _MotionAmplitude_10;
			half _LayerMotionValue;
			half _render_zw;
			half _IsStandardShader;
			half _GradientMinValue;
			half _render_src;
			half _ColorsPositionMode;
			half _NoiseMinValue;
			half _MainOcclusionValue;
			half _GlobalWetness;
			half _MainSmoothnessValue;
			half _RenderSpecular;
			half _GlobalEmissive;
			half _MainNormalValue;
			half _OverlayMaskMaxValue;
			half _OverlayMaskMinValue;
			half _LayerExtrasValue;
			half _ExtrasPositionMode;
			half _NoiseScaleValue;
			half _GlobalOverlay;
			half _MainLightAngleValue;
			half _SubsurfaceMaskMaxValue;
			half _SubsurfaceMaskMinValue;
			half _SubsurfaceValue;
			half _ColorsMaskMaxValue;
			half _ColorsMaskMinValue;
			half _GlobalColors;
			half _LayerColorsValue;
			half _IsCrossShader;
			half _NoiseMaxValue;
			half _MainLightScatteringValue;
			half _SpaceMotionHighlight;
			half _SpaceGlobalPosition;
			half _DetailTypeMode;
			half _RenderPriority;
			half _RenderZWrite;
			half _HasGradient;
			float _SubsurfaceDiffusion;
			half _IsVersion;
			half _MotionCat;
			half _DetailBlendMode;
			half _SpaceRenderReceive;
			half _RenderCull;
			half _HasEmissive;
			half _VertexMasksMode;
			half _SizeFadeCat;
			half _SubsurfaceCat;
			half _PerspectiveCat;
			half _DetailCat;
			half _RenderingCat;
			half _RenderMode;
			half _GradientCat;
			half _DetailMode;
			half _EmissiveCat;
			half _RenderQueue;
			half _render_dst;
			half _render_cull;
			half _GlobalCat;
			half _RenderNormals;
			half _SpaceRenderFade;
			half _OcclusionCat;
			half _MessageTranslucencyHD;
			half _TranslucencyDirectValue;
			half _SpaceMotionLocals;
			half _TranslucencyShadowValue;
			half _FadeHorizontalValue;
			half _SpaceGlobalLayers;
			half _IsTVEShader;
			half _MessageSizeFade;
			half _TranslucencyAmbientValue;
			half _TranslucencyIntensityValue;
			half _RenderSSR;
			half _RenderDecals;
			half _TranslucencyScatteringValue;
			half _TranslucencyNormalValue;
			half _MessageMotionVariation;
			half _VertexVariationMode;
			half _MessageGlobalsVariation;
			half _MainCat;
			half _VertexRollingMode;
			half _Cutoff;
			half _NoiseCat;
			half _EmissiveFlagMode;
			half _HasOcclusion;
			half _LayerReactValue;
			half _RenderClip;
			half _FadeVerticalValue;
			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _MainTex;
			half TVE_Enabled;
			sampler2D _BumpMap;
			half4 TVE_MotionParams;
			TEXTURE2D_ARRAY(TVE_MotionTex);
			half4 TVE_MotionCoords;
			SAMPLER(samplerTVE_MotionTex);
			float TVE_MotionUsage[10];
			half4 TVE_MotionParamsMin;
			half4 TVE_MotionParamsMax;
			sampler2D TVE_NoiseTex;
			half4 TVE_NoiseParams;
			half4 TVE_VertexParams;
			TEXTURE2D_ARRAY(TVE_VertexTex);
			half4 TVE_VertexCoords;
			SAMPLER(samplerTVE_VertexTex);
			float TVE_VertexUsage[10];
			half _DisableSRPBatcher;
			sampler3D TVE_WorldTex3D;
			sampler2D _MainAlbedoTex;
			half4 TVE_ColorsParams;
			TEXTURE2D_ARRAY(TVE_ColorsTex);
			half4 TVE_ColorsCoords;
			SAMPLER(samplerTVE_ColorsTex);
			float TVE_ColorsUsage[10];
			sampler2D _MainMaskTex;
			half4 TVE_MainLightParams;
			half3 TVE_MainLightDirection;
			half4 TVE_OverlayColor;
			half4 TVE_ExtrasParams;
			TEXTURE2D_ARRAY(TVE_ExtrasTex);
			half4 TVE_ExtrasCoords;
			SAMPLER(samplerTVE_ExtrasTex);
			float TVE_ExtrasUsage[10];
			sampler3D TVE_ScreenTex3D;
			half TVE_ScreenTexCoord;


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				float3 VertexPosition3588_g55655 = v.vertex.xyz;
				half3 Mesh_PivotsOS2291_g55655 = half3(0,0,0);
				float3 temp_output_2283_0_g55655 = ( VertexPosition3588_g55655 - Mesh_PivotsOS2291_g55655 );
				half3 VertexPos40_g62634 = temp_output_2283_0_g55655;
				float3 appendResult74_g62634 = (float3(VertexPos40_g62634.x , 0.0 , 0.0));
				half3 VertexPosRotationAxis50_g62634 = appendResult74_g62634;
				float3 break84_g62634 = VertexPos40_g62634;
				float3 appendResult81_g62634 = (float3(0.0 , break84_g62634.y , break84_g62634.z));
				half3 VertexPosOtherAxis82_g62634 = appendResult81_g62634;
				float4 temp_output_91_19_g62645 = TVE_MotionCoords;
				float4x4 break19_g62677 = GetObjectToWorldMatrix();
				float3 appendResult20_g62677 = (float3(break19_g62677[ 0 ][ 3 ] , break19_g62677[ 1 ][ 3 ] , break19_g62677[ 2 ][ 3 ]));
				half3 ObjectData20_g62678 = appendResult20_g62677;
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				half3 WorldData19_g62678 = ase_worldPos;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62678 = WorldData19_g62678;
				#else
				float3 staticSwitch14_g62678 = ObjectData20_g62678;
				#endif
				float3 temp_output_114_0_g62677 = staticSwitch14_g62678;
				float3 vertexToFrag4224_g55655 = temp_output_114_0_g62677;
				half3 ObjectData20_g62665 = vertexToFrag4224_g55655;
				float3 vertexToFrag3890_g55655 = ase_worldPos;
				half3 WorldData19_g62665 = vertexToFrag3890_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62665 = WorldData19_g62665;
				#else
				float3 staticSwitch14_g62665 = ObjectData20_g62665;
				#endif
				float3 ObjectPosition4223_g55655 = staticSwitch14_g62665;
				float3 Position83_g62645 = ObjectPosition4223_g55655;
				float temp_output_84_0_g62645 = _LayerMotionValue;
				float4 lerpResult87_g62645 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, samplerTVE_MotionTex, ( (temp_output_91_19_g62645).zw + ( (temp_output_91_19_g62645).xy * (Position83_g62645).xz ) ),temp_output_84_0_g62645, 0.0 ) , TVE_MotionUsage[(int)temp_output_84_0_g62645]);
				half4 Global_Motion_Params3909_g55655 = lerpResult87_g62645;
				float4 break322_g62615 = Global_Motion_Params3909_g55655;
				float3 appendResult397_g62615 = (float3(break322_g62615.x , 0.0 , break322_g62615.y));
				float3 temp_output_398_0_g62615 = (appendResult397_g62615*2.0 + -1.0);
				float3 ase_parentObjectScale = ( 1.0 / float3( length( GetWorldToObjectMatrix()[ 0 ].xyz ), length( GetWorldToObjectMatrix()[ 1 ].xyz ), length( GetWorldToObjectMatrix()[ 2 ].xyz ) ) );
				half2 Global_MotionDirectionOS39_g55655 = (( mul( GetWorldToObjectMatrix(), float4( temp_output_398_0_g62615 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half ObjectData20_g62639 = 3.14;
				float Bounds_Height374_g55655 = _MaxBoundsInfo.y;
				half WorldData19_g62639 = ( Bounds_Height374_g55655 * 3.14 );
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62639 = WorldData19_g62639;
				#else
				float staticSwitch14_g62639 = ObjectData20_g62639;
				#endif
				float Motion_Max_Bending1133_g55655 = staticSwitch14_g62639;
				half Mesh_Motion_1082_g55655 = v.ase_texcoord3.x;
				half Motion_10_Mask4617_g55655 = ( _MotionAmplitude_10 * Motion_Max_Bending1133_g55655 * Mesh_Motion_1082_g55655 );
				half Input_Speed62_g62605 = _MotionSpeed_10;
				float mulTime373_g62605 = _TimeParameters.x * Input_Speed62_g62605;
				float3 break111_g62621 = ObjectPosition4223_g55655;
				float Mesh_Variation16_g55655 = v.ase_color.r;
				half VertexDynamicMode4798_g55655 = _VertexDynamicMode;
				float lerpResult4795_g55655 = lerp( frac( ( v.ase_color.r + ( break111_g62621.x + break111_g62621.z ) ) ) , Mesh_Variation16_g55655 , VertexDynamicMode4798_g55655);
				half ObjectData20_g62614 = lerpResult4795_g55655;
				half WorldData19_g62614 = Mesh_Variation16_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62614 = WorldData19_g62614;
				#else
				float staticSwitch14_g62614 = ObjectData20_g62614;
				#endif
				half Motion_Variation3073_g55655 = staticSwitch14_g62614;
				half Motion_10_Variation4581_g55655 = ( _MotionVariation_10 * Motion_Variation3073_g55655 );
				half Motion_Variation284_g62605 = Motion_10_Variation4581_g55655;
				float Motion_Scale287_g62605 = ( _MotionScale_10 * ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z ) );
				half Sine_MinusOneToOne281_g62605 = sin( ( mulTime373_g62605 + Motion_Variation284_g62605 + Motion_Scale287_g62605 ) );
				half Input_WindSquash419_g62605 = 0.2;
				half Wind_Power369_g62615 = break322_g62615.z;
				float lerpResult376_g62615 = lerp( TVE_MotionParamsMin.x , TVE_MotionParamsMax.x , Wind_Power369_g62615);
				half Wind_Stop420_g62615 = saturate( ( Wind_Power369_g62615 * 10.0 ) );
				half Global_MotionPower_103106_g55655 = ( lerpResult376_g62615 * Wind_Stop420_g62615 );
				half Input_WindPower327_g62605 = Global_MotionPower_103106_g55655;
				float lerpResult321_g62605 = lerp( Sine_MinusOneToOne281_g62605 , (Sine_MinusOneToOne281_g62605*Input_WindSquash419_g62605 + 1.0) , Input_WindPower327_g62605);
				half Motion_10_SinWaveAm4570_g55655 = lerpResult321_g62605;
				float2 panner437_g62615 = ( _TimeParameters.x * (TVE_NoiseParams).xy + ( (ObjectPosition4223_g55655).xz * TVE_NoiseParams.z ));
				float saferPower446_g62615 = abs( abs( tex2Dlod( TVE_NoiseTex, float4( panner437_g62615, 0, 0.0) ).r ) );
				float lerpResult448_g62615 = lerp( TVE_MotionParamsMin.w , TVE_MotionParamsMax.w , Wind_Power369_g62615);
				half Global_MotionNoise34_g55655 = pow( saferPower446_g62615 , lerpResult448_g62615 );
				half Motion_10_Bending2258_g55655 = ( Motion_10_Mask4617_g55655 * Motion_10_SinWaveAm4570_g55655 * Global_MotionPower_103106_g55655 * Global_MotionNoise34_g55655 );
				half Interaction_Amplitude4137_g55655 = _InteractionAmplitude;
				float lerpResult4494_g55655 = lerp( 1.0 , Mesh_Motion_1082_g55655 , _InteractionMaskValue);
				half ObjectData20_g62620 = lerpResult4494_g55655;
				half WorldData19_g62620 = Mesh_Motion_1082_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62620 = WorldData19_g62620;
				#else
				float staticSwitch14_g62620 = ObjectData20_g62620;
				#endif
				half Motion_10_Interaction53_g55655 = ( Interaction_Amplitude4137_g55655 * Motion_Max_Bending1133_g55655 * staticSwitch14_g62620 );
				half Global_InteractionMask66_g55655 = ( break322_g62615.w * break322_g62615.w );
				float lerpResult4685_g55655 = lerp( Motion_10_Bending2258_g55655 , Motion_10_Interaction53_g55655 , saturate( ( Global_InteractionMask66_g55655 * Interaction_Amplitude4137_g55655 ) ));
				float2 break4603_g55655 = ( Global_MotionDirectionOS39_g55655 * lerpResult4685_g55655 );
				half Vertex_ZAxisRotatin190_g55655 = break4603_g55655.y;
				half Angle44_g62634 = Vertex_ZAxisRotatin190_g55655;
				half3 VertexPos40_g62631 = ( VertexPosRotationAxis50_g62634 + ( VertexPosOtherAxis82_g62634 * cos( Angle44_g62634 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g62634 ) * sin( Angle44_g62634 ) ) );
				float3 appendResult74_g62631 = (float3(0.0 , 0.0 , VertexPos40_g62631.z));
				half3 VertexPosRotationAxis50_g62631 = appendResult74_g62631;
				float3 break84_g62631 = VertexPos40_g62631;
				float3 appendResult81_g62631 = (float3(break84_g62631.x , break84_g62631.y , 0.0));
				half3 VertexPosOtherAxis82_g62631 = appendResult81_g62631;
				half Vertex_XAxisRotation216_g55655 = break4603_g55655.x;
				half Angle44_g62631 = -Vertex_XAxisRotation216_g55655;
				float3 Vertex_Motion_Object833_g55655 = ( VertexPosRotationAxis50_g62631 + ( VertexPosOtherAxis82_g62631 * cos( Angle44_g62631 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g62631 ) * sin( Angle44_g62631 ) ) );
				float3 temp_output_3474_0_g55655 = ( VertexPosition3588_g55655 - Mesh_PivotsOS2291_g55655 );
				float3 appendResult2043_g55655 = (float3(Vertex_XAxisRotation216_g55655 , 0.0 , Vertex_ZAxisRotatin190_g55655));
				float3 Vertex_Motion_World1118_g55655 = ( temp_output_3474_0_g55655 + appendResult2043_g55655 );
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch3312_g55655 = Vertex_Motion_World1118_g55655;
				#else
				float3 staticSwitch3312_g55655 = ( Vertex_Motion_Object833_g55655 + ( 0.0 * _VertexDataMode ) );
				#endif
				float4 temp_output_94_19_g62640 = TVE_VertexCoords;
				float3 Position83_g62640 = ObjectPosition4223_g55655;
				float temp_output_84_0_g62640 = _LayerVertexValue;
				float4 lerpResult87_g62640 = lerp( TVE_VertexParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, samplerTVE_VertexTex, ( (temp_output_94_19_g62640).zw + ( (temp_output_94_19_g62640).xy * (Position83_g62640).xz ) ),temp_output_84_0_g62640, 0.0 ) , TVE_VertexUsage[(int)temp_output_84_0_g62640]);
				half4 Global_Object_Params4173_g55655 = lerpResult87_g62640;
				half Global_VertexSize174_g55655 = Global_Object_Params4173_g55655.w;
				float lerpResult16_g62663 = lerp( 0.0 , _GlobalSize , TVE_Enabled);
				float lerpResult346_g55655 = lerp( 1.0 , Global_VertexSize174_g55655 , lerpResult16_g62663);
				float3 appendResult3480_g55655 = (float3(lerpResult346_g55655 , lerpResult346_g55655 , lerpResult346_g55655));
				half3 ObjectData20_g62676 = appendResult3480_g55655;
				half3 _Vector11 = half3(1,1,1);
				half3 WorldData19_g62676 = _Vector11;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62676 = WorldData19_g62676;
				#else
				float3 staticSwitch14_g62676 = ObjectData20_g62676;
				#endif
				half3 Vertex_Size1741_g55655 = staticSwitch14_g62676;
				half3 _Vector5 = half3(1,1,1);
				float3 Vertex_SizeFade1740_g55655 = _Vector5;
				half3 Grass_Perspective2661_g55655 = half3(0,0,0);
				float3 Final_VertexPosition890_g55655 = ( ( ( staticSwitch3312_g55655 * Vertex_Size1741_g55655 * Vertex_SizeFade1740_g55655 ) + Mesh_PivotsOS2291_g55655 + Grass_Perspective2661_g55655 ) + _DisableSRPBatcher );
				
				half Mesh_Height1524_g55655 = v.ase_color.a;
				float temp_output_7_0_g62660 = _GradientMinValue;
				half Gradient_Tint2784_g55655 = saturate( ( ( Mesh_Height1524_g55655 - temp_output_7_0_g62660 ) / ( _GradientMaxValue - temp_output_7_0_g62660 ) ) );
				float vertexToFrag11_g62658 = Gradient_Tint2784_g55655;
				o.ase_texcoord2.x = vertexToFrag11_g62658;
				float3 temp_cast_8 = (_NoiseScaleValue).xxx;
				float3 WorldPosition3905_g55655 = vertexToFrag3890_g55655;
				float temp_output_7_0_g62667 = _NoiseMinValue;
				half Noise_Tint2802_g55655 = saturate( ( ( tex3Dlod( TVE_WorldTex3D, float4( ( temp_cast_8 * WorldPosition3905_g55655 * 0.1 ), 0.0) ).r - temp_output_7_0_g62667 ) / ( _NoiseMaxValue - temp_output_7_0_g62667 ) ) );
				float vertexToFrag11_g62662 = Noise_Tint2802_g55655;
				o.ase_texcoord2.y = vertexToFrag11_g62662;
				float2 vertexToFrag11_g62604 = ( ( v.ase_texcoord.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord2.zw = vertexToFrag11_g62604;
				o.ase_texcoord3.xyz = vertexToFrag3890_g55655;
				o.ase_texcoord4.xyz = vertexToFrag4224_g55655;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord3.w = 0;
				o.ase_texcoord4.w = 0;
				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = Final_VertexPosition890_g55655;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float4 positionCS = TransformWorldToHClip( positionWS );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.clipPos = positionCS;
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float vertexToFrag11_g62658 = IN.ase_texcoord2.x;
				float3 lerpResult2779_g55655 = lerp( (_GradientColorTwo).rgb , (_GradientColorOne).rgb , vertexToFrag11_g62658);
				float vertexToFrag11_g62662 = IN.ase_texcoord2.y;
				float3 lerpResult2800_g55655 = lerp( (_NoiseColorTwo).rgb , (_NoiseColorOne).rgb , vertexToFrag11_g62662);
				half Leaves_Mask4511_g55655 = 1.0;
				float3 lerpResult4521_g55655 = lerp( float3( 1,1,1 ) , ( lerpResult2779_g55655 * lerpResult2800_g55655 * float3(1,1,1) ) , Leaves_Mask4511_g55655);
				float3 lerpResult4519_g55655 = lerp( float3( 1,1,1 ) , (_MainColor).rgb , Leaves_Mask4511_g55655);
				float2 vertexToFrag11_g62604 = IN.ase_texcoord2.zw;
				half2 Main_UVs15_g55655 = vertexToFrag11_g62604;
				float4 tex2DNode29_g55655 = tex2D( _MainAlbedoTex, Main_UVs15_g55655 );
				half3 Main_Albedo99_g55655 = ( lerpResult4519_g55655 * (tex2DNode29_g55655).rgb );
				half3 Blend_Albedo265_g55655 = Main_Albedo99_g55655;
				half3 Blend_AlbedoTinted2808_g55655 = ( lerpResult4521_g55655 * Blend_Albedo265_g55655 );
				float dotResult3616_g55655 = dot( Blend_AlbedoTinted2808_g55655 , float3(0.2126,0.7152,0.0722) );
				float3 temp_cast_0 = (dotResult3616_g55655).xxx;
				float4 temp_output_91_19_g62668 = TVE_ColorsCoords;
				float3 vertexToFrag3890_g55655 = IN.ase_texcoord3.xyz;
				float3 WorldPosition3905_g55655 = vertexToFrag3890_g55655;
				float3 vertexToFrag4224_g55655 = IN.ase_texcoord4.xyz;
				half3 ObjectData20_g62665 = vertexToFrag4224_g55655;
				half3 WorldData19_g62665 = vertexToFrag3890_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62665 = WorldData19_g62665;
				#else
				float3 staticSwitch14_g62665 = ObjectData20_g62665;
				#endif
				float3 ObjectPosition4223_g55655 = staticSwitch14_g62665;
				float3 lerpResult4822_g55655 = lerp( WorldPosition3905_g55655 , ObjectPosition4223_g55655 , _ColorsPositionMode);
				float3 Position58_g62668 = lerpResult4822_g55655;
				float temp_output_82_0_g62668 = _LayerColorsValue;
				float4 lerpResult88_g62668 = lerp( TVE_ColorsParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ColorsTex, samplerTVE_ColorsTex, ( (temp_output_91_19_g62668).zw + ( (temp_output_91_19_g62668).xy * (Position58_g62668).xz ) ),temp_output_82_0_g62668 ) , TVE_ColorsUsage[(int)temp_output_82_0_g62668]);
				half Global_ColorsTex_A1701_g55655 = (lerpResult88_g62668).a;
				half Global_Colors_Influence3668_g55655 = saturate( Global_ColorsTex_A1701_g55655 );
				float3 lerpResult3618_g55655 = lerp( Blend_AlbedoTinted2808_g55655 , temp_cast_0 , Global_Colors_Influence3668_g55655);
				half3 Global_ColorsTex_RGB1700_g55655 = (lerpResult88_g62668).rgb;
				#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch1_g62681 = 2.0;
				#else
				float staticSwitch1_g62681 = 4.594794;
				#endif
				half3 Global_Colors1954_g55655 = ( Global_ColorsTex_RGB1700_g55655 * staticSwitch1_g62681 );
				half Global_Colors_Value3650_g55655 = _GlobalColors;
				float4 tex2DNode35_g55655 = tex2D( _MainMaskTex, Main_UVs15_g55655 );
				half Main_Mask57_g55655 = tex2DNode35_g55655.b;
				float temp_output_7_0_g62654 = _ColorsMaskMinValue;
				half Global_Colors_Mask3692_g55655 = saturate( ( ( Main_Mask57_g55655 - temp_output_7_0_g62654 ) / ( _ColorsMaskMaxValue - temp_output_7_0_g62654 ) ) );
				float lerpResult16_g62624 = lerp( 0.0 , ( Global_Colors_Value3650_g55655 * Global_Colors_Mask3692_g55655 ) , TVE_Enabled);
				float3 lerpResult3628_g55655 = lerp( Blend_AlbedoTinted2808_g55655 , ( lerpResult3618_g55655 * Global_Colors1954_g55655 ) , lerpResult16_g62624);
				half3 Blend_AlbedoColored863_g55655 = lerpResult3628_g55655;
				float3 temp_output_799_0_g55655 = (_SubsurfaceColor).rgb;
				float dotResult3930_g55655 = dot( temp_output_799_0_g55655 , float3(0.2126,0.7152,0.0722) );
				float3 temp_cast_3 = (dotResult3930_g55655).xxx;
				float3 lerpResult3932_g55655 = lerp( temp_output_799_0_g55655 , temp_cast_3 , Global_Colors_Influence3668_g55655);
				float3 lerpResult3942_g55655 = lerp( temp_output_799_0_g55655 , ( lerpResult3932_g55655 * Global_Colors1954_g55655 ) , ( Global_Colors_Value3650_g55655 * Global_Colors_Mask3692_g55655 ));
				half3 Subsurface_Color1722_g55655 = lerpResult3942_g55655;
				half MainLight_Subsurface4041_g55655 = TVE_MainLightParams.a;
				half Subsurface_Intensity1752_g55655 = ( _SubsurfaceValue * MainLight_Subsurface4041_g55655 );
				float temp_output_7_0_g62675 = _SubsurfaceMaskMinValue;
				half Subsurface_Mask1557_g55655 = saturate( ( ( Main_Mask57_g55655 - temp_output_7_0_g62675 ) / ( _SubsurfaceMaskMaxValue - temp_output_7_0_g62675 ) ) );
				half3 Subsurface_Transmission884_g55655 = ( Subsurface_Color1722_g55655 * Subsurface_Intensity1752_g55655 * Subsurface_Mask1557_g55655 );
				half3 MainLight_Direction3926_g55655 = TVE_MainLightDirection;
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 normalizeResult2169_g55655 = normalize( ase_worldViewDir );
				float3 ViewDir_Normalized3963_g55655 = normalizeResult2169_g55655;
				float dotResult785_g55655 = dot( -MainLight_Direction3926_g55655 , ViewDir_Normalized3963_g55655 );
				float saferPower1624_g55655 = abs( (dotResult785_g55655*0.5 + 0.5) );
				#ifdef UNITY_PASS_FORWARDADD
				float staticSwitch1602_g55655 = 0.0;
				#else
				float staticSwitch1602_g55655 = ( pow( saferPower1624_g55655 , _MainLightAngleValue ) * _MainLightScatteringValue );
				#endif
				half Mask_Subsurface_View782_g55655 = staticSwitch1602_g55655;
				half3 Subsurface_Scattering1693_g55655 = ( Subsurface_Transmission884_g55655 * Blend_AlbedoColored863_g55655 * Mask_Subsurface_View782_g55655 );
				half3 Blend_AlbedoAndSubsurface149_g55655 = ( Blend_AlbedoColored863_g55655 + Subsurface_Scattering1693_g55655 );
				half3 Global_OverlayColor1758_g55655 = (TVE_OverlayColor).rgb;
				half Main_AlbedoTex_G3526_g55655 = tex2DNode29_g55655.g;
				float4 temp_output_93_19_g62635 = TVE_ExtrasCoords;
				float3 lerpResult4827_g55655 = lerp( WorldPosition3905_g55655 , ObjectPosition4223_g55655 , _ExtrasPositionMode);
				float3 Position82_g62635 = lerpResult4827_g55655;
				float temp_output_84_0_g62635 = _LayerExtrasValue;
				float4 lerpResult88_g62635 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ExtrasTex, samplerTVE_ExtrasTex, ( (temp_output_93_19_g62635).zw + ( (temp_output_93_19_g62635).xy * (Position82_g62635).xz ) ),temp_output_84_0_g62635 ) , TVE_ExtrasUsage[(int)temp_output_84_0_g62635]);
				float4 break89_g62635 = lerpResult88_g62635;
				half Global_Extras_Overlay156_g55655 = break89_g62635.b;
				half Overlay_Variation4560_g55655 = 1.0;
				half Overlay_Commons1365_g55655 = ( _GlobalOverlay * Global_Extras_Overlay156_g55655 * Overlay_Variation4560_g55655 );
				float temp_output_7_0_g62666 = _OverlayMaskMinValue;
				half Overlay_Mask269_g55655 = saturate( ( ( ( ( 0.5 + Main_AlbedoTex_G3526_g55655 ) * Overlay_Commons1365_g55655 ) - temp_output_7_0_g62666 ) / ( _OverlayMaskMaxValue - temp_output_7_0_g62666 ) ) );
				float3 lerpResult336_g55655 = lerp( Blend_AlbedoAndSubsurface149_g55655 , Global_OverlayColor1758_g55655 , Overlay_Mask269_g55655);
				half3 Final_Albedo359_g55655 = lerpResult336_g55655;
				
				float localCustomAlphaClip3735_g55655 = ( 0.0 );
				float3 normalizeResult3971_g55655 = normalize( cross( ddy( WorldPosition ) , ddx( WorldPosition ) ) );
				float3 NormalsWS_Derivates3972_g55655 = normalizeResult3971_g55655;
				float dotResult2161_g55655 = dot( ViewDir_Normalized3963_g55655 , NormalsWS_Derivates3972_g55655 );
				float dotResult2212_g55655 = dot( ViewDir_Normalized3963_g55655 , float3(0,1,0) );
				half Mask_HView2656_g55655 = dotResult2212_g55655;
				float lerpResult2221_g55655 = lerp( _FadeHorizontalValue , _FadeVerticalValue , Mask_HView2656_g55655);
				float lerpResult3992_g55655 = lerp( 1.0 , saturate( abs( dotResult2161_g55655 ) ) , lerpResult2221_g55655);
				half Fade_Billboard2175_g55655 = lerpResult3992_g55655;
				float temp_output_41_0_g62674 = ( 1.0 * Fade_Billboard2175_g55655 );
				half Final_AlphaFade3727_g55655 = saturate( ( temp_output_41_0_g62674 + ( temp_output_41_0_g62674 * tex3D( TVE_ScreenTex3D, ( TVE_ScreenTexCoord * WorldPosition3905_g55655 ) ).r ) ) );
				float Main_Alpha316_g55655 = ( _MainColor.a * tex2DNode29_g55655.a );
				half AlphaTreshold2132_g55655 = _Cutoff;
				#ifdef TVE_ALPHA_CLIP
				float staticSwitch3792_g55655 = ( Main_Alpha316_g55655 - ( AlphaTreshold2132_g55655 - 0.5 ) );
				#else
				float staticSwitch3792_g55655 = Main_Alpha316_g55655;
				#endif
				half Final_Alpha3754_g55655 = staticSwitch3792_g55655;
				float temp_output_661_0_g55655 = ( Final_AlphaFade3727_g55655 * Final_Alpha3754_g55655 );
				float Alpha3735_g55655 = temp_output_661_0_g55655;
				float Treshold3735_g55655 = 0.5;
				{
				#if TVE_ALPHA_CLIP
				clip(Alpha3735_g55655 - Treshold3735_g55655);
				#endif
				}
				half Final_Clip914_g55655 = saturate( Alpha3735_g55655 );
				
				
				float3 Albedo = Final_Albedo359_g55655;
				float Alpha = Final_Clip914_g55655;
				float AlphaClipThreshold = 0.5;

				half4 color = half4( Albedo, Alpha );

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				return color;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthNormals"
			Tags { "LightMode"="DepthNormals" }

			ZWrite On
			Blend One Zero
            ZTest LEqual
            ZWrite On

			HLSLPROGRAM
			
			#define _SPECULAR_SETUP 1
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#pragma multi_compile _ DOTS_INSTANCING_ON
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 120100

			
			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_DEPTHNORMALSONLY

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#pragma shader_feature_local TVE_ALPHA_CLIP
			#pragma shader_feature_local TVE_VERTEX_DATA_BATCHED
			//TVE Shader Type Defines
			#define TVE_IS_VEGETATION_SHADER
			//TVE Pipeline Defines
			#define THE_VEGETATION_ENGINE
			#define TVE_IS_UNIVERSAL_PIPELINE
			//TVE Injection Defines
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				float3 worldNormal : TEXCOORD2;
				float4 worldTangent : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _GradientMaskRemap;
			half4 _SubsurfaceColor;
			half4 _ColorsMaskRemap;
			half4 _VertexOcclusionRemap;
			float4 _NoiseMaskRemap;
			half4 _OverlayMaskRemap;
			half4 _SubsurfaceMaskRemap;
			float4 _Color;
			half4 _AlphaMaskRemap;
			half4 _NoiseColorTwo;
			half4 _GradientColorTwo;
			half4 _GradientColorOne;
			float4 _SubsurfaceDiffusion_asset;
			float4 _EmissiveIntensityParams;
			half4 _EmissiveUVs;
			half4 _DetailBlendRemap;
			float4 _MaxBoundsInfo;
			half4 _MainUVs;
			half4 _LeavesMaskRemap;
			half4 _MainColor;
			float4 _SubsurfaceDiffusion_Asset;
			half4 _NoiseColorOne;
			half4 _EmissiveColor;
			half3 _render_normals_options;
			half _GradientMaxValue;
			half _InteractionMaskValue;
			half _GlobalSize;
			half _LayerVertexValue;
			half _VertexDataMode;
			half _InteractionAmplitude;
			float _MotionScale_10;
			half _VertexDynamicMode;
			half _MotionVariation_10;
			float _MotionSpeed_10;
			half _MotionAmplitude_10;
			half _LayerMotionValue;
			half _render_zw;
			half _IsStandardShader;
			half _GradientMinValue;
			half _render_src;
			half _ColorsPositionMode;
			half _NoiseMinValue;
			half _MainOcclusionValue;
			half _GlobalWetness;
			half _MainSmoothnessValue;
			half _RenderSpecular;
			half _GlobalEmissive;
			half _MainNormalValue;
			half _OverlayMaskMaxValue;
			half _OverlayMaskMinValue;
			half _LayerExtrasValue;
			half _ExtrasPositionMode;
			half _NoiseScaleValue;
			half _GlobalOverlay;
			half _MainLightAngleValue;
			half _SubsurfaceMaskMaxValue;
			half _SubsurfaceMaskMinValue;
			half _SubsurfaceValue;
			half _ColorsMaskMaxValue;
			half _ColorsMaskMinValue;
			half _GlobalColors;
			half _LayerColorsValue;
			half _IsCrossShader;
			half _NoiseMaxValue;
			half _MainLightScatteringValue;
			half _SpaceMotionHighlight;
			half _SpaceGlobalPosition;
			half _DetailTypeMode;
			half _RenderPriority;
			half _RenderZWrite;
			half _HasGradient;
			float _SubsurfaceDiffusion;
			half _IsVersion;
			half _MotionCat;
			half _DetailBlendMode;
			half _SpaceRenderReceive;
			half _RenderCull;
			half _HasEmissive;
			half _VertexMasksMode;
			half _SizeFadeCat;
			half _SubsurfaceCat;
			half _PerspectiveCat;
			half _DetailCat;
			half _RenderingCat;
			half _RenderMode;
			half _GradientCat;
			half _DetailMode;
			half _EmissiveCat;
			half _RenderQueue;
			half _render_dst;
			half _render_cull;
			half _GlobalCat;
			half _RenderNormals;
			half _SpaceRenderFade;
			half _OcclusionCat;
			half _MessageTranslucencyHD;
			half _TranslucencyDirectValue;
			half _SpaceMotionLocals;
			half _TranslucencyShadowValue;
			half _FadeHorizontalValue;
			half _SpaceGlobalLayers;
			half _IsTVEShader;
			half _MessageSizeFade;
			half _TranslucencyAmbientValue;
			half _TranslucencyIntensityValue;
			half _RenderSSR;
			half _RenderDecals;
			half _TranslucencyScatteringValue;
			half _TranslucencyNormalValue;
			half _MessageMotionVariation;
			half _VertexVariationMode;
			half _MessageGlobalsVariation;
			half _MainCat;
			half _VertexRollingMode;
			half _Cutoff;
			half _NoiseCat;
			half _EmissiveFlagMode;
			half _HasOcclusion;
			half _LayerReactValue;
			half _RenderClip;
			half _FadeVerticalValue;
			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _MainTex;
			half TVE_Enabled;
			sampler2D _BumpMap;
			half4 TVE_MotionParams;
			TEXTURE2D_ARRAY(TVE_MotionTex);
			half4 TVE_MotionCoords;
			SAMPLER(samplerTVE_MotionTex);
			float TVE_MotionUsage[10];
			half4 TVE_MotionParamsMin;
			half4 TVE_MotionParamsMax;
			sampler2D TVE_NoiseTex;
			half4 TVE_NoiseParams;
			half4 TVE_VertexParams;
			TEXTURE2D_ARRAY(TVE_VertexTex);
			half4 TVE_VertexCoords;
			SAMPLER(samplerTVE_VertexTex);
			float TVE_VertexUsage[10];
			half _DisableSRPBatcher;
			sampler2D _MainNormalTex;
			sampler3D TVE_ScreenTex3D;
			half TVE_ScreenTexCoord;
			sampler2D _MainAlbedoTex;


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float3 VertexPosition3588_g55655 = v.vertex.xyz;
				half3 Mesh_PivotsOS2291_g55655 = half3(0,0,0);
				float3 temp_output_2283_0_g55655 = ( VertexPosition3588_g55655 - Mesh_PivotsOS2291_g55655 );
				half3 VertexPos40_g62634 = temp_output_2283_0_g55655;
				float3 appendResult74_g62634 = (float3(VertexPos40_g62634.x , 0.0 , 0.0));
				half3 VertexPosRotationAxis50_g62634 = appendResult74_g62634;
				float3 break84_g62634 = VertexPos40_g62634;
				float3 appendResult81_g62634 = (float3(0.0 , break84_g62634.y , break84_g62634.z));
				half3 VertexPosOtherAxis82_g62634 = appendResult81_g62634;
				float4 temp_output_91_19_g62645 = TVE_MotionCoords;
				float4x4 break19_g62677 = GetObjectToWorldMatrix();
				float3 appendResult20_g62677 = (float3(break19_g62677[ 0 ][ 3 ] , break19_g62677[ 1 ][ 3 ] , break19_g62677[ 2 ][ 3 ]));
				half3 ObjectData20_g62678 = appendResult20_g62677;
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				half3 WorldData19_g62678 = ase_worldPos;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62678 = WorldData19_g62678;
				#else
				float3 staticSwitch14_g62678 = ObjectData20_g62678;
				#endif
				float3 temp_output_114_0_g62677 = staticSwitch14_g62678;
				float3 vertexToFrag4224_g55655 = temp_output_114_0_g62677;
				half3 ObjectData20_g62665 = vertexToFrag4224_g55655;
				float3 vertexToFrag3890_g55655 = ase_worldPos;
				half3 WorldData19_g62665 = vertexToFrag3890_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62665 = WorldData19_g62665;
				#else
				float3 staticSwitch14_g62665 = ObjectData20_g62665;
				#endif
				float3 ObjectPosition4223_g55655 = staticSwitch14_g62665;
				float3 Position83_g62645 = ObjectPosition4223_g55655;
				float temp_output_84_0_g62645 = _LayerMotionValue;
				float4 lerpResult87_g62645 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, samplerTVE_MotionTex, ( (temp_output_91_19_g62645).zw + ( (temp_output_91_19_g62645).xy * (Position83_g62645).xz ) ),temp_output_84_0_g62645, 0.0 ) , TVE_MotionUsage[(int)temp_output_84_0_g62645]);
				half4 Global_Motion_Params3909_g55655 = lerpResult87_g62645;
				float4 break322_g62615 = Global_Motion_Params3909_g55655;
				float3 appendResult397_g62615 = (float3(break322_g62615.x , 0.0 , break322_g62615.y));
				float3 temp_output_398_0_g62615 = (appendResult397_g62615*2.0 + -1.0);
				float3 ase_parentObjectScale = ( 1.0 / float3( length( GetWorldToObjectMatrix()[ 0 ].xyz ), length( GetWorldToObjectMatrix()[ 1 ].xyz ), length( GetWorldToObjectMatrix()[ 2 ].xyz ) ) );
				half2 Global_MotionDirectionOS39_g55655 = (( mul( GetWorldToObjectMatrix(), float4( temp_output_398_0_g62615 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half ObjectData20_g62639 = 3.14;
				float Bounds_Height374_g55655 = _MaxBoundsInfo.y;
				half WorldData19_g62639 = ( Bounds_Height374_g55655 * 3.14 );
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62639 = WorldData19_g62639;
				#else
				float staticSwitch14_g62639 = ObjectData20_g62639;
				#endif
				float Motion_Max_Bending1133_g55655 = staticSwitch14_g62639;
				half Mesh_Motion_1082_g55655 = v.ase_texcoord3.x;
				half Motion_10_Mask4617_g55655 = ( _MotionAmplitude_10 * Motion_Max_Bending1133_g55655 * Mesh_Motion_1082_g55655 );
				half Input_Speed62_g62605 = _MotionSpeed_10;
				float mulTime373_g62605 = _TimeParameters.x * Input_Speed62_g62605;
				float3 break111_g62621 = ObjectPosition4223_g55655;
				float Mesh_Variation16_g55655 = v.ase_color.r;
				half VertexDynamicMode4798_g55655 = _VertexDynamicMode;
				float lerpResult4795_g55655 = lerp( frac( ( v.ase_color.r + ( break111_g62621.x + break111_g62621.z ) ) ) , Mesh_Variation16_g55655 , VertexDynamicMode4798_g55655);
				half ObjectData20_g62614 = lerpResult4795_g55655;
				half WorldData19_g62614 = Mesh_Variation16_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62614 = WorldData19_g62614;
				#else
				float staticSwitch14_g62614 = ObjectData20_g62614;
				#endif
				half Motion_Variation3073_g55655 = staticSwitch14_g62614;
				half Motion_10_Variation4581_g55655 = ( _MotionVariation_10 * Motion_Variation3073_g55655 );
				half Motion_Variation284_g62605 = Motion_10_Variation4581_g55655;
				float Motion_Scale287_g62605 = ( _MotionScale_10 * ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z ) );
				half Sine_MinusOneToOne281_g62605 = sin( ( mulTime373_g62605 + Motion_Variation284_g62605 + Motion_Scale287_g62605 ) );
				half Input_WindSquash419_g62605 = 0.2;
				half Wind_Power369_g62615 = break322_g62615.z;
				float lerpResult376_g62615 = lerp( TVE_MotionParamsMin.x , TVE_MotionParamsMax.x , Wind_Power369_g62615);
				half Wind_Stop420_g62615 = saturate( ( Wind_Power369_g62615 * 10.0 ) );
				half Global_MotionPower_103106_g55655 = ( lerpResult376_g62615 * Wind_Stop420_g62615 );
				half Input_WindPower327_g62605 = Global_MotionPower_103106_g55655;
				float lerpResult321_g62605 = lerp( Sine_MinusOneToOne281_g62605 , (Sine_MinusOneToOne281_g62605*Input_WindSquash419_g62605 + 1.0) , Input_WindPower327_g62605);
				half Motion_10_SinWaveAm4570_g55655 = lerpResult321_g62605;
				float2 panner437_g62615 = ( _TimeParameters.x * (TVE_NoiseParams).xy + ( (ObjectPosition4223_g55655).xz * TVE_NoiseParams.z ));
				float saferPower446_g62615 = abs( abs( tex2Dlod( TVE_NoiseTex, float4( panner437_g62615, 0, 0.0) ).r ) );
				float lerpResult448_g62615 = lerp( TVE_MotionParamsMin.w , TVE_MotionParamsMax.w , Wind_Power369_g62615);
				half Global_MotionNoise34_g55655 = pow( saferPower446_g62615 , lerpResult448_g62615 );
				half Motion_10_Bending2258_g55655 = ( Motion_10_Mask4617_g55655 * Motion_10_SinWaveAm4570_g55655 * Global_MotionPower_103106_g55655 * Global_MotionNoise34_g55655 );
				half Interaction_Amplitude4137_g55655 = _InteractionAmplitude;
				float lerpResult4494_g55655 = lerp( 1.0 , Mesh_Motion_1082_g55655 , _InteractionMaskValue);
				half ObjectData20_g62620 = lerpResult4494_g55655;
				half WorldData19_g62620 = Mesh_Motion_1082_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62620 = WorldData19_g62620;
				#else
				float staticSwitch14_g62620 = ObjectData20_g62620;
				#endif
				half Motion_10_Interaction53_g55655 = ( Interaction_Amplitude4137_g55655 * Motion_Max_Bending1133_g55655 * staticSwitch14_g62620 );
				half Global_InteractionMask66_g55655 = ( break322_g62615.w * break322_g62615.w );
				float lerpResult4685_g55655 = lerp( Motion_10_Bending2258_g55655 , Motion_10_Interaction53_g55655 , saturate( ( Global_InteractionMask66_g55655 * Interaction_Amplitude4137_g55655 ) ));
				float2 break4603_g55655 = ( Global_MotionDirectionOS39_g55655 * lerpResult4685_g55655 );
				half Vertex_ZAxisRotatin190_g55655 = break4603_g55655.y;
				half Angle44_g62634 = Vertex_ZAxisRotatin190_g55655;
				half3 VertexPos40_g62631 = ( VertexPosRotationAxis50_g62634 + ( VertexPosOtherAxis82_g62634 * cos( Angle44_g62634 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g62634 ) * sin( Angle44_g62634 ) ) );
				float3 appendResult74_g62631 = (float3(0.0 , 0.0 , VertexPos40_g62631.z));
				half3 VertexPosRotationAxis50_g62631 = appendResult74_g62631;
				float3 break84_g62631 = VertexPos40_g62631;
				float3 appendResult81_g62631 = (float3(break84_g62631.x , break84_g62631.y , 0.0));
				half3 VertexPosOtherAxis82_g62631 = appendResult81_g62631;
				half Vertex_XAxisRotation216_g55655 = break4603_g55655.x;
				half Angle44_g62631 = -Vertex_XAxisRotation216_g55655;
				float3 Vertex_Motion_Object833_g55655 = ( VertexPosRotationAxis50_g62631 + ( VertexPosOtherAxis82_g62631 * cos( Angle44_g62631 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g62631 ) * sin( Angle44_g62631 ) ) );
				float3 temp_output_3474_0_g55655 = ( VertexPosition3588_g55655 - Mesh_PivotsOS2291_g55655 );
				float3 appendResult2043_g55655 = (float3(Vertex_XAxisRotation216_g55655 , 0.0 , Vertex_ZAxisRotatin190_g55655));
				float3 Vertex_Motion_World1118_g55655 = ( temp_output_3474_0_g55655 + appendResult2043_g55655 );
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch3312_g55655 = Vertex_Motion_World1118_g55655;
				#else
				float3 staticSwitch3312_g55655 = ( Vertex_Motion_Object833_g55655 + ( 0.0 * _VertexDataMode ) );
				#endif
				float4 temp_output_94_19_g62640 = TVE_VertexCoords;
				float3 Position83_g62640 = ObjectPosition4223_g55655;
				float temp_output_84_0_g62640 = _LayerVertexValue;
				float4 lerpResult87_g62640 = lerp( TVE_VertexParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, samplerTVE_VertexTex, ( (temp_output_94_19_g62640).zw + ( (temp_output_94_19_g62640).xy * (Position83_g62640).xz ) ),temp_output_84_0_g62640, 0.0 ) , TVE_VertexUsage[(int)temp_output_84_0_g62640]);
				half4 Global_Object_Params4173_g55655 = lerpResult87_g62640;
				half Global_VertexSize174_g55655 = Global_Object_Params4173_g55655.w;
				float lerpResult16_g62663 = lerp( 0.0 , _GlobalSize , TVE_Enabled);
				float lerpResult346_g55655 = lerp( 1.0 , Global_VertexSize174_g55655 , lerpResult16_g62663);
				float3 appendResult3480_g55655 = (float3(lerpResult346_g55655 , lerpResult346_g55655 , lerpResult346_g55655));
				half3 ObjectData20_g62676 = appendResult3480_g55655;
				half3 _Vector11 = half3(1,1,1);
				half3 WorldData19_g62676 = _Vector11;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62676 = WorldData19_g62676;
				#else
				float3 staticSwitch14_g62676 = ObjectData20_g62676;
				#endif
				half3 Vertex_Size1741_g55655 = staticSwitch14_g62676;
				half3 _Vector5 = half3(1,1,1);
				float3 Vertex_SizeFade1740_g55655 = _Vector5;
				half3 Grass_Perspective2661_g55655 = half3(0,0,0);
				float3 Final_VertexPosition890_g55655 = ( ( ( staticSwitch3312_g55655 * Vertex_Size1741_g55655 * Vertex_SizeFade1740_g55655 ) + Mesh_PivotsOS2291_g55655 + Grass_Perspective2661_g55655 ) + _DisableSRPBatcher );
				
				float2 vertexToFrag11_g62604 = ( ( v.ase_texcoord.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord4.xy = vertexToFrag11_g62604;
				
				o.ase_texcoord5.xyz = vertexToFrag3890_g55655;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord4.zw = 0;
				o.ase_texcoord5.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = Final_VertexPosition890_g55655;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;
				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float3 normalWS = TransformObjectToWorldNormal( v.ase_normal );
				float4 tangentWS = float4(TransformObjectToWorldDir( v.ase_tangent.xyz), v.ase_tangent.w);
				float4 positionCS = TransformWorldToHClip( positionWS );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif

				o.worldNormal = normalWS;
				o.worldTangent = tangentWS;

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				o.clipPos = positionCS;
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_tangent = v.ase_tangent;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE)
				#define ASE_SV_DEPTH SV_DepthLessEqual  
			#else
				#define ASE_SV_DEPTH SV_Depth
			#endif
			half4 frag(	VertexOutput IN 
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						, FRONT_FACE_TYPE ase_vface : FRONT_FACE_SEMANTIC ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );
				
				float3 WorldNormal = IN.worldNormal;
				float4 WorldTangent = IN.worldTangent;

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 vertexToFrag11_g62604 = IN.ase_texcoord4.xy;
				half2 Main_UVs15_g55655 = vertexToFrag11_g62604;
				float3 unpack4112_g55655 = UnpackNormalScale( tex2D( _MainNormalTex, Main_UVs15_g55655 ), _MainNormalValue );
				unpack4112_g55655.z = lerp( 1, unpack4112_g55655.z, saturate(_MainNormalValue) );
				half3 Main_Normal137_g55655 = unpack4112_g55655;
				float3 temp_output_13_0_g62598 = Main_Normal137_g55655;
				float3 switchResult12_g62598 = (((ase_vface>0)?(temp_output_13_0_g62598):(( temp_output_13_0_g62598 * _render_normals_options ))));
				half3 Blend_Normal312_g55655 = switchResult12_g62598;
				half3 Final_Normal366_g55655 = Blend_Normal312_g55655;
				
				float localCustomAlphaClip3735_g55655 = ( 0.0 );
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 normalizeResult2169_g55655 = normalize( ase_worldViewDir );
				float3 ViewDir_Normalized3963_g55655 = normalizeResult2169_g55655;
				float3 normalizeResult3971_g55655 = normalize( cross( ddy( WorldPosition ) , ddx( WorldPosition ) ) );
				float3 NormalsWS_Derivates3972_g55655 = normalizeResult3971_g55655;
				float dotResult2161_g55655 = dot( ViewDir_Normalized3963_g55655 , NormalsWS_Derivates3972_g55655 );
				float dotResult2212_g55655 = dot( ViewDir_Normalized3963_g55655 , float3(0,1,0) );
				half Mask_HView2656_g55655 = dotResult2212_g55655;
				float lerpResult2221_g55655 = lerp( _FadeHorizontalValue , _FadeVerticalValue , Mask_HView2656_g55655);
				float lerpResult3992_g55655 = lerp( 1.0 , saturate( abs( dotResult2161_g55655 ) ) , lerpResult2221_g55655);
				half Fade_Billboard2175_g55655 = lerpResult3992_g55655;
				float temp_output_41_0_g62674 = ( 1.0 * Fade_Billboard2175_g55655 );
				float3 vertexToFrag3890_g55655 = IN.ase_texcoord5.xyz;
				float3 WorldPosition3905_g55655 = vertexToFrag3890_g55655;
				half Final_AlphaFade3727_g55655 = saturate( ( temp_output_41_0_g62674 + ( temp_output_41_0_g62674 * tex3D( TVE_ScreenTex3D, ( TVE_ScreenTexCoord * WorldPosition3905_g55655 ) ).r ) ) );
				float4 tex2DNode29_g55655 = tex2D( _MainAlbedoTex, Main_UVs15_g55655 );
				float Main_Alpha316_g55655 = ( _MainColor.a * tex2DNode29_g55655.a );
				half AlphaTreshold2132_g55655 = _Cutoff;
				#ifdef TVE_ALPHA_CLIP
				float staticSwitch3792_g55655 = ( Main_Alpha316_g55655 - ( AlphaTreshold2132_g55655 - 0.5 ) );
				#else
				float staticSwitch3792_g55655 = Main_Alpha316_g55655;
				#endif
				half Final_Alpha3754_g55655 = staticSwitch3792_g55655;
				float temp_output_661_0_g55655 = ( Final_AlphaFade3727_g55655 * Final_Alpha3754_g55655 );
				float Alpha3735_g55655 = temp_output_661_0_g55655;
				float Treshold3735_g55655 = 0.5;
				{
				#if TVE_ALPHA_CLIP
				clip(Alpha3735_g55655 - Treshold3735_g55655);
				#endif
				}
				half Final_Clip914_g55655 = saturate( Alpha3735_g55655 );
				
				float3 Normal = Final_Normal366_g55655;
				float Alpha = Final_Clip914_g55655;
				float AlphaClipThreshold = 0.5;
				#ifdef ASE_DEPTH_WRITE_ON
				float DepthValue = 0;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif
				
				#ifdef ASE_DEPTH_WRITE_ON
				outputDepth = DepthValue;
				#endif
				
				#if defined(_GBUFFER_NORMALS_OCT)
					float2 octNormalWS = PackNormalOctQuadEncode(WorldNormal);
					float2 remappedOctNormalWS = saturate(octNormalWS * 0.5 + 0.5);
					half3 packedNormalWS = PackFloat2To888(remappedOctNormalWS);
					return half4(packedNormalWS, 0.0);
				#else
					
					#if defined(_NORMALMAP)
						#if _NORMAL_DROPOFF_TS
							float crossSign = (WorldTangent.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
							float3 bitangent = crossSign * cross(WorldNormal.xyz, WorldTangent.xyz);
							float3 normalWS = TransformTangentToWorld(Normal, half3x3(WorldTangent.xyz, bitangent, WorldNormal.xyz));
						#elif _NORMAL_DROPOFF_OS
							float3 normalWS = TransformObjectToWorldNormal(Normal);
						#elif _NORMAL_DROPOFF_WS
							float3 normalWS = Normal;
						#endif
					#else
						float3 normalWS = WorldNormal;
					#endif

					return half4(NormalizeNormalPerPixel(normalWS), 0.0);
				#endif
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "GBuffer"
			Tags { "LightMode"="UniversalGBuffer" }
			
			Blend [_render_src] [_render_dst], One Zero
			ColorMask RGBA
			

			HLSLPROGRAM
			
			#define _SPECULAR_SETUP 1
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#pragma multi_compile _ DOTS_INSTANCING_ON
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 120100

			
			// -------------------------------------
			// Universal Pipeline keywords
			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
			//#pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
			//#pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
			#pragma multi_compile_fragment _ _SHADOWS_SOFT
			#pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
			#pragma multi_compile_fragment _ _LIGHT_LAYERS
			#pragma multi_compile_fragment _ _RENDER_PASS_ENABLED

			// -------------------------------------
			// Unity defined keywords
			#pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
			#pragma multi_compile _ SHADOWS_SHADOWMASK
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ LIGHTMAP_ON
			#pragma multi_compile _ DYNAMICLIGHTMAP_ON
			#pragma multi_compile_fragment _ _GBUFFER_NORMALS_OCT

			//--------------------------------------
			// GPU Instancing
			#pragma instancing_options renderinglayer

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_GBUFFER

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"


			#if defined(UNITY_INSTANCING_ENABLED) && defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL)
			    #define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#pragma shader_feature_local TVE_ALPHA_CLIP
			#pragma shader_feature_local TVE_VERTEX_DATA_BATCHED
			//TVE Shader Type Defines
			#define TVE_IS_VEGETATION_SHADER
			//TVE Pipeline Defines
			#define THE_VEGETATION_ENGINE
			#define TVE_IS_UNIVERSAL_PIPELINE
			//TVE Injection Defines
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				float4 lightmapUVOrVertexSH : TEXCOORD0;
				half4 fogFactorAndVertexLight : TEXCOORD1;
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
				float4 shadowCoord : TEXCOORD2;
				#endif
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				float4 screenPos : TEXCOORD6;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON)
				float2 dynamicLightmapUV : TEXCOORD7;
				#endif
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_texcoord9 : TEXCOORD9;
				float4 ase_texcoord10 : TEXCOORD10;
				float4 ase_texcoord11 : TEXCOORD11;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _GradientMaskRemap;
			half4 _SubsurfaceColor;
			half4 _ColorsMaskRemap;
			half4 _VertexOcclusionRemap;
			float4 _NoiseMaskRemap;
			half4 _OverlayMaskRemap;
			half4 _SubsurfaceMaskRemap;
			float4 _Color;
			half4 _AlphaMaskRemap;
			half4 _NoiseColorTwo;
			half4 _GradientColorTwo;
			half4 _GradientColorOne;
			float4 _SubsurfaceDiffusion_asset;
			float4 _EmissiveIntensityParams;
			half4 _EmissiveUVs;
			half4 _DetailBlendRemap;
			float4 _MaxBoundsInfo;
			half4 _MainUVs;
			half4 _LeavesMaskRemap;
			half4 _MainColor;
			float4 _SubsurfaceDiffusion_Asset;
			half4 _NoiseColorOne;
			half4 _EmissiveColor;
			half3 _render_normals_options;
			half _GradientMaxValue;
			half _InteractionMaskValue;
			half _GlobalSize;
			half _LayerVertexValue;
			half _VertexDataMode;
			half _InteractionAmplitude;
			float _MotionScale_10;
			half _VertexDynamicMode;
			half _MotionVariation_10;
			float _MotionSpeed_10;
			half _MotionAmplitude_10;
			half _LayerMotionValue;
			half _render_zw;
			half _IsStandardShader;
			half _GradientMinValue;
			half _render_src;
			half _ColorsPositionMode;
			half _NoiseMinValue;
			half _MainOcclusionValue;
			half _GlobalWetness;
			half _MainSmoothnessValue;
			half _RenderSpecular;
			half _GlobalEmissive;
			half _MainNormalValue;
			half _OverlayMaskMaxValue;
			half _OverlayMaskMinValue;
			half _LayerExtrasValue;
			half _ExtrasPositionMode;
			half _NoiseScaleValue;
			half _GlobalOverlay;
			half _MainLightAngleValue;
			half _SubsurfaceMaskMaxValue;
			half _SubsurfaceMaskMinValue;
			half _SubsurfaceValue;
			half _ColorsMaskMaxValue;
			half _ColorsMaskMinValue;
			half _GlobalColors;
			half _LayerColorsValue;
			half _IsCrossShader;
			half _NoiseMaxValue;
			half _MainLightScatteringValue;
			half _SpaceMotionHighlight;
			half _SpaceGlobalPosition;
			half _DetailTypeMode;
			half _RenderPriority;
			half _RenderZWrite;
			half _HasGradient;
			float _SubsurfaceDiffusion;
			half _IsVersion;
			half _MotionCat;
			half _DetailBlendMode;
			half _SpaceRenderReceive;
			half _RenderCull;
			half _HasEmissive;
			half _VertexMasksMode;
			half _SizeFadeCat;
			half _SubsurfaceCat;
			half _PerspectiveCat;
			half _DetailCat;
			half _RenderingCat;
			half _RenderMode;
			half _GradientCat;
			half _DetailMode;
			half _EmissiveCat;
			half _RenderQueue;
			half _render_dst;
			half _render_cull;
			half _GlobalCat;
			half _RenderNormals;
			half _SpaceRenderFade;
			half _OcclusionCat;
			half _MessageTranslucencyHD;
			half _TranslucencyDirectValue;
			half _SpaceMotionLocals;
			half _TranslucencyShadowValue;
			half _FadeHorizontalValue;
			half _SpaceGlobalLayers;
			half _IsTVEShader;
			half _MessageSizeFade;
			half _TranslucencyAmbientValue;
			half _TranslucencyIntensityValue;
			half _RenderSSR;
			half _RenderDecals;
			half _TranslucencyScatteringValue;
			half _TranslucencyNormalValue;
			half _MessageMotionVariation;
			half _VertexVariationMode;
			half _MessageGlobalsVariation;
			half _MainCat;
			half _VertexRollingMode;
			half _Cutoff;
			half _NoiseCat;
			half _EmissiveFlagMode;
			half _HasOcclusion;
			half _LayerReactValue;
			half _RenderClip;
			half _FadeVerticalValue;
			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _MainTex;
			half TVE_Enabled;
			sampler2D _BumpMap;
			half4 TVE_MotionParams;
			TEXTURE2D_ARRAY(TVE_MotionTex);
			half4 TVE_MotionCoords;
			SAMPLER(samplerTVE_MotionTex);
			float TVE_MotionUsage[10];
			half4 TVE_MotionParamsMin;
			half4 TVE_MotionParamsMax;
			sampler2D TVE_NoiseTex;
			half4 TVE_NoiseParams;
			half4 TVE_VertexParams;
			TEXTURE2D_ARRAY(TVE_VertexTex);
			half4 TVE_VertexCoords;
			SAMPLER(samplerTVE_VertexTex);
			float TVE_VertexUsage[10];
			half _DisableSRPBatcher;
			sampler3D TVE_WorldTex3D;
			sampler2D _MainAlbedoTex;
			half4 TVE_ColorsParams;
			TEXTURE2D_ARRAY(TVE_ColorsTex);
			half4 TVE_ColorsCoords;
			SAMPLER(samplerTVE_ColorsTex);
			float TVE_ColorsUsage[10];
			sampler2D _MainMaskTex;
			half4 TVE_MainLightParams;
			half3 TVE_MainLightDirection;
			half4 TVE_OverlayColor;
			half4 TVE_ExtrasParams;
			TEXTURE2D_ARRAY(TVE_ExtrasTex);
			half4 TVE_ExtrasCoords;
			SAMPLER(samplerTVE_ExtrasTex);
			float TVE_ExtrasUsage[10];
			sampler2D _MainNormalTex;
			sampler2D _EmissiveTex;
			half TVE_OverlaySmoothness;
			sampler3D TVE_ScreenTex3D;
			half TVE_ScreenTexCoord;


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float3 VertexPosition3588_g55655 = v.vertex.xyz;
				half3 Mesh_PivotsOS2291_g55655 = half3(0,0,0);
				float3 temp_output_2283_0_g55655 = ( VertexPosition3588_g55655 - Mesh_PivotsOS2291_g55655 );
				half3 VertexPos40_g62634 = temp_output_2283_0_g55655;
				float3 appendResult74_g62634 = (float3(VertexPos40_g62634.x , 0.0 , 0.0));
				half3 VertexPosRotationAxis50_g62634 = appendResult74_g62634;
				float3 break84_g62634 = VertexPos40_g62634;
				float3 appendResult81_g62634 = (float3(0.0 , break84_g62634.y , break84_g62634.z));
				half3 VertexPosOtherAxis82_g62634 = appendResult81_g62634;
				float4 temp_output_91_19_g62645 = TVE_MotionCoords;
				float4x4 break19_g62677 = GetObjectToWorldMatrix();
				float3 appendResult20_g62677 = (float3(break19_g62677[ 0 ][ 3 ] , break19_g62677[ 1 ][ 3 ] , break19_g62677[ 2 ][ 3 ]));
				half3 ObjectData20_g62678 = appendResult20_g62677;
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				half3 WorldData19_g62678 = ase_worldPos;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62678 = WorldData19_g62678;
				#else
				float3 staticSwitch14_g62678 = ObjectData20_g62678;
				#endif
				float3 temp_output_114_0_g62677 = staticSwitch14_g62678;
				float3 vertexToFrag4224_g55655 = temp_output_114_0_g62677;
				half3 ObjectData20_g62665 = vertexToFrag4224_g55655;
				float3 vertexToFrag3890_g55655 = ase_worldPos;
				half3 WorldData19_g62665 = vertexToFrag3890_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62665 = WorldData19_g62665;
				#else
				float3 staticSwitch14_g62665 = ObjectData20_g62665;
				#endif
				float3 ObjectPosition4223_g55655 = staticSwitch14_g62665;
				float3 Position83_g62645 = ObjectPosition4223_g55655;
				float temp_output_84_0_g62645 = _LayerMotionValue;
				float4 lerpResult87_g62645 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, samplerTVE_MotionTex, ( (temp_output_91_19_g62645).zw + ( (temp_output_91_19_g62645).xy * (Position83_g62645).xz ) ),temp_output_84_0_g62645, 0.0 ) , TVE_MotionUsage[(int)temp_output_84_0_g62645]);
				half4 Global_Motion_Params3909_g55655 = lerpResult87_g62645;
				float4 break322_g62615 = Global_Motion_Params3909_g55655;
				float3 appendResult397_g62615 = (float3(break322_g62615.x , 0.0 , break322_g62615.y));
				float3 temp_output_398_0_g62615 = (appendResult397_g62615*2.0 + -1.0);
				float3 ase_parentObjectScale = ( 1.0 / float3( length( GetWorldToObjectMatrix()[ 0 ].xyz ), length( GetWorldToObjectMatrix()[ 1 ].xyz ), length( GetWorldToObjectMatrix()[ 2 ].xyz ) ) );
				half2 Global_MotionDirectionOS39_g55655 = (( mul( GetWorldToObjectMatrix(), float4( temp_output_398_0_g62615 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half ObjectData20_g62639 = 3.14;
				float Bounds_Height374_g55655 = _MaxBoundsInfo.y;
				half WorldData19_g62639 = ( Bounds_Height374_g55655 * 3.14 );
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62639 = WorldData19_g62639;
				#else
				float staticSwitch14_g62639 = ObjectData20_g62639;
				#endif
				float Motion_Max_Bending1133_g55655 = staticSwitch14_g62639;
				half Mesh_Motion_1082_g55655 = v.ase_texcoord3.x;
				half Motion_10_Mask4617_g55655 = ( _MotionAmplitude_10 * Motion_Max_Bending1133_g55655 * Mesh_Motion_1082_g55655 );
				half Input_Speed62_g62605 = _MotionSpeed_10;
				float mulTime373_g62605 = _TimeParameters.x * Input_Speed62_g62605;
				float3 break111_g62621 = ObjectPosition4223_g55655;
				float Mesh_Variation16_g55655 = v.ase_color.r;
				half VertexDynamicMode4798_g55655 = _VertexDynamicMode;
				float lerpResult4795_g55655 = lerp( frac( ( v.ase_color.r + ( break111_g62621.x + break111_g62621.z ) ) ) , Mesh_Variation16_g55655 , VertexDynamicMode4798_g55655);
				half ObjectData20_g62614 = lerpResult4795_g55655;
				half WorldData19_g62614 = Mesh_Variation16_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62614 = WorldData19_g62614;
				#else
				float staticSwitch14_g62614 = ObjectData20_g62614;
				#endif
				half Motion_Variation3073_g55655 = staticSwitch14_g62614;
				half Motion_10_Variation4581_g55655 = ( _MotionVariation_10 * Motion_Variation3073_g55655 );
				half Motion_Variation284_g62605 = Motion_10_Variation4581_g55655;
				float Motion_Scale287_g62605 = ( _MotionScale_10 * ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z ) );
				half Sine_MinusOneToOne281_g62605 = sin( ( mulTime373_g62605 + Motion_Variation284_g62605 + Motion_Scale287_g62605 ) );
				half Input_WindSquash419_g62605 = 0.2;
				half Wind_Power369_g62615 = break322_g62615.z;
				float lerpResult376_g62615 = lerp( TVE_MotionParamsMin.x , TVE_MotionParamsMax.x , Wind_Power369_g62615);
				half Wind_Stop420_g62615 = saturate( ( Wind_Power369_g62615 * 10.0 ) );
				half Global_MotionPower_103106_g55655 = ( lerpResult376_g62615 * Wind_Stop420_g62615 );
				half Input_WindPower327_g62605 = Global_MotionPower_103106_g55655;
				float lerpResult321_g62605 = lerp( Sine_MinusOneToOne281_g62605 , (Sine_MinusOneToOne281_g62605*Input_WindSquash419_g62605 + 1.0) , Input_WindPower327_g62605);
				half Motion_10_SinWaveAm4570_g55655 = lerpResult321_g62605;
				float2 panner437_g62615 = ( _TimeParameters.x * (TVE_NoiseParams).xy + ( (ObjectPosition4223_g55655).xz * TVE_NoiseParams.z ));
				float saferPower446_g62615 = abs( abs( tex2Dlod( TVE_NoiseTex, float4( panner437_g62615, 0, 0.0) ).r ) );
				float lerpResult448_g62615 = lerp( TVE_MotionParamsMin.w , TVE_MotionParamsMax.w , Wind_Power369_g62615);
				half Global_MotionNoise34_g55655 = pow( saferPower446_g62615 , lerpResult448_g62615 );
				half Motion_10_Bending2258_g55655 = ( Motion_10_Mask4617_g55655 * Motion_10_SinWaveAm4570_g55655 * Global_MotionPower_103106_g55655 * Global_MotionNoise34_g55655 );
				half Interaction_Amplitude4137_g55655 = _InteractionAmplitude;
				float lerpResult4494_g55655 = lerp( 1.0 , Mesh_Motion_1082_g55655 , _InteractionMaskValue);
				half ObjectData20_g62620 = lerpResult4494_g55655;
				half WorldData19_g62620 = Mesh_Motion_1082_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62620 = WorldData19_g62620;
				#else
				float staticSwitch14_g62620 = ObjectData20_g62620;
				#endif
				half Motion_10_Interaction53_g55655 = ( Interaction_Amplitude4137_g55655 * Motion_Max_Bending1133_g55655 * staticSwitch14_g62620 );
				half Global_InteractionMask66_g55655 = ( break322_g62615.w * break322_g62615.w );
				float lerpResult4685_g55655 = lerp( Motion_10_Bending2258_g55655 , Motion_10_Interaction53_g55655 , saturate( ( Global_InteractionMask66_g55655 * Interaction_Amplitude4137_g55655 ) ));
				float2 break4603_g55655 = ( Global_MotionDirectionOS39_g55655 * lerpResult4685_g55655 );
				half Vertex_ZAxisRotatin190_g55655 = break4603_g55655.y;
				half Angle44_g62634 = Vertex_ZAxisRotatin190_g55655;
				half3 VertexPos40_g62631 = ( VertexPosRotationAxis50_g62634 + ( VertexPosOtherAxis82_g62634 * cos( Angle44_g62634 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g62634 ) * sin( Angle44_g62634 ) ) );
				float3 appendResult74_g62631 = (float3(0.0 , 0.0 , VertexPos40_g62631.z));
				half3 VertexPosRotationAxis50_g62631 = appendResult74_g62631;
				float3 break84_g62631 = VertexPos40_g62631;
				float3 appendResult81_g62631 = (float3(break84_g62631.x , break84_g62631.y , 0.0));
				half3 VertexPosOtherAxis82_g62631 = appendResult81_g62631;
				half Vertex_XAxisRotation216_g55655 = break4603_g55655.x;
				half Angle44_g62631 = -Vertex_XAxisRotation216_g55655;
				float3 Vertex_Motion_Object833_g55655 = ( VertexPosRotationAxis50_g62631 + ( VertexPosOtherAxis82_g62631 * cos( Angle44_g62631 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g62631 ) * sin( Angle44_g62631 ) ) );
				float3 temp_output_3474_0_g55655 = ( VertexPosition3588_g55655 - Mesh_PivotsOS2291_g55655 );
				float3 appendResult2043_g55655 = (float3(Vertex_XAxisRotation216_g55655 , 0.0 , Vertex_ZAxisRotatin190_g55655));
				float3 Vertex_Motion_World1118_g55655 = ( temp_output_3474_0_g55655 + appendResult2043_g55655 );
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch3312_g55655 = Vertex_Motion_World1118_g55655;
				#else
				float3 staticSwitch3312_g55655 = ( Vertex_Motion_Object833_g55655 + ( 0.0 * _VertexDataMode ) );
				#endif
				float4 temp_output_94_19_g62640 = TVE_VertexCoords;
				float3 Position83_g62640 = ObjectPosition4223_g55655;
				float temp_output_84_0_g62640 = _LayerVertexValue;
				float4 lerpResult87_g62640 = lerp( TVE_VertexParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, samplerTVE_VertexTex, ( (temp_output_94_19_g62640).zw + ( (temp_output_94_19_g62640).xy * (Position83_g62640).xz ) ),temp_output_84_0_g62640, 0.0 ) , TVE_VertexUsage[(int)temp_output_84_0_g62640]);
				half4 Global_Object_Params4173_g55655 = lerpResult87_g62640;
				half Global_VertexSize174_g55655 = Global_Object_Params4173_g55655.w;
				float lerpResult16_g62663 = lerp( 0.0 , _GlobalSize , TVE_Enabled);
				float lerpResult346_g55655 = lerp( 1.0 , Global_VertexSize174_g55655 , lerpResult16_g62663);
				float3 appendResult3480_g55655 = (float3(lerpResult346_g55655 , lerpResult346_g55655 , lerpResult346_g55655));
				half3 ObjectData20_g62676 = appendResult3480_g55655;
				half3 _Vector11 = half3(1,1,1);
				half3 WorldData19_g62676 = _Vector11;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62676 = WorldData19_g62676;
				#else
				float3 staticSwitch14_g62676 = ObjectData20_g62676;
				#endif
				half3 Vertex_Size1741_g55655 = staticSwitch14_g62676;
				half3 _Vector5 = half3(1,1,1);
				float3 Vertex_SizeFade1740_g55655 = _Vector5;
				half3 Grass_Perspective2661_g55655 = half3(0,0,0);
				float3 Final_VertexPosition890_g55655 = ( ( ( staticSwitch3312_g55655 * Vertex_Size1741_g55655 * Vertex_SizeFade1740_g55655 ) + Mesh_PivotsOS2291_g55655 + Grass_Perspective2661_g55655 ) + _DisableSRPBatcher );
				
				half Mesh_Height1524_g55655 = v.ase_color.a;
				float temp_output_7_0_g62660 = _GradientMinValue;
				half Gradient_Tint2784_g55655 = saturate( ( ( Mesh_Height1524_g55655 - temp_output_7_0_g62660 ) / ( _GradientMaxValue - temp_output_7_0_g62660 ) ) );
				float vertexToFrag11_g62658 = Gradient_Tint2784_g55655;
				o.ase_texcoord8.x = vertexToFrag11_g62658;
				float3 temp_cast_8 = (_NoiseScaleValue).xxx;
				float3 WorldPosition3905_g55655 = vertexToFrag3890_g55655;
				float temp_output_7_0_g62667 = _NoiseMinValue;
				half Noise_Tint2802_g55655 = saturate( ( ( tex3Dlod( TVE_WorldTex3D, float4( ( temp_cast_8 * WorldPosition3905_g55655 * 0.1 ), 0.0) ).r - temp_output_7_0_g62667 ) / ( _NoiseMaxValue - temp_output_7_0_g62667 ) ) );
				float vertexToFrag11_g62662 = Noise_Tint2802_g55655;
				o.ase_texcoord8.y = vertexToFrag11_g62662;
				float2 vertexToFrag11_g62604 = ( ( v.texcoord.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord8.zw = vertexToFrag11_g62604;
				o.ase_texcoord9.xyz = vertexToFrag3890_g55655;
				o.ase_texcoord10.xyz = vertexToFrag4224_g55655;
				
				float2 vertexToFrag11_g62644 = ( ( v.texcoord.xy * (_EmissiveUVs).xy ) + (_EmissiveUVs).zw );
				o.ase_texcoord11.xy = vertexToFrag11_g62644;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord9.w = 0;
				o.ase_texcoord10.w = 0;
				o.ase_texcoord11.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = Final_VertexPosition890_g55655;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float3 positionVS = TransformWorldToView( positionWS );
				float4 positionCS = TransformWorldToHClip( positionWS );

				VertexNormalInputs normalInput = GetVertexNormalInputs( v.ase_normal, v.ase_tangent );

				o.tSpace0 = float4( normalInput.normalWS, positionWS.x);
				o.tSpace1 = float4( normalInput.tangentWS, positionWS.y);
				o.tSpace2 = float4( normalInput.bitangentWS, positionWS.z);

				OUTPUT_LIGHTMAP_UV( v.texcoord1, unity_LightmapST, o.lightmapUVOrVertexSH.xy );
				#if defined(DYNAMICLIGHTMAP_ON)
				o.dynamicLightmapUV.xy = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif

				OUTPUT_SH( normalInput.normalWS.xyz, o.lightmapUVOrVertexSH.xyz );

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					o.lightmapUVOrVertexSH.zw = v.texcoord;
					o.lightmapUVOrVertexSH.xy = v.texcoord * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif

				half3 vertexLight = VertexLighting( positionWS, normalInput.normalWS );
				#ifdef ASE_FOG
					half fogFactor = ComputeFogFactor( positionCS.z );
				#else
					half fogFactor = 0;
				#endif
				o.fogFactorAndVertexLight = half4(fogFactor, vertexLight);
				
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
				VertexPositionInputs vertexInput = (VertexPositionInputs)0;
				vertexInput.positionWS = positionWS;
				vertexInput.positionCS = positionCS;
				o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				
				o.clipPos = positionCS;
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				o.screenPos = ComputeScreenPos(positionCS);
				#endif
				return o;
			}
			
			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_tangent = v.ase_tangent;
				o.texcoord = v.texcoord;
				o.texcoord1 = v.texcoord1;
				o.texcoord2 = v.texcoord2;
				o.texcoord = v.texcoord;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				o.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				o.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE)
				#define ASE_SV_DEPTH SV_DepthLessEqual  
			#else
				#define ASE_SV_DEPTH SV_Depth
			#endif
			FragmentOutput frag ( VertexOutput IN 
								#ifdef ASE_DEPTH_WRITE_ON
								,out float outputDepth : ASE_SV_DEPTH
								#endif
								, FRONT_FACE_TYPE ase_vface : FRONT_FACE_SEMANTIC )
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float2 sampleCoords = (IN.lightmapUVOrVertexSH.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					float3 WorldNormal = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					float3 WorldTangent = -cross(GetObjectToWorldMatrix()._13_23_33, WorldNormal);
					float3 WorldBiTangent = cross(WorldNormal, -WorldTangent);
				#else
					float3 WorldNormal = normalize( IN.tSpace0.xyz );
					float3 WorldTangent = IN.tSpace1.xyz;
					float3 WorldBiTangent = IN.tSpace2.xyz;
				#endif
				float3 WorldPosition = float3(IN.tSpace0.w,IN.tSpace1.w,IN.tSpace2.w);
				float3 WorldViewDirection = _WorldSpaceCameraPos.xyz  - WorldPosition;
				float4 ShadowCoords = float4( 0, 0, 0, 0 );
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				float4 ScreenPos = IN.screenPos;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					ShadowCoords = IN.shadowCoord;
				#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
				#else
					ShadowCoords = float4(0, 0, 0, 0);
				#endif


	
				WorldViewDirection = SafeNormalize( WorldViewDirection );

				float vertexToFrag11_g62658 = IN.ase_texcoord8.x;
				float3 lerpResult2779_g55655 = lerp( (_GradientColorTwo).rgb , (_GradientColorOne).rgb , vertexToFrag11_g62658);
				float vertexToFrag11_g62662 = IN.ase_texcoord8.y;
				float3 lerpResult2800_g55655 = lerp( (_NoiseColorTwo).rgb , (_NoiseColorOne).rgb , vertexToFrag11_g62662);
				half Leaves_Mask4511_g55655 = 1.0;
				float3 lerpResult4521_g55655 = lerp( float3( 1,1,1 ) , ( lerpResult2779_g55655 * lerpResult2800_g55655 * float3(1,1,1) ) , Leaves_Mask4511_g55655);
				float3 lerpResult4519_g55655 = lerp( float3( 1,1,1 ) , (_MainColor).rgb , Leaves_Mask4511_g55655);
				float2 vertexToFrag11_g62604 = IN.ase_texcoord8.zw;
				half2 Main_UVs15_g55655 = vertexToFrag11_g62604;
				float4 tex2DNode29_g55655 = tex2D( _MainAlbedoTex, Main_UVs15_g55655 );
				half3 Main_Albedo99_g55655 = ( lerpResult4519_g55655 * (tex2DNode29_g55655).rgb );
				half3 Blend_Albedo265_g55655 = Main_Albedo99_g55655;
				half3 Blend_AlbedoTinted2808_g55655 = ( lerpResult4521_g55655 * Blend_Albedo265_g55655 );
				float dotResult3616_g55655 = dot( Blend_AlbedoTinted2808_g55655 , float3(0.2126,0.7152,0.0722) );
				float3 temp_cast_0 = (dotResult3616_g55655).xxx;
				float4 temp_output_91_19_g62668 = TVE_ColorsCoords;
				float3 vertexToFrag3890_g55655 = IN.ase_texcoord9.xyz;
				float3 WorldPosition3905_g55655 = vertexToFrag3890_g55655;
				float3 vertexToFrag4224_g55655 = IN.ase_texcoord10.xyz;
				half3 ObjectData20_g62665 = vertexToFrag4224_g55655;
				half3 WorldData19_g62665 = vertexToFrag3890_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62665 = WorldData19_g62665;
				#else
				float3 staticSwitch14_g62665 = ObjectData20_g62665;
				#endif
				float3 ObjectPosition4223_g55655 = staticSwitch14_g62665;
				float3 lerpResult4822_g55655 = lerp( WorldPosition3905_g55655 , ObjectPosition4223_g55655 , _ColorsPositionMode);
				float3 Position58_g62668 = lerpResult4822_g55655;
				float temp_output_82_0_g62668 = _LayerColorsValue;
				float4 lerpResult88_g62668 = lerp( TVE_ColorsParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ColorsTex, samplerTVE_ColorsTex, ( (temp_output_91_19_g62668).zw + ( (temp_output_91_19_g62668).xy * (Position58_g62668).xz ) ),temp_output_82_0_g62668 ) , TVE_ColorsUsage[(int)temp_output_82_0_g62668]);
				half Global_ColorsTex_A1701_g55655 = (lerpResult88_g62668).a;
				half Global_Colors_Influence3668_g55655 = saturate( Global_ColorsTex_A1701_g55655 );
				float3 lerpResult3618_g55655 = lerp( Blend_AlbedoTinted2808_g55655 , temp_cast_0 , Global_Colors_Influence3668_g55655);
				half3 Global_ColorsTex_RGB1700_g55655 = (lerpResult88_g62668).rgb;
				#ifdef UNITY_COLORSPACE_GAMMA
				float staticSwitch1_g62681 = 2.0;
				#else
				float staticSwitch1_g62681 = 4.594794;
				#endif
				half3 Global_Colors1954_g55655 = ( Global_ColorsTex_RGB1700_g55655 * staticSwitch1_g62681 );
				half Global_Colors_Value3650_g55655 = _GlobalColors;
				float4 tex2DNode35_g55655 = tex2D( _MainMaskTex, Main_UVs15_g55655 );
				half Main_Mask57_g55655 = tex2DNode35_g55655.b;
				float temp_output_7_0_g62654 = _ColorsMaskMinValue;
				half Global_Colors_Mask3692_g55655 = saturate( ( ( Main_Mask57_g55655 - temp_output_7_0_g62654 ) / ( _ColorsMaskMaxValue - temp_output_7_0_g62654 ) ) );
				float lerpResult16_g62624 = lerp( 0.0 , ( Global_Colors_Value3650_g55655 * Global_Colors_Mask3692_g55655 ) , TVE_Enabled);
				float3 lerpResult3628_g55655 = lerp( Blend_AlbedoTinted2808_g55655 , ( lerpResult3618_g55655 * Global_Colors1954_g55655 ) , lerpResult16_g62624);
				half3 Blend_AlbedoColored863_g55655 = lerpResult3628_g55655;
				float3 temp_output_799_0_g55655 = (_SubsurfaceColor).rgb;
				float dotResult3930_g55655 = dot( temp_output_799_0_g55655 , float3(0.2126,0.7152,0.0722) );
				float3 temp_cast_3 = (dotResult3930_g55655).xxx;
				float3 lerpResult3932_g55655 = lerp( temp_output_799_0_g55655 , temp_cast_3 , Global_Colors_Influence3668_g55655);
				float3 lerpResult3942_g55655 = lerp( temp_output_799_0_g55655 , ( lerpResult3932_g55655 * Global_Colors1954_g55655 ) , ( Global_Colors_Value3650_g55655 * Global_Colors_Mask3692_g55655 ));
				half3 Subsurface_Color1722_g55655 = lerpResult3942_g55655;
				half MainLight_Subsurface4041_g55655 = TVE_MainLightParams.a;
				half Subsurface_Intensity1752_g55655 = ( _SubsurfaceValue * MainLight_Subsurface4041_g55655 );
				float temp_output_7_0_g62675 = _SubsurfaceMaskMinValue;
				half Subsurface_Mask1557_g55655 = saturate( ( ( Main_Mask57_g55655 - temp_output_7_0_g62675 ) / ( _SubsurfaceMaskMaxValue - temp_output_7_0_g62675 ) ) );
				half3 Subsurface_Transmission884_g55655 = ( Subsurface_Color1722_g55655 * Subsurface_Intensity1752_g55655 * Subsurface_Mask1557_g55655 );
				half3 MainLight_Direction3926_g55655 = TVE_MainLightDirection;
				float3 normalizeResult2169_g55655 = normalize( WorldViewDirection );
				float3 ViewDir_Normalized3963_g55655 = normalizeResult2169_g55655;
				float dotResult785_g55655 = dot( -MainLight_Direction3926_g55655 , ViewDir_Normalized3963_g55655 );
				float saferPower1624_g55655 = abs( (dotResult785_g55655*0.5 + 0.5) );
				#ifdef UNITY_PASS_FORWARDADD
				float staticSwitch1602_g55655 = 0.0;
				#else
				float staticSwitch1602_g55655 = ( pow( saferPower1624_g55655 , _MainLightAngleValue ) * _MainLightScatteringValue );
				#endif
				half Mask_Subsurface_View782_g55655 = staticSwitch1602_g55655;
				half3 Subsurface_Scattering1693_g55655 = ( Subsurface_Transmission884_g55655 * Blend_AlbedoColored863_g55655 * Mask_Subsurface_View782_g55655 );
				half3 Blend_AlbedoAndSubsurface149_g55655 = ( Blend_AlbedoColored863_g55655 + Subsurface_Scattering1693_g55655 );
				half3 Global_OverlayColor1758_g55655 = (TVE_OverlayColor).rgb;
				half Main_AlbedoTex_G3526_g55655 = tex2DNode29_g55655.g;
				float4 temp_output_93_19_g62635 = TVE_ExtrasCoords;
				float3 lerpResult4827_g55655 = lerp( WorldPosition3905_g55655 , ObjectPosition4223_g55655 , _ExtrasPositionMode);
				float3 Position82_g62635 = lerpResult4827_g55655;
				float temp_output_84_0_g62635 = _LayerExtrasValue;
				float4 lerpResult88_g62635 = lerp( TVE_ExtrasParams , SAMPLE_TEXTURE2D_ARRAY( TVE_ExtrasTex, samplerTVE_ExtrasTex, ( (temp_output_93_19_g62635).zw + ( (temp_output_93_19_g62635).xy * (Position82_g62635).xz ) ),temp_output_84_0_g62635 ) , TVE_ExtrasUsage[(int)temp_output_84_0_g62635]);
				float4 break89_g62635 = lerpResult88_g62635;
				half Global_Extras_Overlay156_g55655 = break89_g62635.b;
				half Overlay_Variation4560_g55655 = 1.0;
				half Overlay_Commons1365_g55655 = ( _GlobalOverlay * Global_Extras_Overlay156_g55655 * Overlay_Variation4560_g55655 );
				float temp_output_7_0_g62666 = _OverlayMaskMinValue;
				half Overlay_Mask269_g55655 = saturate( ( ( ( ( 0.5 + Main_AlbedoTex_G3526_g55655 ) * Overlay_Commons1365_g55655 ) - temp_output_7_0_g62666 ) / ( _OverlayMaskMaxValue - temp_output_7_0_g62666 ) ) );
				float3 lerpResult336_g55655 = lerp( Blend_AlbedoAndSubsurface149_g55655 , Global_OverlayColor1758_g55655 , Overlay_Mask269_g55655);
				half3 Final_Albedo359_g55655 = lerpResult336_g55655;
				
				float3 unpack4112_g55655 = UnpackNormalScale( tex2D( _MainNormalTex, Main_UVs15_g55655 ), _MainNormalValue );
				unpack4112_g55655.z = lerp( 1, unpack4112_g55655.z, saturate(_MainNormalValue) );
				half3 Main_Normal137_g55655 = unpack4112_g55655;
				float3 temp_output_13_0_g62598 = Main_Normal137_g55655;
				float3 switchResult12_g62598 = (((ase_vface>0)?(temp_output_13_0_g62598):(( temp_output_13_0_g62598 * _render_normals_options ))));
				half3 Blend_Normal312_g55655 = switchResult12_g62598;
				half3 Final_Normal366_g55655 = Blend_Normal312_g55655;
				
				float4 temp_output_4214_0_g55655 = ( _EmissiveColor * _EmissiveIntensityParams.x );
				float2 vertexToFrag11_g62644 = IN.ase_texcoord11.xy;
				half2 Emissive_UVs2468_g55655 = vertexToFrag11_g62644;
				half Global_Extras_Emissive4203_g55655 = break89_g62635.r;
				float lerpResult4206_g55655 = lerp( 1.0 , Global_Extras_Emissive4203_g55655 , _GlobalEmissive);
				half3 Final_Emissive2476_g55655 = ( (( temp_output_4214_0_g55655 * tex2D( _EmissiveTex, Emissive_UVs2468_g55655 ) )).rgb * lerpResult4206_g55655 );
				
				float3 temp_cast_7 = (( 0.04 * _RenderSpecular )).xxx;
				
				half Main_Smoothness227_g55655 = ( tex2DNode35_g55655.a * _MainSmoothnessValue );
				half Blend_Smoothness314_g55655 = Main_Smoothness227_g55655;
				half Global_OverlaySmoothness311_g55655 = TVE_OverlaySmoothness;
				float lerpResult343_g55655 = lerp( Blend_Smoothness314_g55655 , Global_OverlaySmoothness311_g55655 , Overlay_Mask269_g55655);
				half Final_Smoothness371_g55655 = lerpResult343_g55655;
				half Global_Extras_Wetness305_g55655 = break89_g62635.g;
				float lerpResult3673_g55655 = lerp( 0.0 , Global_Extras_Wetness305_g55655 , _GlobalWetness);
				half Final_SmoothnessAndWetness4130_g55655 = saturate( ( Final_Smoothness371_g55655 + lerpResult3673_g55655 ) );
				
				float lerpResult240_g55655 = lerp( 1.0 , tex2DNode35_g55655.g , _MainOcclusionValue);
				half Main_Occlusion247_g55655 = lerpResult240_g55655;
				half Blend_Occlusion323_g55655 = Main_Occlusion247_g55655;
				
				float localCustomAlphaClip3735_g55655 = ( 0.0 );
				float3 normalizeResult3971_g55655 = normalize( cross( ddy( WorldPosition ) , ddx( WorldPosition ) ) );
				float3 NormalsWS_Derivates3972_g55655 = normalizeResult3971_g55655;
				float dotResult2161_g55655 = dot( ViewDir_Normalized3963_g55655 , NormalsWS_Derivates3972_g55655 );
				float dotResult2212_g55655 = dot( ViewDir_Normalized3963_g55655 , float3(0,1,0) );
				half Mask_HView2656_g55655 = dotResult2212_g55655;
				float lerpResult2221_g55655 = lerp( _FadeHorizontalValue , _FadeVerticalValue , Mask_HView2656_g55655);
				float lerpResult3992_g55655 = lerp( 1.0 , saturate( abs( dotResult2161_g55655 ) ) , lerpResult2221_g55655);
				half Fade_Billboard2175_g55655 = lerpResult3992_g55655;
				float temp_output_41_0_g62674 = ( 1.0 * Fade_Billboard2175_g55655 );
				half Final_AlphaFade3727_g55655 = saturate( ( temp_output_41_0_g62674 + ( temp_output_41_0_g62674 * tex3D( TVE_ScreenTex3D, ( TVE_ScreenTexCoord * WorldPosition3905_g55655 ) ).r ) ) );
				float Main_Alpha316_g55655 = ( _MainColor.a * tex2DNode29_g55655.a );
				half AlphaTreshold2132_g55655 = _Cutoff;
				#ifdef TVE_ALPHA_CLIP
				float staticSwitch3792_g55655 = ( Main_Alpha316_g55655 - ( AlphaTreshold2132_g55655 - 0.5 ) );
				#else
				float staticSwitch3792_g55655 = Main_Alpha316_g55655;
				#endif
				half Final_Alpha3754_g55655 = staticSwitch3792_g55655;
				float temp_output_661_0_g55655 = ( Final_AlphaFade3727_g55655 * Final_Alpha3754_g55655 );
				float Alpha3735_g55655 = temp_output_661_0_g55655;
				float Treshold3735_g55655 = 0.5;
				{
				#if TVE_ALPHA_CLIP
				clip(Alpha3735_g55655 - Treshold3735_g55655);
				#endif
				}
				half Final_Clip914_g55655 = saturate( Alpha3735_g55655 );
				
				float3 Albedo = Final_Albedo359_g55655;
				float3 Normal = Final_Normal366_g55655;
				float3 Emission = Final_Emissive2476_g55655;
				float3 Specular = temp_cast_7;
				float Metallic = 0;
				float Smoothness = Final_SmoothnessAndWetness4130_g55655;
				float Occlusion = Blend_Occlusion323_g55655;
				float Alpha = Final_Clip914_g55655;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;
				float3 BakedGI = 0;
				float3 RefractionColor = 1;
				float RefractionIndex = 1;
				float3 Transmission = 1;
				float3 Translucency = 1;
				#ifdef ASE_DEPTH_WRITE_ON
				float DepthValue = 0;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				InputData inputData = (InputData)0;
				inputData.positionWS = WorldPosition;
				inputData.positionCS = IN.clipPos;
				inputData.shadowCoord = ShadowCoords;



				#ifdef _NORMALMAP
					#if _NORMAL_DROPOFF_TS
					inputData.normalWS = TransformTangentToWorld(Normal, half3x3( WorldTangent, WorldBiTangent, WorldNormal ));
					#elif _NORMAL_DROPOFF_OS
					inputData.normalWS = TransformObjectToWorldNormal(Normal);
					#elif _NORMAL_DROPOFF_WS
					inputData.normalWS = Normal;
					#endif
				#else
					inputData.normalWS = WorldNormal;
				#endif
					
				inputData.normalWS = NormalizeNormalPerPixel(inputData.normalWS);
				inputData.viewDirectionWS = SafeNormalize( WorldViewDirection );



				#ifdef ASE_FOG
					inputData.fogCoord = InitializeInputDataFog(float4(WorldPosition, 1.0),  IN.fogFactorAndVertexLight.x);
				#endif

				inputData.vertexLighting = IN.fogFactorAndVertexLight.yzw;

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float3 SH = SampleSH(inputData.normalWS.xyz);
				#else
					float3 SH = IN.lightmapUVOrVertexSH.xyz;
				#endif

				

				#ifdef _ASE_BAKEDGI
					inputData.bakedGI = BakedGI;
				#else
					#if defined(DYNAMICLIGHTMAP_ON)
						inputData.bakedGI = SAMPLE_GI( IN.lightmapUVOrVertexSH.xy, IN.dynamicLightmapUV.xy, SH, inputData.normalWS);
					#else
						inputData.bakedGI = SAMPLE_GI( IN.lightmapUVOrVertexSH.xy, SH, inputData.normalWS );
					#endif
				#endif

				inputData.normalizedScreenSpaceUV = GetNormalizedScreenSpaceUV(IN.clipPos);
				inputData.shadowMask = SAMPLE_SHADOWMASK(IN.lightmapUVOrVertexSH.xy);

				#if defined(DEBUG_DISPLAY)
					#if defined(DYNAMICLIGHTMAP_ON)
						inputData.dynamicLightmapUV = IN.dynamicLightmapUV.xy;
						#endif
					#if defined(LIGHTMAP_ON)
						inputData.staticLightmapUV = IN.lightmapUVOrVertexSH.xy;
					#else
						inputData.vertexSH = SH;
					#endif
				#endif

				#ifdef _DBUFFER
					ApplyDecal(IN.clipPos,
						Albedo,
						Specular,
						inputData.normalWS,
						Metallic,
						Occlusion,
						Smoothness);
				#endif

				BRDFData brdfData;
				InitializeBRDFData
				(Albedo, Metallic, Specular, Smoothness, Alpha, brdfData);

				Light mainLight = GetMainLight(inputData.shadowCoord, inputData.positionWS, inputData.shadowMask);
				half4 color;
				MixRealtimeAndBakedGI(mainLight, inputData.normalWS, inputData.bakedGI, inputData.shadowMask);
				color.rgb = GlobalIllumination(brdfData, inputData.bakedGI, Occlusion, inputData.positionWS, inputData.normalWS, inputData.viewDirectionWS);
				color.a = Alpha;
				
				#ifdef ASE_FINAL_COLOR_ALPHA_MULTIPLY
					color.rgb *= color.a;
				#endif
				
				#ifdef ASE_FOG
					#ifdef TERRAIN_SPLAT_ADDPASS
						color.rgb = MixFogColor(color.rgb, half3( 0, 0, 0 ), IN.fogFactorAndVertexLight.x );
					#else
						color.rgb = MixFog(color.rgb, IN.fogFactorAndVertexLight.x);
					#endif
				#endif
				
				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif
				
				return BRDFDataToGbuffer(brdfData, inputData, Smoothness, Emission + color.rgb);
			}

			ENDHLSL
		}

		
        Pass
        {
			
            Name "SceneSelectionPass"
            Tags { "LightMode"="SceneSelectionPass" }
        
			Cull Off

			HLSLPROGRAM
        
			#define _SPECULAR_SETUP 1
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#pragma multi_compile _ DOTS_INSTANCING_ON
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 120100

        
			#pragma only_renderers d3d11 glcore gles gles3 
			#pragma vertex vert
			#pragma fragment frag

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define SHADERPASS SHADERPASS_DEPTHONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
			#define ASE_NEEDS_VERT_POSITION
			#pragma shader_feature_local TVE_ALPHA_CLIP
			#pragma shader_feature_local TVE_VERTEX_DATA_BATCHED
			//TVE Shader Type Defines
			#define TVE_IS_VEGETATION_SHADER
			//TVE Pipeline Defines
			#define THE_VEGETATION_ENGINE
			#define TVE_IS_UNIVERSAL_PIPELINE
			//TVE Injection Defines
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
        
			CBUFFER_START(UnityPerMaterial)
			float4 _GradientMaskRemap;
			half4 _SubsurfaceColor;
			half4 _ColorsMaskRemap;
			half4 _VertexOcclusionRemap;
			float4 _NoiseMaskRemap;
			half4 _OverlayMaskRemap;
			half4 _SubsurfaceMaskRemap;
			float4 _Color;
			half4 _AlphaMaskRemap;
			half4 _NoiseColorTwo;
			half4 _GradientColorTwo;
			half4 _GradientColorOne;
			float4 _SubsurfaceDiffusion_asset;
			float4 _EmissiveIntensityParams;
			half4 _EmissiveUVs;
			half4 _DetailBlendRemap;
			float4 _MaxBoundsInfo;
			half4 _MainUVs;
			half4 _LeavesMaskRemap;
			half4 _MainColor;
			float4 _SubsurfaceDiffusion_Asset;
			half4 _NoiseColorOne;
			half4 _EmissiveColor;
			half3 _render_normals_options;
			half _GradientMaxValue;
			half _InteractionMaskValue;
			half _GlobalSize;
			half _LayerVertexValue;
			half _VertexDataMode;
			half _InteractionAmplitude;
			float _MotionScale_10;
			half _VertexDynamicMode;
			half _MotionVariation_10;
			float _MotionSpeed_10;
			half _MotionAmplitude_10;
			half _LayerMotionValue;
			half _render_zw;
			half _IsStandardShader;
			half _GradientMinValue;
			half _render_src;
			half _ColorsPositionMode;
			half _NoiseMinValue;
			half _MainOcclusionValue;
			half _GlobalWetness;
			half _MainSmoothnessValue;
			half _RenderSpecular;
			half _GlobalEmissive;
			half _MainNormalValue;
			half _OverlayMaskMaxValue;
			half _OverlayMaskMinValue;
			half _LayerExtrasValue;
			half _ExtrasPositionMode;
			half _NoiseScaleValue;
			half _GlobalOverlay;
			half _MainLightAngleValue;
			half _SubsurfaceMaskMaxValue;
			half _SubsurfaceMaskMinValue;
			half _SubsurfaceValue;
			half _ColorsMaskMaxValue;
			half _ColorsMaskMinValue;
			half _GlobalColors;
			half _LayerColorsValue;
			half _IsCrossShader;
			half _NoiseMaxValue;
			half _MainLightScatteringValue;
			half _SpaceMotionHighlight;
			half _SpaceGlobalPosition;
			half _DetailTypeMode;
			half _RenderPriority;
			half _RenderZWrite;
			half _HasGradient;
			float _SubsurfaceDiffusion;
			half _IsVersion;
			half _MotionCat;
			half _DetailBlendMode;
			half _SpaceRenderReceive;
			half _RenderCull;
			half _HasEmissive;
			half _VertexMasksMode;
			half _SizeFadeCat;
			half _SubsurfaceCat;
			half _PerspectiveCat;
			half _DetailCat;
			half _RenderingCat;
			half _RenderMode;
			half _GradientCat;
			half _DetailMode;
			half _EmissiveCat;
			half _RenderQueue;
			half _render_dst;
			half _render_cull;
			half _GlobalCat;
			half _RenderNormals;
			half _SpaceRenderFade;
			half _OcclusionCat;
			half _MessageTranslucencyHD;
			half _TranslucencyDirectValue;
			half _SpaceMotionLocals;
			half _TranslucencyShadowValue;
			half _FadeHorizontalValue;
			half _SpaceGlobalLayers;
			half _IsTVEShader;
			half _MessageSizeFade;
			half _TranslucencyAmbientValue;
			half _TranslucencyIntensityValue;
			half _RenderSSR;
			half _RenderDecals;
			half _TranslucencyScatteringValue;
			half _TranslucencyNormalValue;
			half _MessageMotionVariation;
			half _VertexVariationMode;
			half _MessageGlobalsVariation;
			half _MainCat;
			half _VertexRollingMode;
			half _Cutoff;
			half _NoiseCat;
			half _EmissiveFlagMode;
			half _HasOcclusion;
			half _LayerReactValue;
			half _RenderClip;
			half _FadeVerticalValue;
			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _MainTex;
			half TVE_Enabled;
			sampler2D _BumpMap;
			half4 TVE_MotionParams;
			TEXTURE2D_ARRAY(TVE_MotionTex);
			half4 TVE_MotionCoords;
			SAMPLER(samplerTVE_MotionTex);
			float TVE_MotionUsage[10];
			half4 TVE_MotionParamsMin;
			half4 TVE_MotionParamsMax;
			sampler2D TVE_NoiseTex;
			half4 TVE_NoiseParams;
			half4 TVE_VertexParams;
			TEXTURE2D_ARRAY(TVE_VertexTex);
			half4 TVE_VertexCoords;
			SAMPLER(samplerTVE_VertexTex);
			float TVE_VertexUsage[10];
			half _DisableSRPBatcher;
			sampler3D TVE_ScreenTex3D;
			half TVE_ScreenTexCoord;
			sampler2D _MainAlbedoTex;


			
			int _ObjectId;
			int _PassValue;

			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};
        
			VertexOutput VertexFunction(VertexInput v  )
			{
				VertexOutput o;
				ZERO_INITIALIZE(VertexOutput, o);

				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);


				float3 VertexPosition3588_g55655 = v.vertex.xyz;
				half3 Mesh_PivotsOS2291_g55655 = half3(0,0,0);
				float3 temp_output_2283_0_g55655 = ( VertexPosition3588_g55655 - Mesh_PivotsOS2291_g55655 );
				half3 VertexPos40_g62634 = temp_output_2283_0_g55655;
				float3 appendResult74_g62634 = (float3(VertexPos40_g62634.x , 0.0 , 0.0));
				half3 VertexPosRotationAxis50_g62634 = appendResult74_g62634;
				float3 break84_g62634 = VertexPos40_g62634;
				float3 appendResult81_g62634 = (float3(0.0 , break84_g62634.y , break84_g62634.z));
				half3 VertexPosOtherAxis82_g62634 = appendResult81_g62634;
				float4 temp_output_91_19_g62645 = TVE_MotionCoords;
				float4x4 break19_g62677 = GetObjectToWorldMatrix();
				float3 appendResult20_g62677 = (float3(break19_g62677[ 0 ][ 3 ] , break19_g62677[ 1 ][ 3 ] , break19_g62677[ 2 ][ 3 ]));
				half3 ObjectData20_g62678 = appendResult20_g62677;
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				half3 WorldData19_g62678 = ase_worldPos;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62678 = WorldData19_g62678;
				#else
				float3 staticSwitch14_g62678 = ObjectData20_g62678;
				#endif
				float3 temp_output_114_0_g62677 = staticSwitch14_g62678;
				float3 vertexToFrag4224_g55655 = temp_output_114_0_g62677;
				half3 ObjectData20_g62665 = vertexToFrag4224_g55655;
				float3 vertexToFrag3890_g55655 = ase_worldPos;
				half3 WorldData19_g62665 = vertexToFrag3890_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62665 = WorldData19_g62665;
				#else
				float3 staticSwitch14_g62665 = ObjectData20_g62665;
				#endif
				float3 ObjectPosition4223_g55655 = staticSwitch14_g62665;
				float3 Position83_g62645 = ObjectPosition4223_g55655;
				float temp_output_84_0_g62645 = _LayerMotionValue;
				float4 lerpResult87_g62645 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, samplerTVE_MotionTex, ( (temp_output_91_19_g62645).zw + ( (temp_output_91_19_g62645).xy * (Position83_g62645).xz ) ),temp_output_84_0_g62645, 0.0 ) , TVE_MotionUsage[(int)temp_output_84_0_g62645]);
				half4 Global_Motion_Params3909_g55655 = lerpResult87_g62645;
				float4 break322_g62615 = Global_Motion_Params3909_g55655;
				float3 appendResult397_g62615 = (float3(break322_g62615.x , 0.0 , break322_g62615.y));
				float3 temp_output_398_0_g62615 = (appendResult397_g62615*2.0 + -1.0);
				float3 ase_parentObjectScale = ( 1.0 / float3( length( GetWorldToObjectMatrix()[ 0 ].xyz ), length( GetWorldToObjectMatrix()[ 1 ].xyz ), length( GetWorldToObjectMatrix()[ 2 ].xyz ) ) );
				half2 Global_MotionDirectionOS39_g55655 = (( mul( GetWorldToObjectMatrix(), float4( temp_output_398_0_g62615 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half ObjectData20_g62639 = 3.14;
				float Bounds_Height374_g55655 = _MaxBoundsInfo.y;
				half WorldData19_g62639 = ( Bounds_Height374_g55655 * 3.14 );
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62639 = WorldData19_g62639;
				#else
				float staticSwitch14_g62639 = ObjectData20_g62639;
				#endif
				float Motion_Max_Bending1133_g55655 = staticSwitch14_g62639;
				half Mesh_Motion_1082_g55655 = v.ase_texcoord3.x;
				half Motion_10_Mask4617_g55655 = ( _MotionAmplitude_10 * Motion_Max_Bending1133_g55655 * Mesh_Motion_1082_g55655 );
				half Input_Speed62_g62605 = _MotionSpeed_10;
				float mulTime373_g62605 = _TimeParameters.x * Input_Speed62_g62605;
				float3 break111_g62621 = ObjectPosition4223_g55655;
				float Mesh_Variation16_g55655 = v.ase_color.r;
				half VertexDynamicMode4798_g55655 = _VertexDynamicMode;
				float lerpResult4795_g55655 = lerp( frac( ( v.ase_color.r + ( break111_g62621.x + break111_g62621.z ) ) ) , Mesh_Variation16_g55655 , VertexDynamicMode4798_g55655);
				half ObjectData20_g62614 = lerpResult4795_g55655;
				half WorldData19_g62614 = Mesh_Variation16_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62614 = WorldData19_g62614;
				#else
				float staticSwitch14_g62614 = ObjectData20_g62614;
				#endif
				half Motion_Variation3073_g55655 = staticSwitch14_g62614;
				half Motion_10_Variation4581_g55655 = ( _MotionVariation_10 * Motion_Variation3073_g55655 );
				half Motion_Variation284_g62605 = Motion_10_Variation4581_g55655;
				float Motion_Scale287_g62605 = ( _MotionScale_10 * ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z ) );
				half Sine_MinusOneToOne281_g62605 = sin( ( mulTime373_g62605 + Motion_Variation284_g62605 + Motion_Scale287_g62605 ) );
				half Input_WindSquash419_g62605 = 0.2;
				half Wind_Power369_g62615 = break322_g62615.z;
				float lerpResult376_g62615 = lerp( TVE_MotionParamsMin.x , TVE_MotionParamsMax.x , Wind_Power369_g62615);
				half Wind_Stop420_g62615 = saturate( ( Wind_Power369_g62615 * 10.0 ) );
				half Global_MotionPower_103106_g55655 = ( lerpResult376_g62615 * Wind_Stop420_g62615 );
				half Input_WindPower327_g62605 = Global_MotionPower_103106_g55655;
				float lerpResult321_g62605 = lerp( Sine_MinusOneToOne281_g62605 , (Sine_MinusOneToOne281_g62605*Input_WindSquash419_g62605 + 1.0) , Input_WindPower327_g62605);
				half Motion_10_SinWaveAm4570_g55655 = lerpResult321_g62605;
				float2 panner437_g62615 = ( _TimeParameters.x * (TVE_NoiseParams).xy + ( (ObjectPosition4223_g55655).xz * TVE_NoiseParams.z ));
				float saferPower446_g62615 = abs( abs( tex2Dlod( TVE_NoiseTex, float4( panner437_g62615, 0, 0.0) ).r ) );
				float lerpResult448_g62615 = lerp( TVE_MotionParamsMin.w , TVE_MotionParamsMax.w , Wind_Power369_g62615);
				half Global_MotionNoise34_g55655 = pow( saferPower446_g62615 , lerpResult448_g62615 );
				half Motion_10_Bending2258_g55655 = ( Motion_10_Mask4617_g55655 * Motion_10_SinWaveAm4570_g55655 * Global_MotionPower_103106_g55655 * Global_MotionNoise34_g55655 );
				half Interaction_Amplitude4137_g55655 = _InteractionAmplitude;
				float lerpResult4494_g55655 = lerp( 1.0 , Mesh_Motion_1082_g55655 , _InteractionMaskValue);
				half ObjectData20_g62620 = lerpResult4494_g55655;
				half WorldData19_g62620 = Mesh_Motion_1082_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62620 = WorldData19_g62620;
				#else
				float staticSwitch14_g62620 = ObjectData20_g62620;
				#endif
				half Motion_10_Interaction53_g55655 = ( Interaction_Amplitude4137_g55655 * Motion_Max_Bending1133_g55655 * staticSwitch14_g62620 );
				half Global_InteractionMask66_g55655 = ( break322_g62615.w * break322_g62615.w );
				float lerpResult4685_g55655 = lerp( Motion_10_Bending2258_g55655 , Motion_10_Interaction53_g55655 , saturate( ( Global_InteractionMask66_g55655 * Interaction_Amplitude4137_g55655 ) ));
				float2 break4603_g55655 = ( Global_MotionDirectionOS39_g55655 * lerpResult4685_g55655 );
				half Vertex_ZAxisRotatin190_g55655 = break4603_g55655.y;
				half Angle44_g62634 = Vertex_ZAxisRotatin190_g55655;
				half3 VertexPos40_g62631 = ( VertexPosRotationAxis50_g62634 + ( VertexPosOtherAxis82_g62634 * cos( Angle44_g62634 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g62634 ) * sin( Angle44_g62634 ) ) );
				float3 appendResult74_g62631 = (float3(0.0 , 0.0 , VertexPos40_g62631.z));
				half3 VertexPosRotationAxis50_g62631 = appendResult74_g62631;
				float3 break84_g62631 = VertexPos40_g62631;
				float3 appendResult81_g62631 = (float3(break84_g62631.x , break84_g62631.y , 0.0));
				half3 VertexPosOtherAxis82_g62631 = appendResult81_g62631;
				half Vertex_XAxisRotation216_g55655 = break4603_g55655.x;
				half Angle44_g62631 = -Vertex_XAxisRotation216_g55655;
				float3 Vertex_Motion_Object833_g55655 = ( VertexPosRotationAxis50_g62631 + ( VertexPosOtherAxis82_g62631 * cos( Angle44_g62631 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g62631 ) * sin( Angle44_g62631 ) ) );
				float3 temp_output_3474_0_g55655 = ( VertexPosition3588_g55655 - Mesh_PivotsOS2291_g55655 );
				float3 appendResult2043_g55655 = (float3(Vertex_XAxisRotation216_g55655 , 0.0 , Vertex_ZAxisRotatin190_g55655));
				float3 Vertex_Motion_World1118_g55655 = ( temp_output_3474_0_g55655 + appendResult2043_g55655 );
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch3312_g55655 = Vertex_Motion_World1118_g55655;
				#else
				float3 staticSwitch3312_g55655 = ( Vertex_Motion_Object833_g55655 + ( 0.0 * _VertexDataMode ) );
				#endif
				float4 temp_output_94_19_g62640 = TVE_VertexCoords;
				float3 Position83_g62640 = ObjectPosition4223_g55655;
				float temp_output_84_0_g62640 = _LayerVertexValue;
				float4 lerpResult87_g62640 = lerp( TVE_VertexParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, samplerTVE_VertexTex, ( (temp_output_94_19_g62640).zw + ( (temp_output_94_19_g62640).xy * (Position83_g62640).xz ) ),temp_output_84_0_g62640, 0.0 ) , TVE_VertexUsage[(int)temp_output_84_0_g62640]);
				half4 Global_Object_Params4173_g55655 = lerpResult87_g62640;
				half Global_VertexSize174_g55655 = Global_Object_Params4173_g55655.w;
				float lerpResult16_g62663 = lerp( 0.0 , _GlobalSize , TVE_Enabled);
				float lerpResult346_g55655 = lerp( 1.0 , Global_VertexSize174_g55655 , lerpResult16_g62663);
				float3 appendResult3480_g55655 = (float3(lerpResult346_g55655 , lerpResult346_g55655 , lerpResult346_g55655));
				half3 ObjectData20_g62676 = appendResult3480_g55655;
				half3 _Vector11 = half3(1,1,1);
				half3 WorldData19_g62676 = _Vector11;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62676 = WorldData19_g62676;
				#else
				float3 staticSwitch14_g62676 = ObjectData20_g62676;
				#endif
				half3 Vertex_Size1741_g55655 = staticSwitch14_g62676;
				half3 _Vector5 = half3(1,1,1);
				float3 Vertex_SizeFade1740_g55655 = _Vector5;
				half3 Grass_Perspective2661_g55655 = half3(0,0,0);
				float3 Final_VertexPosition890_g55655 = ( ( ( staticSwitch3312_g55655 * Vertex_Size1741_g55655 * Vertex_SizeFade1740_g55655 ) + Mesh_PivotsOS2291_g55655 + Grass_Perspective2661_g55655 ) + _DisableSRPBatcher );
				
				o.ase_texcoord.xyz = ase_worldPos;
				o.ase_texcoord1.xyz = vertexToFrag3890_g55655;
				float2 vertexToFrag11_g62604 = ( ( v.ase_texcoord.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord2.xy = vertexToFrag11_g62604;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.w = 0;
				o.ase_texcoord1.w = 0;
				o.ase_texcoord2.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = Final_VertexPosition890_g55655;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				o.clipPos = TransformWorldToHClip(positionWS);
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif
			
			half4 frag(VertexOutput IN ) : SV_TARGET
			{
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;
				float localCustomAlphaClip3735_g55655 = ( 0.0 );
				float3 ase_worldPos = IN.ase_texcoord.xyz;
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - ase_worldPos );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 normalizeResult2169_g55655 = normalize( ase_worldViewDir );
				float3 ViewDir_Normalized3963_g55655 = normalizeResult2169_g55655;
				float3 normalizeResult3971_g55655 = normalize( cross( ddy( ase_worldPos ) , ddx( ase_worldPos ) ) );
				float3 NormalsWS_Derivates3972_g55655 = normalizeResult3971_g55655;
				float dotResult2161_g55655 = dot( ViewDir_Normalized3963_g55655 , NormalsWS_Derivates3972_g55655 );
				float dotResult2212_g55655 = dot( ViewDir_Normalized3963_g55655 , float3(0,1,0) );
				half Mask_HView2656_g55655 = dotResult2212_g55655;
				float lerpResult2221_g55655 = lerp( _FadeHorizontalValue , _FadeVerticalValue , Mask_HView2656_g55655);
				float lerpResult3992_g55655 = lerp( 1.0 , saturate( abs( dotResult2161_g55655 ) ) , lerpResult2221_g55655);
				half Fade_Billboard2175_g55655 = lerpResult3992_g55655;
				float temp_output_41_0_g62674 = ( 1.0 * Fade_Billboard2175_g55655 );
				float3 vertexToFrag3890_g55655 = IN.ase_texcoord1.xyz;
				float3 WorldPosition3905_g55655 = vertexToFrag3890_g55655;
				half Final_AlphaFade3727_g55655 = saturate( ( temp_output_41_0_g62674 + ( temp_output_41_0_g62674 * tex3D( TVE_ScreenTex3D, ( TVE_ScreenTexCoord * WorldPosition3905_g55655 ) ).r ) ) );
				float2 vertexToFrag11_g62604 = IN.ase_texcoord2.xy;
				half2 Main_UVs15_g55655 = vertexToFrag11_g62604;
				float4 tex2DNode29_g55655 = tex2D( _MainAlbedoTex, Main_UVs15_g55655 );
				float Main_Alpha316_g55655 = ( _MainColor.a * tex2DNode29_g55655.a );
				half AlphaTreshold2132_g55655 = _Cutoff;
				#ifdef TVE_ALPHA_CLIP
				float staticSwitch3792_g55655 = ( Main_Alpha316_g55655 - ( AlphaTreshold2132_g55655 - 0.5 ) );
				#else
				float staticSwitch3792_g55655 = Main_Alpha316_g55655;
				#endif
				half Final_Alpha3754_g55655 = staticSwitch3792_g55655;
				float temp_output_661_0_g55655 = ( Final_AlphaFade3727_g55655 * Final_Alpha3754_g55655 );
				float Alpha3735_g55655 = temp_output_661_0_g55655;
				float Treshold3735_g55655 = 0.5;
				{
				#if TVE_ALPHA_CLIP
				clip(Alpha3735_g55655 - Treshold3735_g55655);
				#endif
				}
				half Final_Clip914_g55655 = saturate( Alpha3735_g55655 );
				
				surfaceDescription.Alpha = Final_Clip914_g55655;
				surfaceDescription.AlphaClipThreshold = 0.5;


				#if _ALPHATEST_ON
					float alphaClipThreshold = 0.01f;
					#if ALPHA_CLIP_THRESHOLD
						alphaClipThreshold = surfaceDescription.AlphaClipThreshold;
					#endif
					clip(surfaceDescription.Alpha - alphaClipThreshold);
				#endif

				half4 outColor = half4(_ObjectId, _PassValue, 1.0, 1.0);
				return outColor;
			}

			ENDHLSL
        }

		
        Pass
        {
			
            Name "ScenePickingPass"
            Tags { "LightMode"="Picking" }
        
			HLSLPROGRAM

			#define _SPECULAR_SETUP 1
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#pragma multi_compile _ DOTS_INSTANCING_ON
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 120100


			#pragma only_renderers d3d11 glcore gles gles3 
			#pragma vertex vert
			#pragma fragment frag

        
			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define SHADERPASS SHADERPASS_DEPTHONLY
			

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
			#define ASE_NEEDS_VERT_POSITION
			#pragma shader_feature_local TVE_ALPHA_CLIP
			#pragma shader_feature_local TVE_VERTEX_DATA_BATCHED
			//TVE Shader Type Defines
			#define TVE_IS_VEGETATION_SHADER
			//TVE Pipeline Defines
			#define THE_VEGETATION_ENGINE
			#define TVE_IS_UNIVERSAL_PIPELINE
			//TVE Injection Defines
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
        
			CBUFFER_START(UnityPerMaterial)
			float4 _GradientMaskRemap;
			half4 _SubsurfaceColor;
			half4 _ColorsMaskRemap;
			half4 _VertexOcclusionRemap;
			float4 _NoiseMaskRemap;
			half4 _OverlayMaskRemap;
			half4 _SubsurfaceMaskRemap;
			float4 _Color;
			half4 _AlphaMaskRemap;
			half4 _NoiseColorTwo;
			half4 _GradientColorTwo;
			half4 _GradientColorOne;
			float4 _SubsurfaceDiffusion_asset;
			float4 _EmissiveIntensityParams;
			half4 _EmissiveUVs;
			half4 _DetailBlendRemap;
			float4 _MaxBoundsInfo;
			half4 _MainUVs;
			half4 _LeavesMaskRemap;
			half4 _MainColor;
			float4 _SubsurfaceDiffusion_Asset;
			half4 _NoiseColorOne;
			half4 _EmissiveColor;
			half3 _render_normals_options;
			half _GradientMaxValue;
			half _InteractionMaskValue;
			half _GlobalSize;
			half _LayerVertexValue;
			half _VertexDataMode;
			half _InteractionAmplitude;
			float _MotionScale_10;
			half _VertexDynamicMode;
			half _MotionVariation_10;
			float _MotionSpeed_10;
			half _MotionAmplitude_10;
			half _LayerMotionValue;
			half _render_zw;
			half _IsStandardShader;
			half _GradientMinValue;
			half _render_src;
			half _ColorsPositionMode;
			half _NoiseMinValue;
			half _MainOcclusionValue;
			half _GlobalWetness;
			half _MainSmoothnessValue;
			half _RenderSpecular;
			half _GlobalEmissive;
			half _MainNormalValue;
			half _OverlayMaskMaxValue;
			half _OverlayMaskMinValue;
			half _LayerExtrasValue;
			half _ExtrasPositionMode;
			half _NoiseScaleValue;
			half _GlobalOverlay;
			half _MainLightAngleValue;
			half _SubsurfaceMaskMaxValue;
			half _SubsurfaceMaskMinValue;
			half _SubsurfaceValue;
			half _ColorsMaskMaxValue;
			half _ColorsMaskMinValue;
			half _GlobalColors;
			half _LayerColorsValue;
			half _IsCrossShader;
			half _NoiseMaxValue;
			half _MainLightScatteringValue;
			half _SpaceMotionHighlight;
			half _SpaceGlobalPosition;
			half _DetailTypeMode;
			half _RenderPriority;
			half _RenderZWrite;
			half _HasGradient;
			float _SubsurfaceDiffusion;
			half _IsVersion;
			half _MotionCat;
			half _DetailBlendMode;
			half _SpaceRenderReceive;
			half _RenderCull;
			half _HasEmissive;
			half _VertexMasksMode;
			half _SizeFadeCat;
			half _SubsurfaceCat;
			half _PerspectiveCat;
			half _DetailCat;
			half _RenderingCat;
			half _RenderMode;
			half _GradientCat;
			half _DetailMode;
			half _EmissiveCat;
			half _RenderQueue;
			half _render_dst;
			half _render_cull;
			half _GlobalCat;
			half _RenderNormals;
			half _SpaceRenderFade;
			half _OcclusionCat;
			half _MessageTranslucencyHD;
			half _TranslucencyDirectValue;
			half _SpaceMotionLocals;
			half _TranslucencyShadowValue;
			half _FadeHorizontalValue;
			half _SpaceGlobalLayers;
			half _IsTVEShader;
			half _MessageSizeFade;
			half _TranslucencyAmbientValue;
			half _TranslucencyIntensityValue;
			half _RenderSSR;
			half _RenderDecals;
			half _TranslucencyScatteringValue;
			half _TranslucencyNormalValue;
			half _MessageMotionVariation;
			half _VertexVariationMode;
			half _MessageGlobalsVariation;
			half _MainCat;
			half _VertexRollingMode;
			half _Cutoff;
			half _NoiseCat;
			half _EmissiveFlagMode;
			half _HasOcclusion;
			half _LayerReactValue;
			half _RenderClip;
			half _FadeVerticalValue;
			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _MainTex;
			half TVE_Enabled;
			sampler2D _BumpMap;
			half4 TVE_MotionParams;
			TEXTURE2D_ARRAY(TVE_MotionTex);
			half4 TVE_MotionCoords;
			SAMPLER(samplerTVE_MotionTex);
			float TVE_MotionUsage[10];
			half4 TVE_MotionParamsMin;
			half4 TVE_MotionParamsMax;
			sampler2D TVE_NoiseTex;
			half4 TVE_NoiseParams;
			half4 TVE_VertexParams;
			TEXTURE2D_ARRAY(TVE_VertexTex);
			half4 TVE_VertexCoords;
			SAMPLER(samplerTVE_VertexTex);
			float TVE_VertexUsage[10];
			half _DisableSRPBatcher;
			sampler3D TVE_ScreenTex3D;
			half TVE_ScreenTexCoord;
			sampler2D _MainAlbedoTex;


			
        
			float4 _SelectionID;

        
			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};
        
			VertexOutput VertexFunction(VertexInput v  )
			{
				VertexOutput o;
				ZERO_INITIALIZE(VertexOutput, o);

				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);


				float3 VertexPosition3588_g55655 = v.vertex.xyz;
				half3 Mesh_PivotsOS2291_g55655 = half3(0,0,0);
				float3 temp_output_2283_0_g55655 = ( VertexPosition3588_g55655 - Mesh_PivotsOS2291_g55655 );
				half3 VertexPos40_g62634 = temp_output_2283_0_g55655;
				float3 appendResult74_g62634 = (float3(VertexPos40_g62634.x , 0.0 , 0.0));
				half3 VertexPosRotationAxis50_g62634 = appendResult74_g62634;
				float3 break84_g62634 = VertexPos40_g62634;
				float3 appendResult81_g62634 = (float3(0.0 , break84_g62634.y , break84_g62634.z));
				half3 VertexPosOtherAxis82_g62634 = appendResult81_g62634;
				float4 temp_output_91_19_g62645 = TVE_MotionCoords;
				float4x4 break19_g62677 = GetObjectToWorldMatrix();
				float3 appendResult20_g62677 = (float3(break19_g62677[ 0 ][ 3 ] , break19_g62677[ 1 ][ 3 ] , break19_g62677[ 2 ][ 3 ]));
				half3 ObjectData20_g62678 = appendResult20_g62677;
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				half3 WorldData19_g62678 = ase_worldPos;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62678 = WorldData19_g62678;
				#else
				float3 staticSwitch14_g62678 = ObjectData20_g62678;
				#endif
				float3 temp_output_114_0_g62677 = staticSwitch14_g62678;
				float3 vertexToFrag4224_g55655 = temp_output_114_0_g62677;
				half3 ObjectData20_g62665 = vertexToFrag4224_g55655;
				float3 vertexToFrag3890_g55655 = ase_worldPos;
				half3 WorldData19_g62665 = vertexToFrag3890_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62665 = WorldData19_g62665;
				#else
				float3 staticSwitch14_g62665 = ObjectData20_g62665;
				#endif
				float3 ObjectPosition4223_g55655 = staticSwitch14_g62665;
				float3 Position83_g62645 = ObjectPosition4223_g55655;
				float temp_output_84_0_g62645 = _LayerMotionValue;
				float4 lerpResult87_g62645 = lerp( TVE_MotionParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, samplerTVE_MotionTex, ( (temp_output_91_19_g62645).zw + ( (temp_output_91_19_g62645).xy * (Position83_g62645).xz ) ),temp_output_84_0_g62645, 0.0 ) , TVE_MotionUsage[(int)temp_output_84_0_g62645]);
				half4 Global_Motion_Params3909_g55655 = lerpResult87_g62645;
				float4 break322_g62615 = Global_Motion_Params3909_g55655;
				float3 appendResult397_g62615 = (float3(break322_g62615.x , 0.0 , break322_g62615.y));
				float3 temp_output_398_0_g62615 = (appendResult397_g62615*2.0 + -1.0);
				float3 ase_parentObjectScale = ( 1.0 / float3( length( GetWorldToObjectMatrix()[ 0 ].xyz ), length( GetWorldToObjectMatrix()[ 1 ].xyz ), length( GetWorldToObjectMatrix()[ 2 ].xyz ) ) );
				half2 Global_MotionDirectionOS39_g55655 = (( mul( GetWorldToObjectMatrix(), float4( temp_output_398_0_g62615 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half ObjectData20_g62639 = 3.14;
				float Bounds_Height374_g55655 = _MaxBoundsInfo.y;
				half WorldData19_g62639 = ( Bounds_Height374_g55655 * 3.14 );
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62639 = WorldData19_g62639;
				#else
				float staticSwitch14_g62639 = ObjectData20_g62639;
				#endif
				float Motion_Max_Bending1133_g55655 = staticSwitch14_g62639;
				half Mesh_Motion_1082_g55655 = v.ase_texcoord3.x;
				half Motion_10_Mask4617_g55655 = ( _MotionAmplitude_10 * Motion_Max_Bending1133_g55655 * Mesh_Motion_1082_g55655 );
				half Input_Speed62_g62605 = _MotionSpeed_10;
				float mulTime373_g62605 = _TimeParameters.x * Input_Speed62_g62605;
				float3 break111_g62621 = ObjectPosition4223_g55655;
				float Mesh_Variation16_g55655 = v.ase_color.r;
				half VertexDynamicMode4798_g55655 = _VertexDynamicMode;
				float lerpResult4795_g55655 = lerp( frac( ( v.ase_color.r + ( break111_g62621.x + break111_g62621.z ) ) ) , Mesh_Variation16_g55655 , VertexDynamicMode4798_g55655);
				half ObjectData20_g62614 = lerpResult4795_g55655;
				half WorldData19_g62614 = Mesh_Variation16_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62614 = WorldData19_g62614;
				#else
				float staticSwitch14_g62614 = ObjectData20_g62614;
				#endif
				half Motion_Variation3073_g55655 = staticSwitch14_g62614;
				half Motion_10_Variation4581_g55655 = ( _MotionVariation_10 * Motion_Variation3073_g55655 );
				half Motion_Variation284_g62605 = Motion_10_Variation4581_g55655;
				float Motion_Scale287_g62605 = ( _MotionScale_10 * ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z ) );
				half Sine_MinusOneToOne281_g62605 = sin( ( mulTime373_g62605 + Motion_Variation284_g62605 + Motion_Scale287_g62605 ) );
				half Input_WindSquash419_g62605 = 0.2;
				half Wind_Power369_g62615 = break322_g62615.z;
				float lerpResult376_g62615 = lerp( TVE_MotionParamsMin.x , TVE_MotionParamsMax.x , Wind_Power369_g62615);
				half Wind_Stop420_g62615 = saturate( ( Wind_Power369_g62615 * 10.0 ) );
				half Global_MotionPower_103106_g55655 = ( lerpResult376_g62615 * Wind_Stop420_g62615 );
				half Input_WindPower327_g62605 = Global_MotionPower_103106_g55655;
				float lerpResult321_g62605 = lerp( Sine_MinusOneToOne281_g62605 , (Sine_MinusOneToOne281_g62605*Input_WindSquash419_g62605 + 1.0) , Input_WindPower327_g62605);
				half Motion_10_SinWaveAm4570_g55655 = lerpResult321_g62605;
				float2 panner437_g62615 = ( _TimeParameters.x * (TVE_NoiseParams).xy + ( (ObjectPosition4223_g55655).xz * TVE_NoiseParams.z ));
				float saferPower446_g62615 = abs( abs( tex2Dlod( TVE_NoiseTex, float4( panner437_g62615, 0, 0.0) ).r ) );
				float lerpResult448_g62615 = lerp( TVE_MotionParamsMin.w , TVE_MotionParamsMax.w , Wind_Power369_g62615);
				half Global_MotionNoise34_g55655 = pow( saferPower446_g62615 , lerpResult448_g62615 );
				half Motion_10_Bending2258_g55655 = ( Motion_10_Mask4617_g55655 * Motion_10_SinWaveAm4570_g55655 * Global_MotionPower_103106_g55655 * Global_MotionNoise34_g55655 );
				half Interaction_Amplitude4137_g55655 = _InteractionAmplitude;
				float lerpResult4494_g55655 = lerp( 1.0 , Mesh_Motion_1082_g55655 , _InteractionMaskValue);
				half ObjectData20_g62620 = lerpResult4494_g55655;
				half WorldData19_g62620 = Mesh_Motion_1082_g55655;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float staticSwitch14_g62620 = WorldData19_g62620;
				#else
				float staticSwitch14_g62620 = ObjectData20_g62620;
				#endif
				half Motion_10_Interaction53_g55655 = ( Interaction_Amplitude4137_g55655 * Motion_Max_Bending1133_g55655 * staticSwitch14_g62620 );
				half Global_InteractionMask66_g55655 = ( break322_g62615.w * break322_g62615.w );
				float lerpResult4685_g55655 = lerp( Motion_10_Bending2258_g55655 , Motion_10_Interaction53_g55655 , saturate( ( Global_InteractionMask66_g55655 * Interaction_Amplitude4137_g55655 ) ));
				float2 break4603_g55655 = ( Global_MotionDirectionOS39_g55655 * lerpResult4685_g55655 );
				half Vertex_ZAxisRotatin190_g55655 = break4603_g55655.y;
				half Angle44_g62634 = Vertex_ZAxisRotatin190_g55655;
				half3 VertexPos40_g62631 = ( VertexPosRotationAxis50_g62634 + ( VertexPosOtherAxis82_g62634 * cos( Angle44_g62634 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g62634 ) * sin( Angle44_g62634 ) ) );
				float3 appendResult74_g62631 = (float3(0.0 , 0.0 , VertexPos40_g62631.z));
				half3 VertexPosRotationAxis50_g62631 = appendResult74_g62631;
				float3 break84_g62631 = VertexPos40_g62631;
				float3 appendResult81_g62631 = (float3(break84_g62631.x , break84_g62631.y , 0.0));
				half3 VertexPosOtherAxis82_g62631 = appendResult81_g62631;
				half Vertex_XAxisRotation216_g55655 = break4603_g55655.x;
				half Angle44_g62631 = -Vertex_XAxisRotation216_g55655;
				float3 Vertex_Motion_Object833_g55655 = ( VertexPosRotationAxis50_g62631 + ( VertexPosOtherAxis82_g62631 * cos( Angle44_g62631 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g62631 ) * sin( Angle44_g62631 ) ) );
				float3 temp_output_3474_0_g55655 = ( VertexPosition3588_g55655 - Mesh_PivotsOS2291_g55655 );
				float3 appendResult2043_g55655 = (float3(Vertex_XAxisRotation216_g55655 , 0.0 , Vertex_ZAxisRotatin190_g55655));
				float3 Vertex_Motion_World1118_g55655 = ( temp_output_3474_0_g55655 + appendResult2043_g55655 );
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch3312_g55655 = Vertex_Motion_World1118_g55655;
				#else
				float3 staticSwitch3312_g55655 = ( Vertex_Motion_Object833_g55655 + ( 0.0 * _VertexDataMode ) );
				#endif
				float4 temp_output_94_19_g62640 = TVE_VertexCoords;
				float3 Position83_g62640 = ObjectPosition4223_g55655;
				float temp_output_84_0_g62640 = _LayerVertexValue;
				float4 lerpResult87_g62640 = lerp( TVE_VertexParams , SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, samplerTVE_VertexTex, ( (temp_output_94_19_g62640).zw + ( (temp_output_94_19_g62640).xy * (Position83_g62640).xz ) ),temp_output_84_0_g62640, 0.0 ) , TVE_VertexUsage[(int)temp_output_84_0_g62640]);
				half4 Global_Object_Params4173_g55655 = lerpResult87_g62640;
				half Global_VertexSize174_g55655 = Global_Object_Params4173_g55655.w;
				float lerpResult16_g62663 = lerp( 0.0 , _GlobalSize , TVE_Enabled);
				float lerpResult346_g55655 = lerp( 1.0 , Global_VertexSize174_g55655 , lerpResult16_g62663);
				float3 appendResult3480_g55655 = (float3(lerpResult346_g55655 , lerpResult346_g55655 , lerpResult346_g55655));
				half3 ObjectData20_g62676 = appendResult3480_g55655;
				half3 _Vector11 = half3(1,1,1);
				half3 WorldData19_g62676 = _Vector11;
				#ifdef TVE_VERTEX_DATA_BATCHED
				float3 staticSwitch14_g62676 = WorldData19_g62676;
				#else
				float3 staticSwitch14_g62676 = ObjectData20_g62676;
				#endif
				half3 Vertex_Size1741_g55655 = staticSwitch14_g62676;
				half3 _Vector5 = half3(1,1,1);
				float3 Vertex_SizeFade1740_g55655 = _Vector5;
				half3 Grass_Perspective2661_g55655 = half3(0,0,0);
				float3 Final_VertexPosition890_g55655 = ( ( ( staticSwitch3312_g55655 * Vertex_Size1741_g55655 * Vertex_SizeFade1740_g55655 ) + Mesh_PivotsOS2291_g55655 + Grass_Perspective2661_g55655 ) + _DisableSRPBatcher );
				
				o.ase_texcoord.xyz = ase_worldPos;
				o.ase_texcoord1.xyz = vertexToFrag3890_g55655;
				float2 vertexToFrag11_g62604 = ( ( v.ase_texcoord.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord2.xy = vertexToFrag11_g62604;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.w = 0;
				o.ase_texcoord1.w = 0;
				o.ase_texcoord2.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = Final_VertexPosition890_g55655;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				o.clipPos = TransformWorldToHClip(positionWS);
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN ) : SV_TARGET
			{
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;
				float localCustomAlphaClip3735_g55655 = ( 0.0 );
				float3 ase_worldPos = IN.ase_texcoord.xyz;
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - ase_worldPos );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 normalizeResult2169_g55655 = normalize( ase_worldViewDir );
				float3 ViewDir_Normalized3963_g55655 = normalizeResult2169_g55655;
				float3 normalizeResult3971_g55655 = normalize( cross( ddy( ase_worldPos ) , ddx( ase_worldPos ) ) );
				float3 NormalsWS_Derivates3972_g55655 = normalizeResult3971_g55655;
				float dotResult2161_g55655 = dot( ViewDir_Normalized3963_g55655 , NormalsWS_Derivates3972_g55655 );
				float dotResult2212_g55655 = dot( ViewDir_Normalized3963_g55655 , float3(0,1,0) );
				half Mask_HView2656_g55655 = dotResult2212_g55655;
				float lerpResult2221_g55655 = lerp( _FadeHorizontalValue , _FadeVerticalValue , Mask_HView2656_g55655);
				float lerpResult3992_g55655 = lerp( 1.0 , saturate( abs( dotResult2161_g55655 ) ) , lerpResult2221_g55655);
				half Fade_Billboard2175_g55655 = lerpResult3992_g55655;
				float temp_output_41_0_g62674 = ( 1.0 * Fade_Billboard2175_g55655 );
				float3 vertexToFrag3890_g55655 = IN.ase_texcoord1.xyz;
				float3 WorldPosition3905_g55655 = vertexToFrag3890_g55655;
				half Final_AlphaFade3727_g55655 = saturate( ( temp_output_41_0_g62674 + ( temp_output_41_0_g62674 * tex3D( TVE_ScreenTex3D, ( TVE_ScreenTexCoord * WorldPosition3905_g55655 ) ).r ) ) );
				float2 vertexToFrag11_g62604 = IN.ase_texcoord2.xy;
				half2 Main_UVs15_g55655 = vertexToFrag11_g62604;
				float4 tex2DNode29_g55655 = tex2D( _MainAlbedoTex, Main_UVs15_g55655 );
				float Main_Alpha316_g55655 = ( _MainColor.a * tex2DNode29_g55655.a );
				half AlphaTreshold2132_g55655 = _Cutoff;
				#ifdef TVE_ALPHA_CLIP
				float staticSwitch3792_g55655 = ( Main_Alpha316_g55655 - ( AlphaTreshold2132_g55655 - 0.5 ) );
				#else
				float staticSwitch3792_g55655 = Main_Alpha316_g55655;
				#endif
				half Final_Alpha3754_g55655 = staticSwitch3792_g55655;
				float temp_output_661_0_g55655 = ( Final_AlphaFade3727_g55655 * Final_Alpha3754_g55655 );
				float Alpha3735_g55655 = temp_output_661_0_g55655;
				float Treshold3735_g55655 = 0.5;
				{
				#if TVE_ALPHA_CLIP
				clip(Alpha3735_g55655 - Treshold3735_g55655);
				#endif
				}
				half Final_Clip914_g55655 = saturate( Alpha3735_g55655 );
				
				surfaceDescription.Alpha = Final_Clip914_g55655;
				surfaceDescription.AlphaClipThreshold = 0.5;


				#if _ALPHATEST_ON
					float alphaClipThreshold = 0.01f;
					#if ALPHA_CLIP_THRESHOLD
						alphaClipThreshold = surfaceDescription.AlphaClipThreshold;
					#endif
					clip(surfaceDescription.Alpha - alphaClipThreshold);
				#endif

				half4 outColor = 0;
				outColor = _SelectionID;
				
				return outColor;
			}
        
			ENDHLSL
        }
		
	}
	
	CustomEditor "TVEShaderCoreGUI"
	Fallback "Hidden/BOXOPHOBIC/The Vegetation Engine/Fallback"
	
}
/*ASEBEGIN
Version=18934
1920;0;1920;1029;2954.989;987.2749;1;True;False
Node;AmplifyShaderEditor.FunctionNode;274;-2176,384;Inherit;False;Define Shader Vegetation;-1;;47862;b458122dd75182d488380bd0f592b9e6;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;312;-1856,384;Inherit;False;Define Pipeline Universal;-1;;55654;71dc7add32e5f6247b1fb74ecceddd3e;0;0;1;FLOAT;529
Node;AmplifyShaderEditor.RangedFloatNode;20;-1984,-768;Half;False;Property;_render_src;_render_src;208;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-2176,-768;Half;False;Property;_render_cull;_render_cull;207;1;[HideInInspector];Create;True;0;3;Both;0;Back;1;Front;2;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1792,-768;Half;False;Property;_render_dst;_render_dst;209;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;287;-2176,-384;Inherit;False;Base Shader;0;;55655;856f7164d1c579d43a5cf4968a75ca43;82,3880,1,4029,1,4028,1,3900,1,4204,1,3903,1,3904,1,3908,1,4172,1,1300,1,1298,1,4179,1,3586,0,4499,1,3658,1,1708,1,3509,1,1712,2,3873,0,893,0,4544,1,1714,1,1715,1,1717,1,1718,1,916,0,1762,0,1763,0,3568,0,1949,1,1776,0,3475,1,4210,1,1745,1,3479,0,4510,0,3501,1,3221,2,1646,1,1757,0,1271,0,3889,1,2807,1,3886,0,2953,1,3887,0,3243,0,3888,0,3957,1,2172,0,3883,1,3728,0,3949,0,4781,0,2658,0,1742,0,3484,0,3575,0,1735,0,1734,0,1733,0,1736,0,1737,0,878,0,1550,0,4072,0,4067,0,4068,0,4069,0,4070,0,860,1,2261,1,2260,1,2032,0,2054,0,2062,0,2039,0,4177,1,4217,1,3592,1,2750,0,4242,0;0;19;FLOAT3;0;FLOAT3;528;FLOAT3;2489;FLOAT;531;FLOAT;4135;FLOAT;529;FLOAT;3678;FLOAT;530;FLOAT;4127;FLOAT;4122;FLOAT;4134;FLOAT;1235;FLOAT3;1230;FLOAT;1461;FLOAT;1290;FLOAT;721;FLOAT;532;FLOAT;629;FLOAT3;534
Node;AmplifyShaderEditor.RangedFloatNode;81;-2176,-896;Half;False;Property;_IsCrossShader;_IsCrossShader;206;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;129;-1968,-896;Half;False;Property;_IsStandardShader;_IsStandardShader;205;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;313;-1344,-896;Inherit;False;Compile All Shaders;-1;;62686;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;314;-1536,-896;Inherit;False;Compile Core;-1;;62687;634b02fd1f32e6a4c875d8fc2c450956;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1600,-768;Half;False;Property;_render_zw;_render_zw;210;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;305;-1376,-384;Float;False;True;-1;2;TVEShaderCoreGUI;0;20;BOXOPHOBIC/The Vegetation Engine/Default/Cross Standard Lit;28cd5599e02859647ae1798e4fcaef6c;True;Forward;0;1;Forward;19;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;True;True;2;True;10;False;False;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;4;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;True;True;1;1;True;20;0;True;7;1;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;False;False;False;True;1;LightMode=UniversalForward;False;False;0;Hidden/BOXOPHOBIC/The Vegetation Engine/Fallback;0;0;Standard;40;Workflow;0;0;Surface;0;0;  Refraction Model;0;0;  Blend;0;0;Two Sided;0;0;Fragment Normal Space,InvertActionOnDeselection;0;0;Transmission;0;0;  Transmission Shadow;0.5,True,1013;0;Translucency;0;0;  Translucency Strength;1,False,-1;0;  Normal Distortion;0.5,False,-1;0;  Scattering;2,False,-1;0;  Direct;0.9,False,-1;0;  Ambient;0.1,False,-1;0;  Shadow;0.5,False,-1;0;Cast Shadows;1;0;  Use Shadow Threshold;0;0;Receive Shadows;1;0;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;0;_FinalColorxAlpha;0;0;Meta Pass;1;0;Override Baked GI;0;0;Extra Pre Pass;0;0;DOTS Instancing;1;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,-1;0;  Type;0;0;  Tess;16,False,-1;0;  Min;10,False,-1;0;  Max;25,False,-1;0;  Edge Length;16,False,-1;0;  Max Displacement;25,False,-1;0;Write Depth;0;0;  Early Z;0;0;Vertex Position,InvertActionOnDeselection;0;0;Debug Display;0;0;Clear Coat;0;0;0;10;False;True;True;True;True;True;True;True;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;316;-1376,-384;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;GBuffer;0;7;GBuffer;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;True;1;1;True;20;0;True;7;1;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;False;False;False;True;1;LightMode=UniversalGBuffer;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;317;-1376,-304;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;SceneSelectionPass;0;8;SceneSelectionPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=SceneSelectionPass;False;True;4;d3d11;glcore;gles;gles3;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;308;-1376,-384;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;318;-1376,-304;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ScenePickingPass;0;9;ScenePickingPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Picking;False;True;4;d3d11;glcore;gles;gles3;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;304;-1376,-384;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ExtraPrePass;0;0;ExtraPrePass;5;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;0;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;315;-1376,-47;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;DepthNormals;0;6;DepthNormals;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=DepthNormals;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;309;-1376,-384;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;Universal2D;0;5;Universal2D;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;True;1;1;True;20;0;True;7;1;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Universal2D;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;307;-1376,-384;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;False;False;True;False;False;False;False;0;False;-1;False;False;False;False;False;False;False;False;False;True;1;False;-1;False;False;True;1;LightMode=DepthOnly;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;306;-1376,-384;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;False;False;True;False;False;False;False;0;False;-1;False;False;False;False;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=ShadowCaster;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.CommentaryNode;37;-2176,-1024;Inherit;False;1023.392;100;Internal;0;;1,0.252,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;266;-2176,256;Inherit;False;1026.438;100;Features;0;;0,1,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;33;-2176,-512;Inherit;False;1024.392;100;Final;0;;0,1,0.5,1;0;0
WireConnection;305;0;287;0
WireConnection;305;1;287;528
WireConnection;305;2;287;2489
WireConnection;305;9;287;3678
WireConnection;305;4;287;530
WireConnection;305;5;287;531
WireConnection;305;6;287;532
WireConnection;305;8;287;534
ASEEND*/
//CHKSM=3D280239125537E85511D4D37F8C44E675765B0F
