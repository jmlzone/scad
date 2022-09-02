  // outside dimestions from data sheet
OUT_height = 6;
A = 2.0; // pitch
OUT_W = 4.5;
OUT_E = 1.95;
  // measured inside dimensions
IN_W = 3.66;
IN_E = 1.25;
bottom_thick_p = 1.6; //not on the data sheet on the pin side
bottom_thick_e = 1.0; //away from the pins
module jstph(npins=2,extra_thick=0.2,extra_clearence=0.2,pinr=1/2) {
  // origen is at the center of the bottom of the connector
  OUT_B = (2*OUT_E) + ((npins-1) * A);
  out_x = (2*extra_thick) + OUT_B;
  out_y = (2*extra_thick) + OUT_W;
  in_x = (2*IN_E)  + ((npins-1) * A) + (2*extra_clearence);
  in_y = IN_W + (2*extra_clearence);
  notch = npins==2 ? 1.2 : ((npins-2) *2);
  difference() {
    translate([-out_x/2,-out_y/2,0]) cube([out_x,out_y,OUT_height]); // outside
    translate([-in_x/2,-in_y/2,bottom_thick_p]) cube([in_x,in_y,OUT_height]); // main carve-out
    translate([-in_x/2,-in_y/2,bottom_thick_e]) cube([in_x,(in_y/2),OUT_height]); // extra carve out for edge
    // side reliefs on center line to front, 1mm wide 4mm from bottom
    translate([(-out_x/2)-0.1,0,4]) cube([1.5,1,2.1]); //left
    translate([(in_x/2)-0.1,0,4]) cube([1.5,1,2.1]); //right
    // big center notch
    translate([-notch/2,-in_y/2,bottom_thick_p]) cube([notch,out_y,OUT_height]); 
    // small front notches 1mm wide 2.7 mm high right along the inside edges
    translate([(-in_x/2),-in_y/2,bottom_thick_p]) cube([0.8,out_y,2.9]); //left
    translate([(in_x/2)-0.8,-in_y/2,bottom_thick_p]) cube([0.8,out_y,2.9]); //right
    // holes for pins
    for(p=[0:(npins-1)]) {
      translate([(-OUT_B/2)+1.95+(2*p),((OUT_W/2)-1.7),-0.1]) rotate([0,0,45]) cylinder(r=pinr,h=bottom_thick_p+0.2,$fn=4);
    }
  }
}
// this module makes a void for a connector
// basically its 1mm around the outside on all sides.
// instantiate this with a difference then
// union in the connector inside the void this makes.
module jstph_void(npins=2, clearence=1) {
  // calculated outside dimestions from data sheet
  // origen is at the center of the bottom of the connector
  OUT_B = (2*1.95) + ((npins-1) * A);
  y = (2*clearence) + OUT_W;
  x = (2*clearence) + OUT_B;
  translate([-x/2,-y/2,0]) cube([x,y,OUT_height]);
}
//jstph(npins=2);
