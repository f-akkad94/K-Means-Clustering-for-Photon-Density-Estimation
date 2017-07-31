#version 3.7;

global_settings{ 
        max_trace_level 25
        photons { 
                gather 20, 100
                spacing 0.015
        }
}

#include "colors.inc"
#include "shapes.inc"
#include "textures.inc"
#include "metals.inc"

camera {
   location <50.0, 75.0, 65.0>
   angle 65 //  direction z
   up y
   right x*image_width/image_height
   look_at <-10.0, 18.0, 0.0>
}

light_source { <10.0, 75.0, 35.0> colour White }
light_source { <-35.0, 30.0, -150.0> colour White }




#declare I_Glass2 =                    //Use with Bead
    interior{
       fade_distance 1.5              // only for this scene
       fade_power 1
       ior 1.45
       caustics 2
    }


#declare I_Glass3 =                  //Use with Rim
   interior{
      ior 1.51
      caustics 2
      fade_distance 0.025
      fade_power 1
   }

#declare I_Glass4 =                  //Use with Top & Stem
   interior{
      ior 1.51
      caustics 2
      fade_distance 1.5
      fade_power 1
   }

#declare I_Glass5 =                 // Use with Base
   interior{
       ior 1.51
       caustics 2
       fade_distance 3.25
       fade_power 1
     }


#declare T_Glass = texture {
   pigment { color red 1.0 green 1.0 blue 1.0 filter 0.95 }
   finish {
      ambient 0.0
      diffuse 0.0
      reflection 0.1
      phong 0.3
      phong_size 90
   }
}

#declare Wine = color red 1.0 filter 0.85;

#declare Liquid = finish { reflection 0.05 }

#declare Bead = object {
   sphere { <0, 0, 0>, 1 scale <1.65, 0.65, 1.65> }
   texture { T_Glass}
   interior {I_Glass2}

}

#declare Rim =
   torus {0.975, 0.025
   clipped_by { plane { -y, 0.0 } }
   scale <15.0, 10.0, 15.0>
   translate 24.0*y
   texture {T_Glass}
   interior{I_Glass3}
}

#declare Top = intersection {
   plane { y, 1.0  }
   object { QCone_Y }
   object { QCone_Y scale <0.97, 1.0, 0.97> inverse }

   clipped_by { plane { y, 0.0  inverse } }
   scale <15.0, 10.0, 15.0>
   translate 14.0*y
   texture { T_Glass}
   interior {I_Glass4}
}

#declare Stem =
cylinder { y*3.25, y*14, 1
  texture { T_Glass}
  interior {I_Glass4}
}


#declare Base = object {
   QCone_Y
   clipped_by {
      plane { y, 0.0  }
      plane { y, -1.0 inverse }
   }
   translate 1.0*y         /* This actually puts the base of the cone on y=0*/
   scale <12.0, 3.25, 12.0>
   texture { T_Glass}
   interior { I_Glass5}
}

#declare Wine2 =
union {
   cone { 0, 0, y, 0.95 open
      texture {
         finish { Liquid }
         pigment { Wine }
      }
   }
   disc { y, y, 0.95
      texture {
         finish { Liquid
            specular 1
            roughness 0.01
         }
         pigment { Wine }
         normal { onion 0.75 frequency 3 sine_wave turbulence 0.15 }
      }

   }
   scale <14.9, 9.5, 14.9>
   translate 14.0*y
   texture {
      finish { Liquid }
      pigment { Wine }
   }
}



#declare WineGlass_Without_Wine = merge {
   object { Rim   }
   object { Top   }
   object { Bead  translate 14.5*y }
   object { Bead  translate 10.0*y }
   object { Bead  translate  7.0*y }
   object { Bead  translate  3.0*y }
   object { Stem  }
   object { Base  }
   scale <1.0, 1.50, 1.0>
}
#declare WineGlass_With_Wine = union {
   object { WineGlass_Without_Wine }
   object { Wine2
      scale <1.0, 1.50, 1.0>
   }
}


fog { distance 200 color Black }

/* Ground plane */
plane {
   y, 0.0
   texture {
      pigment { RichBlue }
      normal {
         quilted 0.45
         control0 1 control1 1
         scale <0.45, 1, 0.45>
      }
   }
}


// How did I figure out those wierd transformations below?
// Well, they'd be less obscure had I created the wine glass properly,
// but since I didn't, I simply put the camera a tiny bit above the
// floorplane and tried various values until it "fit".

object { WineGlass_Without_Wine 
            translate -x*12.15
            rotate -z*86.5   
            photons {target 10 refraction off reflection on}}

object { WineGlass_With_Wine translate <0, 0, -20> photons {target 10 refraction on reflection on}}