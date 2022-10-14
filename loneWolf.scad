module triggerSwitchCutOut() {
  cube([29.25,14.25,31.6]) ; // top
  translate([0,-(16.9-14.25)/2,9.9]) cube([29.25,16.9,10.2]); //middle
  translate([0,-(15.6-14.25)/2,9.9]) cube([29.25,15.6,10]); // bottom
  translate([0,(14.25-11.7)/2,19.29]) cube([36.8,11.7,11.2]); // trigger shaft
  translate([4,-(10.8-14.25)/2,-15]) cube([21.25,10.8,47]); // wiring clearance  
  translate([29,(14.25-12)/2,12]) cube([28,12,28]); // trigger blade clearence from front surface from bottom
  translate([-4,(14.25-6)/2,-15]) cube([13,6,55]); // back side wire path to meter
}

module wireChannel (){
  hull() {
    translate([-4.7/2,0,0]) cylinder(r=4.7/2,h=110, $fn=100);
    translate([4.7/2,0,0]) cylinder(r=4.7/2,h=110,$fn=100);
  }
}
thread3mm = 2.5/2;

module meterCover() {
  difference() {
    //cube([60,35,12] , center=true);
    hull() {
      translate([-25,-12.5,0]) cylinder(r=10/2,h=12,center=true, $fn=100);
      translate([-25,12.5,0]) cylinder(r=10/2,h=12,center=true, $fn=100);
      translate([25,-12.5,0]) cylinder(r=10/2,h=12,center=true, $fn=100);
      translate([25,12.5,0]) cylinder(r=10/2,h=12,center=true, $fn=100);
    }
    translate([0,0,1.75]) cube ([22.7,14,8.9],center=true); //display recess
    translate([0,0,-4.5]) cube([33.5,18,6.1],center=true); //board area
    translate([0,0,-4.5]) cube([6,22,6.1],center=true); //wire releaf notch
    translate([-14,0,-2]) cylinder(r=thread3mm,h=7, $fn=100); // meter mount screws
    translate([14,0,-2]) cylinder(r=thread3mm,h=7,$fn=100);
    translate([-20,10.5,0]) cylinder(r=3.5/2,h=13,center=true, $fn=100); //front holes
    translate([-20,10.5,6]) cylinder(r=6.5/2,h=6.1,center=true, $fn=100);
    translate([-20,-10.5,0]) cylinder(r=3.5/2,h=13,center=true, $fn=100);
    translate([-20,-10.5,6]) cylinder(r=6.5/2,h=6.1,center=true, $fn=100);
    translate([20,0,0]) cylinder(r=3.5/2,h=13,center=true, $fn=100); // back hole
    translate([20,0,6]) cylinder(r=6.5/2,h=6.1,center=true, $fn=100); // back counter bore
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
module loneWolfMeterBase() {
  bh = 3;
  difference() {
    hull() {
      translate([-25,-12.5,0]) cylinder(r=10/2,h=bh,center=true, $fn=100);
      translate([-25,12.5,0]) cylinder(r=10/2,h=bh,center=true, $fn=100);
      translate([25,-12.5,0]) cylinder(r=10/2,h=bh,center=true, $fn=100);
      translate([25,12.5,0]) cylinder(r=10/2,h=bh,center=true, $fn=100);
    }
    translate([-20,10.5,-0.1]) cylinder(r=2.5/2,h=bh+1.1,center=true, $fn=100);
    translate([-20,-10.5,-0.1]) cylinder(r=2.5/2,h=bh+1.1,center=true, $fn=100);
    translate([20,0,-0.1]) cylinder(r=3.5/2,h=bh+1.1,center=true, $fn=100);
  }
}
include <BOSL2/std.scad>
$fn=100;
overall = 110;
cut = 82;
topHeight = overall - cut;
triggerBottom = 63;
msco=11.5;
module loneWolfHandleBottom() {
  difference() {
    union() {
        // was 110 tall, cutting at 82 and make new top section
      path = ellipse(r=[27,15]);
      linear_sweep(path, texture="diamonds",tex_size=[5,5], h=cut, style="concave");
      
      footpath = ellipse(r=[31,19]);
      linear_sweep(footpath, h=4);
      
      //translate( [0,0,110]) // rotate([0,22.5,0]) //cube([60,35,22],center=true);
	//loneWolfMeterBase();

    } // union
    translate([0,0,-0.1]) wireChannel();
    translate([12,14.5/2,triggerBottom]) rotate([0,0,180]) triggerSwitchCutOut();
    translate([0,msco,cut-16]) cylinder(h=17,r=thread3mm); // joint screws
    translate([0,-msco,cut-16]) cylinder(h=17,r=thread3mm);
    translate([20,0,cut-16]) cylinder(h=17,r=thread3mm);
  }
}
module loneWolfHandleTop() {
  // was 110 tall, cutting at 82 and make new top section
  //110-82 = 28
  difference() {
    union() {
      path = ellipse(r=[27,15]);
      linear_sweep(path, texture="diamonds",tex_size=[5,5], h=topHeight+1, style="concave");
      translate( [0,0,topHeight]) // rotate([0,22.5,0]) //cube([60,35,22],center=true);
	loneWolfMeterBase();

    } // union
    translate([12,14.5/2,triggerBottom-cut]) rotate([0,0,180]) triggerSwitchCutOut();
    translate([0,0,(topHeight/2)+3]) cube([25,10,topHeight],center=true); // wire room
    translate([0,msco,-0.1]) cylinder(h=topHeight+5,r=1.7); // joint screws
    translate([0,-msco,-0.1]) cylinder(h=topHeight+5,r=1.7);
    translate([20,0,-0.1]) cylinder(h=topHeight+5,r=1.7);
    translate([0,msco,3]) cylinder(h=topHeight+5,r=6.5/2); // joint counter bores
    translate([0,-msco,3]) cylinder(h=topHeight,r=6.5/2);
    // screw relief
    translate([-20,10.5,topHeight-4]) cylinder(r=2.5/2,h=5,center=true, $fn=100);
    translate([-20,-10.5,topHeight-4]) cylinder(r=2.5/2,h=5,center=true, $fn=100);
  }
}

//triggerSwitchCutOut();
//rotate([180,00,0]) meterCover();
loneWolfHandleBottom();
//rotate([180,00,0]) loneWolfHandleTop();
