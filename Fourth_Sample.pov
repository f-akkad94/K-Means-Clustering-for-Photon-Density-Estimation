//global_photon_block:
//photons {
  //spacing 0.0.15 | count <photons_to_shoot>

  //[gather <min_gather>, <max_gather>]
  //[media <max_steps> [,<factor>]]
  //[jitter <jitter_amount>]
  //[max_trace_level <photon_trace_level>]
  //[adc_bailout <photon_adc_bailout>]
  //[save_file "filename" | load_file "filename"]
  //[autostop <autostop_fraction>]
  //[expand_thresholds <percent_increase>, <expand_min>]
  //[radius <gather_radius>,<multiplier>,
    //      <gather_radius_media>,<multiplier>]
//}

global_settings{ 
        max_trace_level 25
        photons { 
                count 50000  
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
  location  <0, 14, -35>
  right    x*image_width/image_height
  rotate 6*y
  look_at   <0.25,0,0>  
  angle 23  
}

light_source { <-200, 100, -200>, color rgb<1,1,1> }  
light_source { <250, 100, -200>, color rgb<0,0,1> }   
light_source { <100, 50, -200>, color rgb<1,1,1> }
 
plane{  <0,1,0>,-1  
        pigment {rgb 0.5}
}//----
 
sphere { <0,0,0>, 1.5 

         texture { pigment{ rgb< 1, 0, 0.0> }
                   finish { diffuse 0.2 specular 0.6 roughness 0.01 reflection {1.5} }
                 } // end of texture 

          scale<1,1,1>  rotate<0,0,0>  translate<0,0.5,0>   
          photons {target 1.5 refraction on reflection on}
       }  // end of sphere -----------------------------------    

       
cylinder { <-1,0,0>,<1,0,0>, 0.30
           texture { pigment { color rgb<1,1,1>}
                     finish  { diffuse 0.2 roughness 0.01 reflection {1.5}  } 
                   } // end of texture
           scale <0.2,8,1> rotate<0,0,0> translate<-4,0,-4.5>  
            photons {target 1.5 refraction off reflection on}
         } // end of cylinder  ------------------------------------  
         
cone { <0,0,0>,-0.5,<0,1.00,0>, 1.0 
       open
       texture { pigment{ color rgbf<0.75,0.70,0.65, 0.915> }
                 finish { diffuse 0.2 specular 0.6 roughness 0.01 reflection {1.5}  } 
               } // end of texture

       scale <2,2,2> rotate<0,0,0> translate<4.0,0,-4.5> 
       photons {target 1.5 refraction on reflection on}        
     } // end of cone ------------------------------------------


//---------- End Radiosity and Photons