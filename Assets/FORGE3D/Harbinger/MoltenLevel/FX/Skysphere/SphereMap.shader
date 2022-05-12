// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Shader created with Shader Forge Beta 0.34 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.34;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,limd:0,uamb:True,mssp:True,lmpd:False,lprd:False,enco:False,frtr:True,vitr:True,dbil:False,rmgx:True,rpth:0,hqsc:True,hqlp:False,blpr:0,bsrc:0,bdst:0,culm:1,dpts:2,wrdp:False,ufog:False,aust:False,igpj:False,qofs:0,qpre:0,rntp:4,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.06963667,fgcg:0.09467245,fgcb:0.1029412,fgca:1,fgde:0.03,fgrn:0,fgrf:0,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:11145,x:32211,y:32740|custl-11164-OUT;n:type:ShaderForge.SFN_Cubemap,id:11146,x:33512,y:32675,ptlb:Nebula,ptin:_Nebula;n:type:ShaderForge.SFN_Cubemap,id:11159,x:33121,y:33014,ptlb:Starmap,ptin:_Starmap;n:type:ShaderForge.SFN_ValueProperty,id:11161,x:33121,y:33205,ptlb:StarsPower,ptin:_StarsPower,glob:False,v1:0;n:type:ShaderForge.SFN_Power,id:11162,x:32903,y:33014|VAL-11159-RGB,EXP-11161-OUT;n:type:ShaderForge.SFN_Add,id:11164,x:32491,y:32942|A-11173-OUT,B-11165-OUT;n:type:ShaderForge.SFN_Multiply,id:11165,x:32697,y:33014|A-11162-OUT,B-11167-RGB;n:type:ShaderForge.SFN_Color,id:11167,x:32903,y:33161,ptlb:StarsTint,ptin:_StarsTint,glob:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:11173,x:32843,y:32771|A-11174-RGB,B-11177-OUT;n:type:ShaderForge.SFN_Color,id:11174,x:33144,y:32652,ptlb:NebulaTint,ptin:_NebulaTint,glob:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Desaturate,id:11177,x:33202,y:32817|COL-11146-RGB,DES-11180-OUT;n:type:ShaderForge.SFN_Slider,id:11179,x:33718,y:32837,ptlb:NebulaSaturation,ptin:_NebulaSaturation,min:0,cur:0,max:1;n:type:ShaderForge.SFN_OneMinus,id:11180,x:33512,y:32837|IN-11179-OUT;proporder:11146-11159-11161-11167-11174-11179;pass:END;sub:END;*/

Shader "Custom/SphereMap" {
    Properties {
        _Nebula ("Nebula", Cube) = "_Skybox" {}
        _Starmap ("Starmap", Cube) = "_Skybox" {}
        _StarsPower ("StarsPower", Float ) = 0
        _StarsTint ("StarsTint", Color) = (0.5,0.5,0.5,1)
        _NebulaTint ("NebulaTint", Color) = (0.5,0.5,0.5,1)
        _NebulaSaturation ("NebulaSaturation", Range(0, 1)) = 0
    }
    SubShader {
        Tags {
            "Queue"="Background"
            "RenderType"="Transparent"

        }
        LOD 200
        Blend One One    
        Pass {
         //   Name "ForwardBase"
            Tags {
           //     "LightMode"="ForwardBase"

            }
            Cull Front
            ZWrite Off
            Offset 200005, 20005
            
            Fog {Mode Off}
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
         //   #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
         //   #pragma multi_compile_fwdbase_fullshadows
         //   #pragma exclude_renderers xbox360 ps3 flash d3d11_9x 
            #pragma target 3.0
            uniform samplerCUBE _Nebula;
            uniform samplerCUBE _Starmap;
            uniform float _StarsPower;
            uniform float4 _StarsTint;
            uniform float4 _NebulaTint;
            uniform float _NebulaSaturation;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.normalDir = mul(float4(-v.normal,0), unity_WorldToObject).xyz;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
/////// Normals:
                float3 normalDirection =  i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
////// Lighting:
                float3 finalColor = ((_NebulaTint.rgb*lerp(texCUBE(_Nebula,viewReflectDirection).rgb,dot(texCUBE(_Nebula,viewReflectDirection).rgb,float3(0.3,0.59,0.11)),(1.0 - _NebulaSaturation)))+(pow(texCUBE(_Starmap,viewReflectDirection).rgb,_StarsPower)*_StarsTint.rgb));
/// Final Color:
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
 //   FallBack "Diffuse"
 //   CustomEditor "ShaderForgeMaterialInspector"
}
