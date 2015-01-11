function initRepelers(){

    var g = new THREE.IcosahedronGeometry( 4 , 3 );
    var m = new THREE.MeshBasicMaterial( { color: 0xffffff} );

    for( var i =0; i<50; i++ ){

      var mesh = new THREE.Mesh( g , m );

      var t = Math.random() * 2 * Math.PI;
      var p = Math.random() * 2 * Math.PI;

      mesh.target   = new THREE.Vector3();//toCart( 12 , t , p );
      mesh.velocity = new THREE.Vector3();
      mesh.power    = new THREE.Vector3( 1 , 1 , 1);

      //mesh.position.copy( mesh.target );
      REPELERS.push( mesh );

      scene.add( mesh );

    }

    Arrangements.randomSphere( 110 );


}
