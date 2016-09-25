Shader "Effects/MousePosContraction"
{
	Properties
	{
		_MousePos ("MousePosition", Vector) = (0.0,0.0,0.0,0.0)

		_Strength ("Strength", float) = 20.0
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off
		Tags{"Queue" = "Transparent+10"}

		
		GrabPass
		{
		"_MainTex"
		}

		Pass
		{
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 grabuv : TEXCOORD1;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);			
				o.uv = v.uv;
				o.grabuv = ComputeGrabScreenPos(o.vertex);
				return o;
			}
			
			sampler2D _MainTex;
			float _Strength;

			fixed4 frag (v2f i) : SV_Target
			{
				float dst = distance(float2(0.5,0.5) , i.uv);

				float stp = 1 - smoothstep(-.5, .5, dst);

				float2 dir = i.uv - (0.5, 0.5);

				float4 wantedUv = i.grabuv; 

				wantedUv.xy = i.grabuv.xy + clamp(dir * float2(1,-1) * ((.5-dst) * stp) * _Strength, -i.grabuv.xy, i.grabuv.xy);				
				
				fixed4 col = tex2Dproj(_MainTex, wantedUv);

				//blur the pixels
				int iterations = 25;
				for(int cnt = 0; cnt < iterations; cnt++)
				{
					col +=tex2Dproj(_MainTex, lerp(i.grabuv, wantedUv, (1.0/iterations) * cnt));
				}

				col = col/(iterations + 1);
				
				// just invert the colors
				return col;
			}
			ENDCG
		}
	}
}
