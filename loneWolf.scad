module triggerSwitchCutOut() {
  cube([29.25,14.25,31.6]) ; // top
  translate([0,-(16.9-14.25)/2,9.9]) cube([29.25,16.9,10.2]); //middle
  translate([0,-(14.8-14.25)/2,9.9]) cube([29.25,14.8,10]); // bottom
  translate([0,(14.25-11.7)/2,19.29]) cube([36.8,11.7,11.2]); // trigger shaft
}

module wireChannel (){
  hull() {
    translate([-2.25,0,0]) cylinder(r=4.5/2,h=110, $fn=100);
    translate([2.25,0,0]) cylinder(r=4.5/2,h=110,$fn=100);
  }
}
module meterCover() {
  difference() {
    //cube([60,35,12] , center=true);
    hull() {
      translate([-25,-12.5,0]) cylinder(r=10/2,h=12,center=true, $fn=100);
      translate([-25,12.5,0]) cylinder(r=10/2,h=12,center=true, $fn=100);
      translate([25,-12.5,0]) cylinder(r=10/2,h=12,center=true, $fn=100);
      translate([25,12.5,0]) cylinder(r=10/2,h=12,center=true, $fn=100);
    }
    translate([0,0,1.75]) cube ([22.7,14,8.9],center=true);
    translate([0,0,-3]) cube([33.5,18,6.1],center=true);
    translate([-14,0,0]) cylinder(r=1.4,h=5, $fn=100);
    translate([14,0,0]) cylinder(r=1.4,h=5,$fn=100);
    translate([-24,0,0]) cylinder(r=3.5/2,h=13,center=true, $fn=100);
    translate([24,0,0]) cylinder(r=3.5/2,h=13,center=true, $fn=100);
    translate([-24,0,6]) cylinder(r=6.5/2,h=6.1,center=true, $fn=100);
    translate([24,0,6]) cylinder(r=6.5/2,h=6.1,center=true, $fn=100);
    // text on y- side
    translate([-29.2,0,0]) rotate([90,0,-90]) linear_extrude(height=0.9) {text("\\\\\\VGG", size=6, halign = "center", valign = "center", font="Tahoma", $fn = 16);}
    // Y + side
    translate([29.2,0,0]) rotate([90,0,90]) linear_extrude(height=1.9) {text("\\\\\\VGG", size=6, halign = "center", valign = "center", font="Tahoma", $fn = 16);}
    // X + side
    translate([0,16.7,0]) rotate([90,0,180]) linear_extrude(height=0.9) {text("Lone Wolf 2000", size=5, halign = "center", valign = "center", font="Tahoma", $fn = 16);}
    // text on x- side  
    translate([0,-16.7,0]) rotate([90,0,0]) linear_extrude(height=0.9) {text("Bring the THUNDER", size=4, halign = "center", valign = "center", font="Tahoma", $fn = 16);}
  }
}
//include <BOSL2/std.scad>
module loneWolfHandle() {
  difference() {
    union() {
      path = ellipse(r=[27,13]);
      linear_sweep(path, texture="diamonds",tex_size=[5,5], h=110, style="concave");
      
      footpath = ellipse(r=[31,17]);
      linear_sweep(footpath, h=4);
      
      translate( [0,0,110]) rotate([0,22.5,0]) cube([60,35,22],center=true);
    } // union
    wireChannel();
  }
}

//triggerSwitchCutOut();
meterCover();

