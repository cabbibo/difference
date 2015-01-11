
#extension GL_OES_standard_derivatives : enable


uniform sampler2D t_audio;

varying mat3 vNormalMatrix;

uniform samplerCube t_refl;
uniform samplerCube t_refr;
uniform sampler2D t_flag;
uniform sampler2D t_normal;
uniform sampler2D t_iri;
uniform sampler2D t_matcap;

uniform float time;
uniform float custom1;
uniform float custom2;
uniform float custom3;

varying vec3 vNorm;
varying vec3 vMNorm;
varying vec3 vCamVec;
varying vec3 vMPos;
varying vec3 vMVPos;
varying vec3 vLightDir;
varying vec3 vPos;
varying vec2 vUv;
varying vec4 vAudio;

const float smoothing = 1. / 32.;
uniform float texScale ;
uniform float normalScale;



$uvNormalMap
$semLookup


void main(){

  vec2 tLookup = vec2( vUv );
  /*tLookup *= 1. / textureScale;
  tLookup -= (1. / textureScale)/2.;// / 2.;
  tLookup += textureScale;// / 2.;*/
  
  vec4 flag = texture2D( t_flag , tLookup );

  //float distance = 1.-title.r;
  //float lum = smoothstep( 0.6 - smoothing , 0.6 + smoothing , distance );

 // vec2 newNorm = vec2( 3. , 3. ) * lum;

 /* vec3 q0 = dFdx( vPos.xyz );
  vec3 q1 = dFdy( vPos.xyz );
  vec2 st0 = dFdx( vUv.st );
  vec2 st1 = dFdy( vUv.st );

  vec3 S = normalize(  q0 * st1.t - q1 * st0.t );
  vec3 T = normalize( -q0 * st1.s + q1 * st0.s );
  vec3 N = normalize( vNorm );

//  vec2 offset = vec2(  timer * .000000442 , timer * .0000005345 );
  vec2 offset = vec2(  0. , 0. );


 
  vec3 mapN = texture2D( t_normal,vUv*texScale+offset).xyz * 2.0 - 1.0;
  mapN = texture2D( t_normal,vUv*texScale*.7314+offset).xyz * 2.0 - 1.0;

    mapN.xy = normalScale * (mapN.xy);// + newNorm);

  mat3 tsn = mat3( S, T, N );
  vec3 fNorm =  normalize( tsn * mapN ); 


*/
  vec2 offset = vec2( 0. );
  vec3 fNorm = uvNormalMap( t_normal , vPos , vUv , vNorm , texScale , normalScale , offset * 5.15123465);



  float lu = abs(dot( vCamVec , vMNorm ));
  float luf = abs(dot( vCamVec , fNorm ));

  vec3 refl = reflect( vLightDir , fNorm );

  float spec = abs( dot( vCamVec , refl  ) );
  float lambert = max( 0. , dot( vLightDir , fNorm ) );

  float reflFR = abs(dot( vCamVec , refl ));
// float luf = abs(dot( vCamVec , fNorm ));
  vec4 aC = texture2D( t_audio , vec2( spec , 0. ));
  

 
  if( vUv.x < .02 ){

    discard;

  }

  vec2 semUV = semLookup( normalize( vMVPos ) , normalize(vNormalMatrix * fNorm) );
  vec4 semCol = texture2D( t_matcap , semUV );


 // gl_FragColor =  vec4((1. - lu * lu * lu ));
  gl_FragColor = aC * vec4( fNorm * .5 + .5 , 1. ) *   vec4((1. - luf * luf * luf ));
  //gl_FragColor = vec4((1. - luf * luf * luf ));
  gl_FragColor = vec4(( pow(reflFR,20.))) * vec4( fNorm * .5 + .5 , 1. ) * aC + vec4((1. - luf * luf * luf ));
  gl_FragColor = semCol * aC;  //+  vec4(( pow(reflFR,20.))) * vec4( fNorm * .5 + .5 , 1. ) * aC;
  
   
  
  //* vec4(vUv.x , .1 , vUv.y , 1. );//c + aC;// c * aC * custom3;
 // gl_FragColor = vec4( iri* (abs(vMNorm)+vec3(.7)) + vec3( 1.-flag.r), 1. ) * (1. - lu * lu * lu ); //* vec4(vUv.x , .1 , vUv.y , 1. );//c + aC;// c * aC * custom3;

 // gl_FragColor = vec4( flag.xyz , 1. )* (1. - lu * lu * lu );
  
}
