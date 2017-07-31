
photons {
  spacing 0.0.15 | count <photons_to_shoot>

  [gather <min_gather>, <max_gather>]
  [radius <gather_radius>,<multiplier>,
          <gather_radius_media>,<multiplier>]
}

global_settings{ 
        max_trace_level 25
        photons {   
                gather 20, 100
                spacing 0.015
        }
} //-----------------------------------------
// photon object
// Derived for a sample of Bob Hughes,2001
// by Friedrich A. Lohmueller, May 2010
//
#declare Crystal=
intersection{
 #for (Count, 0,8,1 )
   box{ <-1,-1,-1>,<1,1,1> rotate <45,0,45> rotate Count*40*y }
 #end
} //------------

sky_sphere {
  pigment {
    gradient y
    color_map {
      [0.0 rgb <0.6,0.8,1.0>*0.7]
      [0.3 rgb <0.3,0.6,0.9>*0.7]
      [1.0 rgb <0.1,0.4,0.8>*0.7]
    }
  }
}

camera {
  location  <0, 14, -18>
  right    x*image_width/image_height
  rotate 6*y
  look_at   <0.25,0,0>  
  angle 23  
}

light_source { <-200, 100, -200>, color rgb<1,1,1> }
 
plane{  <0,1,0>,-1  
        pigment {rgb 0.5}
}//----
 
object{ Crystal
        pigment{ rgbft <1,1,1,0.9,0.1>}
        finish { specular 0.3 roughness 0.009 reflection {0.1} }
        interior {ior 1.33 dispersion 1.2 dispersion_samples 12}
        translate <1.55,0.5,0>
        photons {target 0.9 refraction on reflection on}
}//----

object{ Crystal
        pigment {rgb 0.1}
        finish {diffuse 0.2 specular 0.6 roughness 0.01 reflection {0.9}}
        translate <-1.55,0.5,0>
        photons {target 0.9 refraction off reflection on}
}//---- 


//---------- End Radiosity and Photons
