function loadShaders(){
   
  shaders = new ShaderLoader('shaders');

  shaders.load( 'ss-cloth' , 'cloth' , 'simulation' );
  shaders.load( 'vs-cloth' , 'cloth' , 'vertex' );
  shaders.load( 'fs-cloth' , 'cloth' , 'fragment' );

  shaders.shaderSetLoaded = function(){
   onLoad();
  }

}
