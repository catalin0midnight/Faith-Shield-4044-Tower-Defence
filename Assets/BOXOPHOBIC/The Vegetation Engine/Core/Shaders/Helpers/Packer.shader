// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Vegetation Engine/Helpers/Packer"
{
	Properties
	{
		[HideInInspector]_MainTex("Dummy Texture", 2D) = "white" {}
		[NoScaleOffset]_Packer_TexR("Packer_TexR", 2D) = "white" {}
		[NoScaleOffset]_Packer_TexG("Packer_TexG", 2D) = "white" {}
		[NoScaleOffset]_Packer_TexB("Packer_TexB", 2D) = "white" {}
		[NoScaleOffset]_Packer_TexA("Packer_TexA", 2D) = "white" {}
		[Space(10)]_Packer_FloatR("Packer_FloatR", Range( 0 , 1)) = 0
		_Packer_FloatG("Packer_FloatG", Range( 0 , 1)) = 0
		_Packer_FloatB("Packer_FloatB", Range( 0 , 1)) = 0
		_Packer_FloatA("Packer_FloatA", Range( 0 , 1)) = 0
		[Space(10)]_Packer_Action0B("Packer_Action0B", Float) = 0
		[Space(10)]_Packer_Action1B("Packer_Action1B", Float) = 0
		[Space(10)]_Packer_Action0G("Packer_Action0G", Float) = 0
		[Space(10)]_Packer_Action2B("Packer_Action2B", Float) = 0
		[Space(10)]_Packer_Action2R("Packer_Action2R", Float) = 0
		[Space(10)]_Packer_Action1R("Packer_Action1R", Float) = 0
		[Space(10)]_Packer_Action0A("Packer_Action0A", Float) = 0
		[Space(10)]_Packer_Action2G("Packer_Action2G", Float) = 0
		[Space(10)]_Packer_Action1G("Packer_Action1G", Float) = 0
		[Space(10)]_Packer_Action2A("Packer_Action2A", Float) = 0
		[Space(10)]_Packer_Action0R("Packer_Action0R", Float) = 0
		[Space(10)]_Packer_Action1A("Packer_Action1A", Float) = 0
		[IntRange][Space(10)]_Packer_ChannelR("Packer_ChannelR", Range( 0 , 4)) = 0
		[IntRange]_Packer_ChannelG("Packer_ChannelG", Range( 0 , 4)) = 0
		[IntRange]_Packer_ChannelB("Packer_ChannelB", Range( 0 , 4)) = 0
		[IntRange]_Packer_ChannelA("Packer_ChannelA", Range( 0 , 4)) = 0
		[Space(10)]_Packer_TexR_Space("Packer_TexR_Space", Float) = 1
		_Packer_TexG_Space("Packer_TexG_Space", Float) = 1
		_Packer_TexB_Space("Packer_TexB_Space", Float) = 1
		[ASEEnd]_Packer_TexA_Space("Packer_TexA_Space", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" "PreviewType"="Plane" }
	LOD 0

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		AlphaToMask Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"

			CGPROGRAM

			

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			

			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform sampler2D _MainTex;
			uniform float _Packer_TexR_Space;
			uniform float _Packer_Action2R;
			uniform float _Packer_Action1R;
			uniform float _Packer_Action0R;
			uniform float _Packer_ChannelR;
			uniform float _Packer_FloatR;
			uniform sampler2D _Packer_TexR;
			uniform float _Packer_TexG_Space;
			uniform float _Packer_Action2G;
			uniform float _Packer_Action1G;
			uniform float _Packer_Action0G;
			uniform float _Packer_ChannelG;
			uniform float _Packer_FloatG;
			uniform sampler2D _Packer_TexG;
			uniform float _Packer_TexB_Space;
			uniform float _Packer_Action2B;
			uniform float _Packer_Action1B;
			uniform float _Packer_Action0B;
			uniform float _Packer_ChannelB;
			uniform float _Packer_FloatB;
			uniform sampler2D _Packer_TexB;
			uniform float _Packer_TexA_Space;
			uniform float _Packer_Action2A;
			uniform float _Packer_Action1A;
			uniform float _Packer_Action0A;
			uniform float _Packer_ChannelA;
			uniform float _Packer_FloatA;
			uniform sampler2D _Packer_TexA;
			inline float GammaToLinearFloat100_g48( float value )
			{
				return GammaToLinearSpaceExact(value);
			}
			
			inline float LinearToGammaFloat102_g48( float value )
			{
				return LinearToGammaSpaceExact(value);
			}
			
			inline float GammaToLinearFloat100_g47( float value )
			{
				return GammaToLinearSpaceExact(value);
			}
			
			inline float LinearToGammaFloat102_g47( float value )
			{
				return LinearToGammaSpaceExact(value);
			}
			
			inline float GammaToLinearFloat100_g49( float value )
			{
				return GammaToLinearSpaceExact(value);
			}
			
			inline float LinearToGammaFloat102_g49( float value )
			{
				return LinearToGammaSpaceExact(value);
			}
			
			inline float GammaToLinearFloat100_g46( float value )
			{
				return GammaToLinearSpaceExact(value);
			}
			
			inline float LinearToGammaFloat102_g46( float value )
			{
				return LinearToGammaSpaceExact(value);
			}
			

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);

				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				#endif
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 WorldPosition = i.worldPos;
				#endif
				int Storage114_g48 = (int)_Packer_TexR_Space;
				int Action2189_g48 = (int)_Packer_Action2R;
				int Action1187_g48 = (int)_Packer_Action1R;
				int Action0173_g48 = (int)_Packer_Action0R;
				int Channel31_g48 = (int)_Packer_ChannelR;
				float ifLocalVar24_g48 = 0;
				if( Channel31_g48 == 0 )
				ifLocalVar24_g48 = _Packer_FloatR;
				float2 uv_Packer_TexR26 = i.ase_texcoord1.xy;
				float4 break23_g48 = tex2Dlod( _Packer_TexR, float4( uv_Packer_TexR26, 0, 0.0) );
				float R39_g48 = break23_g48.r;
				float ifLocalVar13_g48 = 0;
				if( Channel31_g48 == 1 )
				ifLocalVar13_g48 = R39_g48;
				float G40_g48 = break23_g48.g;
				float ifLocalVar12_g48 = 0;
				if( Channel31_g48 == 2 )
				ifLocalVar12_g48 = G40_g48;
				float B41_g48 = break23_g48.b;
				float ifLocalVar11_g48 = 0;
				if( Channel31_g48 == 3 )
				ifLocalVar11_g48 = B41_g48;
				float A42_g48 = break23_g48.a;
				float ifLocalVar17_g48 = 0;
				if( Channel31_g48 == 4 )
				ifLocalVar17_g48 = A42_g48;
				float GRAY135_g48 = ( ( R39_g48 * 0.3 ) + ( G40_g48 * 0.59 ) + ( B41_g48 * 0.11 ) );
				float ifLocalVar62_g48 = 0;
				if( Channel31_g48 == 555 )
				ifLocalVar62_g48 = GRAY135_g48;
				float ifLocalVar154_g48 = 0;
				if( Channel31_g48 == 14 )
				ifLocalVar154_g48 = ( R39_g48 * A42_g48 );
				float ifLocalVar159_g48 = 0;
				if( Channel31_g48 == 24 )
				ifLocalVar159_g48 = ( G40_g48 * A42_g48 );
				float ifLocalVar165_g48 = 0;
				if( Channel31_g48 == 34 )
				ifLocalVar165_g48 = ( B41_g48 * A42_g48 );
				float ifLocalVar147_g48 = 0;
				if( Channel31_g48 == 5554 )
				ifLocalVar147_g48 = ( GRAY135_g48 * A42_g48 );
				float Packed_Raw182_g48 = ( ifLocalVar24_g48 + ifLocalVar13_g48 + ifLocalVar12_g48 + ifLocalVar11_g48 + ifLocalVar17_g48 + ifLocalVar62_g48 + ifLocalVar154_g48 + ifLocalVar159_g48 + ifLocalVar165_g48 + ifLocalVar147_g48 );
				float ifLocalVar180_g48 = 0;
				if( Action0173_g48 == 0 )
				ifLocalVar180_g48 = Packed_Raw182_g48;
				float ifLocalVar171_g48 = 0;
				if( Action0173_g48 == 1 )
				ifLocalVar171_g48 = ( 1.0 - Packed_Raw182_g48 );
				float Packed_Action0185_g48 = saturate( ( ifLocalVar180_g48 + ifLocalVar171_g48 ) );
				float ifLocalVar193_g48 = 0;
				if( Action1187_g48 == 0 )
				ifLocalVar193_g48 = Packed_Action0185_g48;
				float ifLocalVar197_g48 = 0;
				if( Action1187_g48 == 1 )
				ifLocalVar197_g48 = ( Packed_Action0185_g48 * 0.0 );
				float ifLocalVar207_g48 = 0;
				if( Action1187_g48 == 2 )
				ifLocalVar207_g48 = ( Packed_Action0185_g48 * 2.0 );
				float ifLocalVar248_g48 = 0;
				if( Action1187_g48 == 3 )
				ifLocalVar248_g48 = ( Packed_Action0185_g48 * 3.0 );
				float ifLocalVar211_g48 = 0;
				if( Action1187_g48 == 5 )
				ifLocalVar211_g48 = ( Packed_Action0185_g48 * 5.0 );
				float Packed_Action1202_g48 = saturate( ( ifLocalVar193_g48 + ifLocalVar197_g48 + ifLocalVar207_g48 + ifLocalVar248_g48 + ifLocalVar211_g48 ) );
				float ifLocalVar220_g48 = 0;
				if( Action2189_g48 == 0 )
				ifLocalVar220_g48 = Packed_Action1202_g48;
				float ifLocalVar254_g48 = 0;
				if( Action2189_g48 == 1 )
				ifLocalVar254_g48 = pow( Packed_Action1202_g48 , 0.0 );
				float ifLocalVar225_g48 = 0;
				if( Action2189_g48 == 2 )
				ifLocalVar225_g48 = pow( Packed_Action1202_g48 , 2.0 );
				float ifLocalVar229_g48 = 0;
				if( Action2189_g48 == 3 )
				ifLocalVar229_g48 = pow( Packed_Action1202_g48 , 3.0 );
				float ifLocalVar234_g48 = 0;
				if( Action2189_g48 == 4 )
				ifLocalVar234_g48 = pow( Packed_Action1202_g48 , 4.0 );
				float Packed_Action2237_g48 = saturate( ( ifLocalVar220_g48 + ifLocalVar254_g48 + ifLocalVar225_g48 + ifLocalVar229_g48 + ifLocalVar234_g48 ) );
				float Packed_Final112_g48 = Packed_Action2237_g48;
				float ifLocalVar105_g48 = 0;
				if( Storage114_g48 == 0.0 )
				ifLocalVar105_g48 = Packed_Final112_g48;
				float value100_g48 = Packed_Final112_g48;
				float localGammaToLinearFloat100_g48 = GammaToLinearFloat100_g48( value100_g48 );
				float ifLocalVar93_g48 = 0;
				if( Storage114_g48 == 1.0 )
				ifLocalVar93_g48 = localGammaToLinearFloat100_g48;
				float value102_g48 = Packed_Final112_g48;
				float localLinearToGammaFloat102_g48 = LinearToGammaFloat102_g48( value102_g48 );
				float ifLocalVar107_g48 = 0;
				if( Storage114_g48 == 2.0 )
				ifLocalVar107_g48 = localLinearToGammaFloat102_g48;
				float R74 = ( ifLocalVar105_g48 + ifLocalVar93_g48 + ifLocalVar107_g48 );
				int Storage114_g47 = (int)_Packer_TexG_Space;
				int Action2189_g47 = (int)_Packer_Action2G;
				int Action1187_g47 = (int)_Packer_Action1G;
				int Action0173_g47 = (int)_Packer_Action0G;
				int Channel31_g47 = (int)_Packer_ChannelG;
				float ifLocalVar24_g47 = 0;
				if( Channel31_g47 == 0 )
				ifLocalVar24_g47 = _Packer_FloatG;
				float2 uv_Packer_TexG51 = i.ase_texcoord1.xy;
				float4 break23_g47 = tex2Dlod( _Packer_TexG, float4( uv_Packer_TexG51, 0, 0.0) );
				float R39_g47 = break23_g47.r;
				float ifLocalVar13_g47 = 0;
				if( Channel31_g47 == 1 )
				ifLocalVar13_g47 = R39_g47;
				float G40_g47 = break23_g47.g;
				float ifLocalVar12_g47 = 0;
				if( Channel31_g47 == 2 )
				ifLocalVar12_g47 = G40_g47;
				float B41_g47 = break23_g47.b;
				float ifLocalVar11_g47 = 0;
				if( Channel31_g47 == 3 )
				ifLocalVar11_g47 = B41_g47;
				float A42_g47 = break23_g47.a;
				float ifLocalVar17_g47 = 0;
				if( Channel31_g47 == 4 )
				ifLocalVar17_g47 = A42_g47;
				float GRAY135_g47 = ( ( R39_g47 * 0.3 ) + ( G40_g47 * 0.59 ) + ( B41_g47 * 0.11 ) );
				float ifLocalVar62_g47 = 0;
				if( Channel31_g47 == 555 )
				ifLocalVar62_g47 = GRAY135_g47;
				float ifLocalVar154_g47 = 0;
				if( Channel31_g47 == 14 )
				ifLocalVar154_g47 = ( R39_g47 * A42_g47 );
				float ifLocalVar159_g47 = 0;
				if( Channel31_g47 == 24 )
				ifLocalVar159_g47 = ( G40_g47 * A42_g47 );
				float ifLocalVar165_g47 = 0;
				if( Channel31_g47 == 34 )
				ifLocalVar165_g47 = ( B41_g47 * A42_g47 );
				float ifLocalVar147_g47 = 0;
				if( Channel31_g47 == 5554 )
				ifLocalVar147_g47 = ( GRAY135_g47 * A42_g47 );
				float Packed_Raw182_g47 = ( ifLocalVar24_g47 + ifLocalVar13_g47 + ifLocalVar12_g47 + ifLocalVar11_g47 + ifLocalVar17_g47 + ifLocalVar62_g47 + ifLocalVar154_g47 + ifLocalVar159_g47 + ifLocalVar165_g47 + ifLocalVar147_g47 );
				float ifLocalVar180_g47 = 0;
				if( Action0173_g47 == 0 )
				ifLocalVar180_g47 = Packed_Raw182_g47;
				float ifLocalVar171_g47 = 0;
				if( Action0173_g47 == 1 )
				ifLocalVar171_g47 = ( 1.0 - Packed_Raw182_g47 );
				float Packed_Action0185_g47 = saturate( ( ifLocalVar180_g47 + ifLocalVar171_g47 ) );
				float ifLocalVar193_g47 = 0;
				if( Action1187_g47 == 0 )
				ifLocalVar193_g47 = Packed_Action0185_g47;
				float ifLocalVar197_g47 = 0;
				if( Action1187_g47 == 1 )
				ifLocalVar197_g47 = ( Packed_Action0185_g47 * 0.0 );
				float ifLocalVar207_g47 = 0;
				if( Action1187_g47 == 2 )
				ifLocalVar207_g47 = ( Packed_Action0185_g47 * 2.0 );
				float ifLocalVar248_g47 = 0;
				if( Action1187_g47 == 3 )
				ifLocalVar248_g47 = ( Packed_Action0185_g47 * 3.0 );
				float ifLocalVar211_g47 = 0;
				if( Action1187_g47 == 5 )
				ifLocalVar211_g47 = ( Packed_Action0185_g47 * 5.0 );
				float Packed_Action1202_g47 = saturate( ( ifLocalVar193_g47 + ifLocalVar197_g47 + ifLocalVar207_g47 + ifLocalVar248_g47 + ifLocalVar211_g47 ) );
				float ifLocalVar220_g47 = 0;
				if( Action2189_g47 == 0 )
				ifLocalVar220_g47 = Packed_Action1202_g47;
				float ifLocalVar254_g47 = 0;
				if( Action2189_g47 == 1 )
				ifLocalVar254_g47 = pow( Packed_Action1202_g47 , 0.0 );
				float ifLocalVar225_g47 = 0;
				if( Action2189_g47 == 2 )
				ifLocalVar225_g47 = pow( Packed_Action1202_g47 , 2.0 );
				float ifLocalVar229_g47 = 0;
				if( Action2189_g47 == 3 )
				ifLocalVar229_g47 = pow( Packed_Action1202_g47 , 3.0 );
				float ifLocalVar234_g47 = 0;
				if( Action2189_g47 == 4 )
				ifLocalVar234_g47 = pow( Packed_Action1202_g47 , 4.0 );
				float Packed_Action2237_g47 = saturate( ( ifLocalVar220_g47 + ifLocalVar254_g47 + ifLocalVar225_g47 + ifLocalVar229_g47 + ifLocalVar234_g47 ) );
				float Packed_Final112_g47 = Packed_Action2237_g47;
				float ifLocalVar105_g47 = 0;
				if( Storage114_g47 == 0.0 )
				ifLocalVar105_g47 = Packed_Final112_g47;
				float value100_g47 = Packed_Final112_g47;
				float localGammaToLinearFloat100_g47 = GammaToLinearFloat100_g47( value100_g47 );
				float ifLocalVar93_g47 = 0;
				if( Storage114_g47 == 1.0 )
				ifLocalVar93_g47 = localGammaToLinearFloat100_g47;
				float value102_g47 = Packed_Final112_g47;
				float localLinearToGammaFloat102_g47 = LinearToGammaFloat102_g47( value102_g47 );
				float ifLocalVar107_g47 = 0;
				if( Storage114_g47 == 2.0 )
				ifLocalVar107_g47 = localLinearToGammaFloat102_g47;
				float G78 = ( ifLocalVar105_g47 + ifLocalVar93_g47 + ifLocalVar107_g47 );
				int Storage114_g49 = (int)_Packer_TexB_Space;
				int Action2189_g49 = (int)_Packer_Action2B;
				int Action1187_g49 = (int)_Packer_Action1B;
				int Action0173_g49 = (int)_Packer_Action0B;
				int Channel31_g49 = (int)_Packer_ChannelB;
				float ifLocalVar24_g49 = 0;
				if( Channel31_g49 == 0 )
				ifLocalVar24_g49 = _Packer_FloatB;
				float2 uv_Packer_TexB57 = i.ase_texcoord1.xy;
				float4 break23_g49 = tex2Dlod( _Packer_TexB, float4( uv_Packer_TexB57, 0, 0.0) );
				float R39_g49 = break23_g49.r;
				float ifLocalVar13_g49 = 0;
				if( Channel31_g49 == 1 )
				ifLocalVar13_g49 = R39_g49;
				float G40_g49 = break23_g49.g;
				float ifLocalVar12_g49 = 0;
				if( Channel31_g49 == 2 )
				ifLocalVar12_g49 = G40_g49;
				float B41_g49 = break23_g49.b;
				float ifLocalVar11_g49 = 0;
				if( Channel31_g49 == 3 )
				ifLocalVar11_g49 = B41_g49;
				float A42_g49 = break23_g49.a;
				float ifLocalVar17_g49 = 0;
				if( Channel31_g49 == 4 )
				ifLocalVar17_g49 = A42_g49;
				float GRAY135_g49 = ( ( R39_g49 * 0.3 ) + ( G40_g49 * 0.59 ) + ( B41_g49 * 0.11 ) );
				float ifLocalVar62_g49 = 0;
				if( Channel31_g49 == 555 )
				ifLocalVar62_g49 = GRAY135_g49;
				float ifLocalVar154_g49 = 0;
				if( Channel31_g49 == 14 )
				ifLocalVar154_g49 = ( R39_g49 * A42_g49 );
				float ifLocalVar159_g49 = 0;
				if( Channel31_g49 == 24 )
				ifLocalVar159_g49 = ( G40_g49 * A42_g49 );
				float ifLocalVar165_g49 = 0;
				if( Channel31_g49 == 34 )
				ifLocalVar165_g49 = ( B41_g49 * A42_g49 );
				float ifLocalVar147_g49 = 0;
				if( Channel31_g49 == 5554 )
				ifLocalVar147_g49 = ( GRAY135_g49 * A42_g49 );
				float Packed_Raw182_g49 = ( ifLocalVar24_g49 + ifLocalVar13_g49 + ifLocalVar12_g49 + ifLocalVar11_g49 + ifLocalVar17_g49 + ifLocalVar62_g49 + ifLocalVar154_g49 + ifLocalVar159_g49 + ifLocalVar165_g49 + ifLocalVar147_g49 );
				float ifLocalVar180_g49 = 0;
				if( Action0173_g49 == 0 )
				ifLocalVar180_g49 = Packed_Raw182_g49;
				float ifLocalVar171_g49 = 0;
				if( Action0173_g49 == 1 )
				ifLocalVar171_g49 = ( 1.0 - Packed_Raw182_g49 );
				float Packed_Action0185_g49 = saturate( ( ifLocalVar180_g49 + ifLocalVar171_g49 ) );
				float ifLocalVar193_g49 = 0;
				if( Action1187_g49 == 0 )
				ifLocalVar193_g49 = Packed_Action0185_g49;
				float ifLocalVar197_g49 = 0;
				if( Action1187_g49 == 1 )
				ifLocalVar197_g49 = ( Packed_Action0185_g49 * 0.0 );
				float ifLocalVar207_g49 = 0;
				if( Action1187_g49 == 2 )
				ifLocalVar207_g49 = ( Packed_Action0185_g49 * 2.0 );
				float ifLocalVar248_g49 = 0;
				if( Action1187_g49 == 3 )
				ifLocalVar248_g49 = ( Packed_Action0185_g49 * 3.0 );
				float ifLocalVar211_g49 = 0;
				if( Action1187_g49 == 5 )
				ifLocalVar211_g49 = ( Packed_Action0185_g49 * 5.0 );
				float Packed_Action1202_g49 = saturate( ( ifLocalVar193_g49 + ifLocalVar197_g49 + ifLocalVar207_g49 + ifLocalVar248_g49 + ifLocalVar211_g49 ) );
				float ifLocalVar220_g49 = 0;
				if( Action2189_g49 == 0 )
				ifLocalVar220_g49 = Packed_Action1202_g49;
				float ifLocalVar254_g49 = 0;
				if( Action2189_g49 == 1 )
				ifLocalVar254_g49 = pow( Packed_Action1202_g49 , 0.0 );
				float ifLocalVar225_g49 = 0;
				if( Action2189_g49 == 2 )
				ifLocalVar225_g49 = pow( Packed_Action1202_g49 , 2.0 );
				float ifLocalVar229_g49 = 0;
				if( Action2189_g49 == 3 )
				ifLocalVar229_g49 = pow( Packed_Action1202_g49 , 3.0 );
				float ifLocalVar234_g49 = 0;
				if( Action2189_g49 == 4 )
				ifLocalVar234_g49 = pow( Packed_Action1202_g49 , 4.0 );
				float Packed_Action2237_g49 = saturate( ( ifLocalVar220_g49 + ifLocalVar254_g49 + ifLocalVar225_g49 + ifLocalVar229_g49 + ifLocalVar234_g49 ) );
				float Packed_Final112_g49 = Packed_Action2237_g49;
				float ifLocalVar105_g49 = 0;
				if( Storage114_g49 == 0.0 )
				ifLocalVar105_g49 = Packed_Final112_g49;
				float value100_g49 = Packed_Final112_g49;
				float localGammaToLinearFloat100_g49 = GammaToLinearFloat100_g49( value100_g49 );
				float ifLocalVar93_g49 = 0;
				if( Storage114_g49 == 1.0 )
				ifLocalVar93_g49 = localGammaToLinearFloat100_g49;
				float value102_g49 = Packed_Final112_g49;
				float localLinearToGammaFloat102_g49 = LinearToGammaFloat102_g49( value102_g49 );
				float ifLocalVar107_g49 = 0;
				if( Storage114_g49 == 2.0 )
				ifLocalVar107_g49 = localLinearToGammaFloat102_g49;
				float B79 = ( ifLocalVar105_g49 + ifLocalVar93_g49 + ifLocalVar107_g49 );
				int Storage114_g46 = (int)_Packer_TexA_Space;
				int Action2189_g46 = (int)_Packer_Action2A;
				int Action1187_g46 = (int)_Packer_Action1A;
				int Action0173_g46 = (int)_Packer_Action0A;
				int Channel31_g46 = (int)_Packer_ChannelA;
				float ifLocalVar24_g46 = 0;
				if( Channel31_g46 == 0 )
				ifLocalVar24_g46 = _Packer_FloatA;
				float2 uv_Packer_TexA60 = i.ase_texcoord1.xy;
				float4 break23_g46 = tex2Dlod( _Packer_TexA, float4( uv_Packer_TexA60, 0, 0.0) );
				float R39_g46 = break23_g46.r;
				float ifLocalVar13_g46 = 0;
				if( Channel31_g46 == 1 )
				ifLocalVar13_g46 = R39_g46;
				float G40_g46 = break23_g46.g;
				float ifLocalVar12_g46 = 0;
				if( Channel31_g46 == 2 )
				ifLocalVar12_g46 = G40_g46;
				float B41_g46 = break23_g46.b;
				float ifLocalVar11_g46 = 0;
				if( Channel31_g46 == 3 )
				ifLocalVar11_g46 = B41_g46;
				float A42_g46 = break23_g46.a;
				float ifLocalVar17_g46 = 0;
				if( Channel31_g46 == 4 )
				ifLocalVar17_g46 = A42_g46;
				float GRAY135_g46 = ( ( R39_g46 * 0.3 ) + ( G40_g46 * 0.59 ) + ( B41_g46 * 0.11 ) );
				float ifLocalVar62_g46 = 0;
				if( Channel31_g46 == 555 )
				ifLocalVar62_g46 = GRAY135_g46;
				float ifLocalVar154_g46 = 0;
				if( Channel31_g46 == 14 )
				ifLocalVar154_g46 = ( R39_g46 * A42_g46 );
				float ifLocalVar159_g46 = 0;
				if( Channel31_g46 == 24 )
				ifLocalVar159_g46 = ( G40_g46 * A42_g46 );
				float ifLocalVar165_g46 = 0;
				if( Channel31_g46 == 34 )
				ifLocalVar165_g46 = ( B41_g46 * A42_g46 );
				float ifLocalVar147_g46 = 0;
				if( Channel31_g46 == 5554 )
				ifLocalVar147_g46 = ( GRAY135_g46 * A42_g46 );
				float Packed_Raw182_g46 = ( ifLocalVar24_g46 + ifLocalVar13_g46 + ifLocalVar12_g46 + ifLocalVar11_g46 + ifLocalVar17_g46 + ifLocalVar62_g46 + ifLocalVar154_g46 + ifLocalVar159_g46 + ifLocalVar165_g46 + ifLocalVar147_g46 );
				float ifLocalVar180_g46 = 0;
				if( Action0173_g46 == 0 )
				ifLocalVar180_g46 = Packed_Raw182_g46;
				float ifLocalVar171_g46 = 0;
				if( Action0173_g46 == 1 )
				ifLocalVar171_g46 = ( 1.0 - Packed_Raw182_g46 );
				float Packed_Action0185_g46 = saturate( ( ifLocalVar180_g46 + ifLocalVar171_g46 ) );
				float ifLocalVar193_g46 = 0;
				if( Action1187_g46 == 0 )
				ifLocalVar193_g46 = Packed_Action0185_g46;
				float ifLocalVar197_g46 = 0;
				if( Action1187_g46 == 1 )
				ifLocalVar197_g46 = ( Packed_Action0185_g46 * 0.0 );
				float ifLocalVar207_g46 = 0;
				if( Action1187_g46 == 2 )
				ifLocalVar207_g46 = ( Packed_Action0185_g46 * 2.0 );
				float ifLocalVar248_g46 = 0;
				if( Action1187_g46 == 3 )
				ifLocalVar248_g46 = ( Packed_Action0185_g46 * 3.0 );
				float ifLocalVar211_g46 = 0;
				if( Action1187_g46 == 5 )
				ifLocalVar211_g46 = ( Packed_Action0185_g46 * 5.0 );
				float Packed_Action1202_g46 = saturate( ( ifLocalVar193_g46 + ifLocalVar197_g46 + ifLocalVar207_g46 + ifLocalVar248_g46 + ifLocalVar211_g46 ) );
				float ifLocalVar220_g46 = 0;
				if( Action2189_g46 == 0 )
				ifLocalVar220_g46 = Packed_Action1202_g46;
				float ifLocalVar254_g46 = 0;
				if( Action2189_g46 == 1 )
				ifLocalVar254_g46 = pow( Packed_Action1202_g46 , 0.0 );
				float ifLocalVar225_g46 = 0;
				if( Action2189_g46 == 2 )
				ifLocalVar225_g46 = pow( Packed_Action1202_g46 , 2.0 );
				float ifLocalVar229_g46 = 0;
				if( Action2189_g46 == 3 )
				ifLocalVar229_g46 = pow( Packed_Action1202_g46 , 3.0 );
				float ifLocalVar234_g46 = 0;
				if( Action2189_g46 == 4 )
				ifLocalVar234_g46 = pow( Packed_Action1202_g46 , 4.0 );
				float Packed_Action2237_g46 = saturate( ( ifLocalVar220_g46 + ifLocalVar254_g46 + ifLocalVar225_g46 + ifLocalVar229_g46 + ifLocalVar234_g46 ) );
				float Packed_Final112_g46 = Packed_Action2237_g46;
				float ifLocalVar105_g46 = 0;
				if( Storage114_g46 == 0.0 )
				ifLocalVar105_g46 = Packed_Final112_g46;
				float value100_g46 = Packed_Final112_g46;
				float localGammaToLinearFloat100_g46 = GammaToLinearFloat100_g46( value100_g46 );
				float ifLocalVar93_g46 = 0;
				if( Storage114_g46 == 1.0 )
				ifLocalVar93_g46 = localGammaToLinearFloat100_g46;
				float value102_g46 = Packed_Final112_g46;
				float localLinearToGammaFloat102_g46 = LinearToGammaFloat102_g46( value102_g46 );
				float ifLocalVar107_g46 = 0;
				if( Storage114_g46 == 2.0 )
				ifLocalVar107_g46 = localLinearToGammaFloat102_g46;
				float A80 = ( ifLocalVar105_g46 + ifLocalVar93_g46 + ifLocalVar107_g46 );
				float4 appendResult48 = (float4(R74 , G78 , B79 , A80));
				
				
				finalColor = appendResult48;
				return finalColor;
			}
			ENDCG
		}
	}
	
	
	
}
/*ASEBEGIN
Version=18934
1920;0;1920;1029;-2237.479;-17.41345;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;59;2176,192;Float;False;Property;_Packer_FloatB;Packer_FloatB;7;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;138;1024,640;Float;False;Property;_Packer_TexG_Space;Packer_TexG_Space;26;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-128,640;Float;False;Property;_Packer_TexR_Space;Packer_TexR_Space;25;0;Create;True;0;0;0;False;1;Space(10);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;51;1024,0;Inherit;True;Property;_Packer_TexG;Packer_TexG;2;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;MipLevel;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;67;2176,272;Float;False;Property;_Packer_ChannelB;Packer_ChannelB;23;1;[IntRange];Create;True;0;0;0;False;0;False;0;3;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;140;2176,640;Float;False;Property;_Packer_TexB_Space;Packer_TexB_Space;27;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;285;1024,448;Float;False;Property;_Packer_Action1G;Packer_Action1G;17;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;291;3328,448;Float;False;Property;_Packer_Action1A;Packer_Action1A;20;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;290;3328,384;Float;False;Property;_Packer_Action0A;Packer_Action0A;15;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;289;2176,512;Float;False;Property;_Packer_Action2B;Packer_Action2B;12;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;283;-128,512;Float;False;Property;_Packer_Action2R;Packer_Action2R;13;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;282;-128,448;Float;False;Property;_Packer_Action1R;Packer_Action1R;14;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;257;-128,384;Float;False;Property;_Packer_Action0R;Packer_Action0R;19;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;60;3328,0;Inherit;True;Property;_Packer_TexA;Packer_TexA;4;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;MipLevel;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;66;1024,272;Float;False;Property;_Packer_ChannelG;Packer_ChannelG;22;1;[IntRange];Create;True;0;0;0;False;0;False;0;2;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;287;2176,384;Float;False;Property;_Packer_Action0B;Packer_Action0B;9;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;292;3328,512;Float;False;Property;_Packer_Action2A;Packer_Action2A;18;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;286;1024,512;Float;False;Property;_Packer_Action2G;Packer_Action2G;16;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;68;3328,272;Float;False;Property;_Packer_ChannelA;Packer_ChannelA;24;1;[IntRange];Create;True;0;0;0;False;0;False;0;4;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;57;2176,0;Inherit;True;Property;_Packer_TexB;Packer_TexB;3;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;MipLevel;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;64;3328,192;Float;False;Property;_Packer_FloatA;Packer_FloatA;8;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;142;3328,640;Float;False;Property;_Packer_TexA_Space;Packer_TexA_Space;28;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;50;1024,192;Float;False;Property;_Packer_FloatG;Packer_FloatG;6;0;Create;True;0;0;0;False;0;False;0;0.356;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-128,272;Float;False;Property;_Packer_ChannelR;Packer_ChannelR;21;1;[IntRange];Create;True;0;0;0;False;1;Space(10);False;0;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;284;1024,384;Float;False;Property;_Packer_Action0G;Packer_Action0G;11;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;288;2176,448;Float;False;Property;_Packer_Action1B;Packer_Action1B;10;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-128,192;Float;False;Property;_Packer_FloatR;Packer_FloatR;5;0;Create;True;0;0;0;False;1;Space(10);False;0;0.519;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;26;-128,0;Inherit;True;Property;_Packer_TexR;Packer_TexR;1;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;MipLevel;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;299;2688,0;Inherit;False;Tool Packer;-1;;49;7c427933118005a479c95a1271b737a6;0;8;19;COLOR;0,0,0,0;False;25;FLOAT;0;False;10;INT;0;False;172;INT;0;False;241;INT;0;False;242;INT;0;False;243;INT;0;False;56;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;300;384,0;Inherit;False;Tool Packer;-1;;48;7c427933118005a479c95a1271b737a6;0;8;19;COLOR;0,0,0,0;False;25;FLOAT;0;False;10;INT;0;False;172;INT;0;False;241;INT;0;False;242;INT;0;False;243;INT;0;False;56;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;298;3840,0;Inherit;False;Tool Packer;-1;;46;7c427933118005a479c95a1271b737a6;0;8;19;COLOR;0,0,0,0;False;25;FLOAT;0;False;10;INT;0;False;172;INT;0;False;241;INT;0;False;242;INT;0;False;243;INT;0;False;56;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;297;1536,0;Inherit;False;Tool Packer;-1;;47;7c427933118005a479c95a1271b737a6;0;8;19;COLOR;0,0,0,0;False;25;FLOAT;0;False;10;INT;0;False;172;INT;0;False;241;INT;0;False;242;INT;0;False;243;INT;0;False;56;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;80;4160,0;Float;False;A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;79;3008,0;Float;False;B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;78;1856,0;Float;False;G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;74;704,0;Float;False;R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;143;-128,896;Inherit;False;74;R;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;145;-128,1136;Inherit;False;80;A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;146;-128,1056;Inherit;False;79;B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;144;-128,976;Inherit;False;78;G;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;155;4480,0;Inherit;True;Property;_MainTex;Dummy Texture;0;1;[HideInInspector];Create;False;0;0;0;True;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;48;128,896;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;320,896;Float;False;True;-1;2;;0;1;Hidden/BOXOPHOBIC/The Vegetation Engine/Helpers/Packer;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;False;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;2;RenderType=Opaque=RenderType;PreviewType=Plane;True;2;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;0;1;True;False;;False;0
WireConnection;299;19;57;0
WireConnection;299;25;59;0
WireConnection;299;10;67;0
WireConnection;299;172;287;0
WireConnection;299;241;288;0
WireConnection;299;242;289;0
WireConnection;299;56;140;0
WireConnection;300;19;26;0
WireConnection;300;25;47;0
WireConnection;300;10;65;0
WireConnection;300;172;257;0
WireConnection;300;241;282;0
WireConnection;300;242;283;0
WireConnection;300;56;72;0
WireConnection;298;19;60;0
WireConnection;298;25;64;0
WireConnection;298;10;68;0
WireConnection;298;172;290;0
WireConnection;298;241;291;0
WireConnection;298;242;292;0
WireConnection;298;56;142;0
WireConnection;297;19;51;0
WireConnection;297;25;50;0
WireConnection;297;10;66;0
WireConnection;297;172;284;0
WireConnection;297;241;285;0
WireConnection;297;242;286;0
WireConnection;297;56;138;0
WireConnection;80;0;298;0
WireConnection;79;0;299;0
WireConnection;78;0;297;0
WireConnection;74;0;300;0
WireConnection;48;0;143;0
WireConnection;48;1;144;0
WireConnection;48;2;146;0
WireConnection;48;3;145;0
WireConnection;0;0;48;0
ASEEND*/
//CHKSM=BDA67DECD2664A56BA530352EF648771EC54C2A2