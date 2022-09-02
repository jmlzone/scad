module thmount () {
  difference(){
    union() {
      // main mount
      rotate([90,0,0])
	rotate_extrude(angle=90, $fn=100) {
	translate([15,0,0]) square([30,50],center=true);
      }
      //front extension
      translate([-3,0,(30/2)]) cube([8,50,30],center=true);
      //botom mouning flange
      //translate([11.5,0,1]) cube([37,60,2], center=true);
    }
    // cut out for display
    translate([-0.1,0,(30/2)]) cube([14.2,46,26], center=true);
    // mounting and breather holes
    translate([2,-25-2.5,-0.1]) cylinder(r=2,h=2.2, $fn=100);
    translate([2,25+2.5,-0.1]) cylinder(r=2,h=2.2, $fn=100);
    translate([5,0,-0.1]) cylinder(r=2,h=2.2, $fn=100);
    translate([5,20,-0.1]) cylinder(r=2,h=2.2, $fn=100);
    translate([5,-20,-0.1]) cylinder(r=2,h=2.2, $fn=100);
    translate([22,-25-2.5,-0.1]) cylinder(r=2,h=2.2, $fn=100);
    translate([22,25+2.5,-0.1]) cylinder(r=2,h=2.2, $fn=100);
    // vent holes for ambien temperature
    translate([6.5,0,4]) cube([1.5,55,3], center=true);
    translate([6.5,0,25]) cube([1.5,55,3], center=true);
  }
}
thmount();
