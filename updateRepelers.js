function updateRepelers(){


      for( var i = 0; i < REPELERS.length; i++ ){

      //console.log( REPELERS[i].target );
      tv1.copy( REPELERS[i].target );
      tv1.sub( REPELERS[i].position );

      tv1.multiplyScalar( .1 );

      //console.log( tv1.x );
      REPELERS[i].position.add( tv1 );
       
      var ind = i / ( 2 * REPELERS.length); 
      var fI = Math.floor( ind * audioController.analyzer.array.length );
      var p = audioController.analyzer.array[ fI ];

      //console.log( p );
      REPELERS[i].power.x = p / 256;
      
    }




}
