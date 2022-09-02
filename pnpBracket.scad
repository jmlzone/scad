$fa=1;
$fs=0.4;
include <drawLatch.scad>

function fixy(left,in,y) = left ? (in ? -y : y ) : (in ? y : -y);
module rearbarebracket(h,left=true,in=true) {
    difference() {
        union () {
	  //translate([0,(fixy(left,in,20)-20),0]) cube([114,40,h]);
	  //translate([0,(fixy(left,in,42)-42),0]) cube([74,84,h]);
            if(left==in) {
                mirror([0,1,0]) roundedRearBlank(h);
            } else {
                roundedRearBlank(h);
            }
	  // outside support will need to flip left/right
	  translate([5,fixy(left,in,5),h]) cylinder(h=10,r=5);
	  translate([5,fixy(left,in,79),h]) cylinder(h=10,r=5);
            // pully spacer also flips left/right
	  translate([64,fixy(left,in,76),h]) cylinder(h=5,r=5);
        }
        // mounting holes
        translate([79,fixy(left,in,10),0]) cylinder(h=h,r=2.6);
        translate([79,fixy(left,in,30),0]) cylinder(h=h,r=2.6);
        translate([104,fixy(left,in,10),0]) cylinder(h=h,r=2.6);
        translate([104,fixy(left,in,30),0]) cylinder(h=h,r=2.6);
        // mounting holes counter bores
        translate([79,fixy(left,in,10),0]) cylinder(h=5,r=5.2);
        translate([79,fixy(left,in,30),0]) cylinder(h=5,r=5.2);
        translate([104,fixy(left,in,10),0]) cylinder(h=5,r=5.2);
        translate([104,fixy(left,in,30),0]) cylinder(h=5,r=5.2);
        // holes through supports/spacers
        // outside support will need to flip left/right
        translate([5,fixy(left,in,5),0]) cylinder(h=(h+10),r=1.5);
        translate([5,fixy(left,in,79),0]) cylinder(h=(h+10),r=1.5);
        // pully spacer also flips left/right
        translate([64,fixy(left,in,76),0]) cylinder(h=(h+5),r=2.5); 
        if(in) { // inside has extra counterbores
         // holes through supports/spacers
        // outside support will need to flip left/right
        translate([5,fixy(left,in,5),0]) cylinder(h=4,r=3.5);
        translate([5,fixy(left,in,79),0]) cylinder(h=4,r=3.5);
        // pully spacer also flips left/right
        translate([64,fixy(left,in,76),0]) cylinder(h=5,r=5.2);
        }       
    }
}
module nema17(h){
    union() {
        cylinder(h=h, r=12);
        translate([15.5,15.5,0]) cylinder(h=h,r=1.55);
        translate([-15.5,15.5,0]) cylinder(h=h,r=1.55);
        translate([15.5,-15.5,0]) cylinder(h=h,r=1.55);
        translate([-15.5,-15.5,0]) cylinder(h=h,r=1.55);
        // 6mm x 4mm counter bores on the top
        translate([15.5,15.5,(h-4)]) cylinder(h=4,r=3.5);
        translate([-15.5,15.5,(h-4)]) cylinder(h=4,r=3.5);
        translate([15.5,-15.5,(h-4)]) cylinder(h=4,r=3.5);
        translate([-15.5,-15.5,(h-4)]) cylinder(h=4,r=3.5);

    }
}
module rearBracket(thick=8,left=true,in=true) {
  difference () {
    rearbarebracket(thick,left,in);
    if(in) {
      translate([24,fixy(left,in,31),0]) nema17(thick);
      //switch mount
      translate([62,fixy(left,in,44),0]) cylinder(h=thick,r=1);
      translate([62,fixy(left,in,54),0]) cylinder(h=thick,r=1);
    } else {
      translate([24,fixy(left,in,31),0]) cylinder(h=thick,r=10);
    }
  }
}
module roundBox(x,y,z,r) {
    points = [[r,r,0], [(x-r),r,0], [(x-r),(y-r),0],[r,(y-r),0]];
    hull() {
        for(p=points) {
            translate(p) cylinder(r=r,h=z);
        }
    }
}
module halfRoundBox(x,y,z,r) {
    points = [[r,r,0], [(x-r),r,0], [(x-r),(y-r),0],[0,(y-r),0]];
    hull() {
    //union(){
        for(p=points) {
            //echo("p=[1]",p[1]);
            if(p[1] > (y/2)) {
            translate(p) cube([r,r,z]);
            } else {
            translate(p) cylinder(r=r,h=z);
            }
        }
    }
}

module cornerbl(r,h) {
      difference() {
          translate([-r,-r,0]) cube([r,r,h]);
          intersection () {
          cylinder(r=r,h=h);
          translate([-r,-r,0]) cube([r,r,h]);
          //translate([r,r,0]) cube([r,r,h]);
          //translate([r,0,0]) cube([r,r,h]);
          }
      }
  }
module roundedRearBlank (h) {
    union () {
	  roundBox(114,40,h,5);
	  roundBox(74,84,h,5);
      translate([79,45,0]) cornerbl(5,h);
    }  
}
module roundedFrontBlank (h) {
    union () {
	  roundBox(80,40,h,5);
	  roundBox(40,84,h,5);
      translate([45,45,0]) cornerbl(5,h);
    }  
}
//for the side to side x, shorten the driven and passive by 10 mm.
module XdrivenBlank (h) {
    union () {
	  translate([0,20,0]) roundBox(114,20,h,5);
	  roundBox(64,78,h,5);
      translate([69,45,0]) cornerbl(5,h);
      translate([69,15,0]) rotate(270) cornerbl(5,h);
      // bottom "flag" for belt connection
      translate([(64+25),0,0]) halfRoundBox(20,20,h,5);
    }  
}
module XpassiveBlank (h) {
    union () {
	  translate([0,20,0]) roundBox(80,20,h,5);
	  roundBox(30,78,h,5);
      translate([35,45,0]) cornerbl(5,h);
      translate([35,15,0]) rotate(270) cornerbl(5,h);
      // bottom "flag" for belt connection
      translate([(30+25),0,0]) halfRoundBox(20,20,h,5);
    }  
}
module frontbarebracket(h,left=true,in=true) {
    difference() {
        union () {
            if(left==in) {
                mirror([0,1,0]) roundedFrontBlank(h);
            } else {
                roundedFrontBlank(h);
            }
	  // outside support will need to flip left/right
	  translate([5,fixy(left,in,5),h]) cylinder(h=10,r=5);
	  translate([5,fixy(left,in,79),h]) cylinder(h=10,r=5);
      // top pully spacer also flips left/right
	  translate([30,fixy(left,in,76),h]) cylinder(h=5,r=5);
      // bottom pully spacer also flips left/right
	  translate([10,fixy(left,in,28),h]) cylinder(h=5,r=5);
        }
        // mounting holes
        translate([45,fixy(left,in,10),0]) cylinder(h=h,r=2.6);
        translate([45,fixy(left,in,30),0]) cylinder(h=h,r=2.6);
        translate([70,fixy(left,in,10),0]) cylinder(h=h,r=2.6);
        translate([70,fixy(left,in,30),0]) cylinder(h=h,r=2.6);
        // mounting holes counter bores
        translate([45,fixy(left,in,10),0]) cylinder(h=5,r=5.2);
        translate([45,fixy(left,in,30),0]) cylinder(h=5,r=5.2);
        translate([70,fixy(left,in,10),0]) cylinder(h=5,r=5.2);
        translate([70,fixy(left,in,30),0]) cylinder(h=5,r=5.2);
        // holes through supports/spacers
        // outside support will need to flip left/right
        translate([5,fixy(left,in,5),0]) cylinder(h=(h+10),r=1.5);
        translate([5,fixy(left,in,79),0]) cylinder(h=(h+10),r=1.5);
        // pully spacer also flips left/right
        translate([30,fixy(left,in,76),0]) cylinder(h=(h+5),r=2.5); 
        translate([10,fixy(left,in,28),0]) cylinder(h=(h+5),r=2.5); 
        if(in) { // inside has extra counterbores
         // holes through supports/spacers
        // outside support will need to flip left/right
        translate([5,fixy(left,in,5),0]) cylinder(h=4,r=3.5);
        translate([5,fixy(left,in,79),0]) cylinder(h=4,r=3.5);
        // pully spacer also flips left/right
        translate([30,fixy(left,in,76),0]) cylinder(h=5,r=5.2);
        translate([10,fixy(left,in,28),0]) cylinder(h=5,r=5.2);
        }       
    }
}
module frontBracket(thick=8,left=true,in=true) {
  difference () {
    frontbarebracket(thick,left,in);
    if(in) {
      //switch mount
      translate([28,fixy(left,in,44),0]) cylinder(h=thick,r=1);
      translate([28,fixy(left,in,54),0]) cylinder(h=thick,r=1);
    }
  }
}

module XdrivenBracket(h,left=true,in=true) {
    difference() {
        union () {
            if(left==in) {
                mirror([0,1,0]) XdrivenBlank(h);
            } else {
                XdrivenBlank(h);
            }
	  // outside support will need to flip left/right
	  translate([5,fixy(left,in,5),h]) cylinder(h=10,r=5);
	  translate([5,fixy(left,in,73),h]) cylinder(h=10,r=5);
            // pully spacer also flips left/right
	  translate([54,fixy(left,in,70),h]) cylinder(h=5,r=5);
        }
        // mounting holes
        translate([69,fixy(left,in,30),0]) cylinder(h=h,r=2.6);
        translate([104,fixy(left,in,30),0]) cylinder(h=h,r=2.6);
        // mounting holes counter bores
        translate([69,fixy(left,in,30),0]) cylinder(h=5,r=5.2);
        translate([104,fixy(left,in,30),0]) cylinder(h=5,r=5.2);
        // hole for belt tensioner clamp
        translate([99,fixy(left,in,10),0]) cylinder(h=h,r=2.75);
        // holes through supports/spacers
        // outside support will need to flip left/right
        translate([5,fixy(left,in,5),0]) cylinder(h=(h+10),r=1.5);
        translate([5,fixy(left,in,73),0]) cylinder(h=(h+10),r=1.5);
        // pully spacer also flips left/right
        translate([54,fixy(left,in,70),0]) cylinder(h=(h+5),r=2.5); 
        if(in) { // inside has extra counterbores
         // holes through supports/spacers
        // outside support will need to flip left/right
        translate([5,fixy(left,in,5),0]) cylinder(h=4,r=3.5);
        translate([5,fixy(left,in,73),0]) cylinder(h=4,r=3.5);
        // pully spacer also flips left/right
        translate([54,fixy(left,in,70),0]) cylinder(h=5,r=5.2);
        }
	if(in) {
	  translate([24,fixy(left,in,31),0]) nema17(h);
	  //switch mount
	  translate([52,fixy(left,in,44),0]) cylinder(h=h,r=1);
	  translate([52,fixy(left,in,54),0]) cylinder(h=h,r=1);
	} else {
	  translate([24,fixy(left,in,31),0]) cylinder(h=h,r=10);
	}
    }
}
module XpassiveBracket(h,left=true,in=true) {
    difference() {
        union () {
            if(left==in) {
                mirror([0,1,0]) XpassiveBlank(h);
            } else {
                XpassiveBlank(h);
            }
	  // outside support will need to flip left/right
	  translate([5,fixy(left,in,5),h]) cylinder(h=10,r=5);
	  translate([5,fixy(left,in,73),h]) cylinder(h=10,r=5);
      // top pully spacer also flips left/right
	  translate([20,fixy(left,in,70),h]) cylinder(h=5,r=5);
      // bottom pully spacer also flips left/right
	  translate([10,fixy(left,in,28),h]) cylinder(h=5,r=5);
        }
        // mounting holes
        translate([35,fixy(left,in,30),0]) cylinder(h=h,r=2.6);
        translate([70,fixy(left,in,30),0]) cylinder(h=h,r=2.6);
        // mounting holes counter bores
        translate([35,fixy(left,in,30),0]) cylinder(h=5,r=5.2);
        translate([70,fixy(left,in,30),0]) cylinder(h=5,r=5.2);
        // hole for belt tensioner clamp
        translate([65,fixy(left,in,10),0]) cylinder(h=h,r=2.75);
        
        // holes through supports/spacers
        // outside support will need to flip left/right
        translate([5,fixy(left,in,5),0]) cylinder(h=(h+10),r=1.5);
        translate([5,fixy(left,in,73),0]) cylinder(h=(h+10),r=1.5);
        // pully spacer also flips left/right
        translate([20,fixy(left,in,70),0]) cylinder(h=(h+5),r=2.5); 
        translate([10,fixy(left,in,28),0]) cylinder(h=(h+5),r=2.5); 
        if(in) { // inside has extra counterbores
         // holes through supports/spacers
        // outside support will need to flip left/right
        translate([5,fixy(left,in,5),0]) cylinder(h=4,r=3.5);
        translate([5,fixy(left,in,73),0]) cylinder(h=4,r=3.5);
        // pully spacer also flips left/right
        translate([20,fixy(left,in,70),0]) cylinder(h=5,r=5.2);
        translate([10,fixy(left,in,28),0]) cylinder(h=5,r=5.2);
        }       
	if(in) {
	  //switch mount
	  translate([18,fixy(left,in,44),0]) cylinder(h=h,r=1);
	  translate([18,fixy(left,in,54),0]) cylinder(h=h,r=1);
	}
    }
}

module beltClamp(h) {
  difference() {
    roundBox(20,25,h,5);
    translate([10,10,0]) cylinder(h=h,r=2.75);
    translate([(10-3.5),20,0]) cube([7,2,h]);
  }
}
module beltClampX(h) {
  difference() {
    roundBox(20,20,h,5);
    translate([10,15,0]) cylinder(h=h,r=2.75);
    translate([10,5,0]) cylinder(h=h,r=1.75);
    translate([(10-3.5),9,0]) cube([7,2,h]);
  }
}
module beltClamp6(h) {
  points = [[-46,2,0], [-22,2,0], [2,2,0],[26,2,0],];
	    //[-46,-27,0], [-22,-27,0], [2,-27,0],[26,-27,0]];
    union(){
        for(p=points) {
	  translate(p) beltClamp(h);
	}
	translate([-22,-22,0]) beltClampX(h);
	translate([2,-22,0]) beltClampX(h);
    }
}

module standoff(od,id,h,bd) {
  difference() {
    cylinder(h=h,r=(od/2));
    translate([0,0,(h-bd)]) cylinder(h=bd+0.1,r=(id/2));
  }
}
module bumper(od,h) {
    cylinder(h=h,r=(od/2));
}

module smoothiestandoffs() {
  //for testing
  //h = 2;
  //bd = 1;
  // for final mount
  h = 4;
  bd = 4;
  sd = 2; // screw diameter
    
  // reference point is the lower rignt corner
  union () {
    translate([-3.75,3.75,0])  standoff(6,sd,h,bd); // reference
    translate([-103,3.75,0])   standoff(6,sd,h,bd); //good
    translate([-126,45.5,0])   standoff(6,sd,h,bd); // 126 good, down 0.5
    translate([-126,56,0])   standoff(6,sd,h,bd);
    translate([-10.1,96.5,0])  standoff(6,sd,h,bd); // good
    translate([-102.5,101,0])    standoff(6,sd,h,bd); //good
  }
}
module smoothieHoles(h) {
  sr = 2/2; // screw diameter
  union () {
    translate([-3.75,3.75,0])  cylinder(h=h,r=sr);
    translate([-103,3.75,0])   cylinder(h=h,r=sr);
    translate([-126,45.5,0])   cylinder(h=h,r=sr);
    translate([-126,56,0])     cylinder(h=h,r=sr);
    translate([-10.1,96.5,0])  cylinder(h=h,r=sr);
    translate([-102.5,101,0])  cylinder(h=h,r=sr);
  }
}
module extDriverStandoffs() {
  //for testing
  //h = 2;
  //bd = 1;
  // for final mount
  h = 4;
  bd = 4;
  sd = 2; // screw diameter
  // reference point is the lower rignt corner
  union() {
    translate([(42-5),(35-4),0])  standoff(6,sd,h,bd);
    translate([(42-37),(35-4),0])  standoff(6,sd,h,bd);
    translate([(37),(35-31),0])  bumper(6,h);
    translate([(17),(35-18),0])  bumper(6,h);
  }
}
module extDriverHoles(h) {
  sr = 2/2; // screw diameter
  union () {
    translate([(42-5),(35-4),0])  cylinder(h=h,r=sr);
    translate([(42-37),(35-4),0]) cylinder(h=h,r=sr);
  }
}
module fanin(t) {
  union(){
    cylinder(r=12.5,h=t);
 /*   difference() {
      cylinder(r=25,h=t);
      cylinder(r=23,h=t);
    }
      */
    translate([-2,0,0]) cube([4,24,t]);
    rotate(240) translate([-2,0,0]) cube([4,24,t]);
    rotate(120) translate([-2,0,0]) cube([4,24,t]);
  }
}
module fan50mmv(t) {
  rotate([0,270,0])
    difference() {
    cube([50,50,t]);
    union(){
      difference() {
	cube([50,50,t]);     
	//mounting holes
	points=[[5,5,0],[45,5,0],[5,45,0],[45,45,0]];
	for(p=points) {
	  translate(p) cylinder(h=t,r=2);
	}
	translate([25,25,0]) cylinder(r=23,h=t);
      }
      translate([25,25,0]) fanin(t);
    }
  }
}

module clippedCylinder(h,d,cw) {
  // h is the height
  // d is the diameter.
  // cw ios the clipped width
  r=d/2; // cylinder radius
  cd =cw/2; // clip displacement is +/- ha;f the width 
  difference() {
    cylinder(h=h,r=r);
    translate([-(cd+r),-r,0]) cube([r,d,h]);
    translate([cd,-r,0]) cube([r,d,h]);
  }
}
module headMount() {
    difference () {
    union() {
      //cube([110,67,10]);
      roundBox(110,76,10,5);
      // tab for mounting drag chain
      translate([110-21,0,0]) cube ([16,67+23.4-4,10]);
      // endstop tabs
      translate([0,(13+38-4),0]) cube([5,8,17]);
      translate([110-5,(13+38-4),0]) cube([5,8,17]);
      //overhang for head
      translate([(110/2)-(58.2/2),0,0]) cube([58.2,8,28]);
          }
    //5.5 mm holes for mounting to linear bearing
    translate([40,13,-0.1]) cylinder (h=10.2,r=2.75) ;
    translate([40+30,13,-0.1]) cylinder (h=10.2,r=2.75) ;
    translate([40,13+38,-0.1]) cylinder (h=10.2,r=2.75) ;
    translate([40+30,13+38,-0.1]) cylinder (h=10.2,r=2.75) ;
    // counter bore for mounting holes
    translate([40,13,-0.1]) cylinder (h=5.1,r=5.2) ;
    translate([40+30,13,-0.1]) cylinder (h=5.1,r=5.2) ;
    translate([40,13+38,-0.1]) cylinder (h=5.1,r=5.2) ;
    translate([40+30,13+38,-0.1]) cylinder (h=5.1,r=5.2) ;
    // clip 11mm off the back for all but the last 16mm
    translate([-0.1,67-9,-0.1]) cube ([110-21,20.1,10.2]);
    // mounting holes for head
    translate([(110/2)-(46/2),-0.1,5]) rotate([-90,0,0]) cylinder(h=70.2,r=1.25);
    translate([(110/2)-(46/2)+46,-0.1,5]) rotate([-90,0,0]) cylinder(h=70.2,r=1.25);
    // second set 18mm away
    translate([(110/2)-(46/2),-0.1,5+18]) rotate([-90,0,0]) cylinder(h=70.2,r=1.25);
    translate([(110/2)-(46/2)+46,-0.1,5+18]) rotate([-90,0,0]) cylinder(h=60.2,r=1.25);    
    // holes for timing belt clamps
    translate([20,30.5,-0.1]) cylinder (h=10.2,r=(4.3/2)) ;
    translate([110-20,30.5,-0.1]) cylinder (h=10.2,r=(4.3/2)) ;
    // holes in the tabs for endstop screws
    translate([-0.1,(13+38),14]) rotate ([0,90,0]) cylinder(h=5.2,r=1.25);
    translate([110-5.1,(13+38),14]) rotate ([0,90,0]) cylinder(h=5.2,r=1.25);
    // hole for the chain clamp
    translate([110-21+8,63+(23.4/2),-0.1]) cylinder (h=10.2,r=(4.3/2)) ;
  }
}

module smoothieBoardBoxBottom() {
  sd=2;
  union() {
    // box outer
    boxHeight = 54;
    bd=10;
    innerX = 146;
    innerY = 119+60+6+1;
    bottomThick = 2;
    wallWidth = 2;
    outerX = innerX +(2*wallWidth);
    outerY = innerY +(2*wallWidth);
    difference(){
      roundBox(outerX,outerY,boxHeight,5);
      translate([wallWidth,wallWidth,bottomThick]) 
	roundBox((outerX-(2*wallWidth)),(outerY-(2*wallWidth)),(boxHeight),5);
	//cut out for sd card
	translate([(outerX-wallWidth),84,(2+4+0.4)]) cube([wallWidth+0.1,14,3]); 
	//cut out for ethernet
	translate([(outerX-wallWidth),101,(2+4+1.4)]) cube([wallWidth+0.1,16,13]); 
	//cut out for usb
	translate([(outerX-wallWidth),120,(2+4+1.4)]) cube([wallWidth+0.1,12,11]);
	//fans
        translate([(wallWidth*1.5),10,(bottomThick+1)]) fan50mmv(wallWidth*2);
        translate([(wallWidth*1.5),65,(bottomThick+1)]) fan50mmv(wallWidth*2);
        // add vent slots on other x end
        for(yindex =[0:1:3] )
            for(zindex=[0:1:3])
                translate([(outerX-wallWidth),(10+(20*yindex)),(15+(9*zindex))]) cube([wallWidth+0.1,15,4]);
        // add mounting holes on bottom
        translate([40,13,0]) cylinder(h=bottomThick+0.1,r=2.75);
        translate([110,13,0]) cylinder(h=bottomThick+0.1,r=2.75);
        translate([40,163,0]) cylinder(h=bottomThick+0.1,r=2.75);
        translate([110,163,0]) cylinder(h=bottomThick+0.1,r=2.75);
        // add motor wire holes on bottom edge (2 wall width)
        translate([42,0,(2+4+1.6)]) cube([12,wallWidth+0.1,12]); 
        translate([87,0,(2+4+1.6)]) cube([12,wallWidth+0.1,12]); 
        translate([126,0,(2+4+1.6)]) cube([12,wallWidth+0.1,12]); 
        // add wiring holes on both top ends
        translate([0,145,20]) cube([wallWidth+0.1,20,20]);
        translate([outerX-wallWidth,145,20]) cube([wallWidth+0.1,20,20]);
        // through holes for the smoothie board stand offs so they can be tapped from the outside
	translate([(outerX-wallWidth),(wallWidth+35+6),0])smoothieHoles(bottomThick);
	// 3 external driver board holes
	translate([(outerX-(wallWidth+44+3)),(wallWidth+6),0]) extDriverHoles(bottomThick) ;
	translate([(outerX-(wallWidth+88+2)),(wallWidth+6),0]) extDriverHoles(bottomThick) ;
	translate([(outerX-(wallWidth+132+2)),(wallWidth+6),0]) extDriverHoles(bottomThick) ;
	// holes for the fan power board
	translate([0,135,20]) rotate([0,90,0]) cylinder(h=wallWidth,r=1);
	translate([0,135,45]) rotate([0,90,0]) cylinder(h=wallWidth,r=1);
	// clipped hole for power inlet
	translate([0,135,10]) rotate([0,90,0]) rotate([0,0,90]) clippedCylinder(wallWidth+.1,7.6,6.7);
    }  // difference (cutouts and holes)
    // box cover supports/screws in the 4 corners
   translate([5,5,0]) standoff(10,3,boxHeight+0.1,bd);
   translate([(outerX-5),5,0]) standoff(10,3,boxHeight+0.1,bd);
   translate([5,(outerY-5),0]) standoff(10,3,boxHeight+0.1,bd);
   translate([(outerX-5),(outerY-5),0]) standoff(10,3,boxHeight+0.1,bd);
   // add board mount standoffs for fan power distribution
    translate([wallWidth,135,20]) rotate([0,90,0]) standoff(6,sd,4,4);
    translate([wallWidth,135,45]) rotate([0,90,0]) standoff(6,sd,4,4);
    // we need 25 mm from top of board to inside edge of box.
    // need 35 mm from bottom edge to edge of box
    translate([(outerX-wallWidth),(wallWidth+35+6),bottomThick])smoothiestandoffs();
    // 3 external driver board
    translate([(outerX-(wallWidth+44+3)),(wallWidth+6),bottomThick]) extDriverStandoffs() ;
    translate([(outerX-(wallWidth+88+2)),(wallWidth+6),bottomThick]) extDriverStandoffs() ;
    translate([(outerX-(wallWidth+132+2)),(wallWidth+6),bottomThick]) extDriverStandoffs() ;
    // add 4 latch bases 10mm down from the top and 10 in from the edges
    translate([10,outerY,boxHeight-10]) rotate([270,0,0]) translate([0,0,0]) base();
    translate([outerX-10-overallWidth,outerY,boxHeight-10]) rotate([270,0,0]) translate([0,0,0]) base();

    translate([10+overallWidth,0,boxHeight-10]) rotate([270,0,180]) translate([0,0,0]) base();
    translate([outerX-10,0,boxHeight-10]) rotate([270,0,180]) translate([0,0,0]) base();

  }
}
module smoothieBoardBoxTop() {
  sd=2;
  union() {
    // box outer
    boxHeight = 54;
    topHeight = 10;
    bd=10;
    innerX = 146;
    innerY = 119+60+6+1;
    bottomThick = 2;
    wallWidth = 2;
    outerX = innerX +(2*wallWidth);
    outerY = innerY +(2*wallWidth);
    topOuterX = outerX + (2*wallWidth) + 1;
    topOuterY = outerY + (2*wallWidth) + 1;
    difference(){
      roundBox(topOuterX,topOuterY,topHeight+bottomThick,5);
      translate([wallWidth,wallWidth,bottomThick]) 
	roundBox((outerX+1),(outerY+1),(topHeight+.1),5);
      // screw holes in corners
      translate([(5+wallWidth+.5),(5+wallWidth+.5),0]) cylinder(r=(3.5/2), h=bottomThick+.1);
      translate([((outerX-5)+wallWidth+.5),(5+wallWidth+.5),0]) cylinder(r=(3.5/2), h=bottomThick+.1);
      translate([(5+wallWidth+.5),((outerY-5)+wallWidth+.5),0]) cylinder(r=(3.5/2), h=bottomThick+.1);
      translate([((outerX-5)+wallWidth+.5),((outerY-5)+wallWidth+.5),0]) cylinder(r=(3.5/2), h=bottomThick+.1);
      // nice mounting holes
        translate([42.5,15.5,0]) cylinder(h=bottomThick+0.1,r=2.75);
        translate([112.5,15.5,0]) cylinder(h=bottomThick+0.1,r=2.75);
        translate([42.5,165.5,0]) cylinder(h=bottomThick+0.1,r=2.75);
        translate([112.5,165.5,0]) cylinder(h=bottomThick+0.1,r=2.75);
      // fan cleanance
      translate([outerX,8,bottomThick]) cube([4*wallWidth,110,topHeight+.1]);
    }
    // catches for latches
    translate([10+.5+wallWidth+overallWidth,0,topHeight+bottomThick]) rotate([90,180,0]) translate([0,0,0]) catchPlate();
    translate([.5+wallWidth+outerX-10,0,topHeight+bottomThick]) rotate([90,180,0]) translate([0,0,0]) catchPlate();
    translate([10+.5+wallWidth,topOuterY,topHeight+bottomThick]) rotate([90,180,180]) translate([0,0,0]) catchPlate();
    translate([.5+wallWidth+outerX-10-overallWidth,topOuterY,topHeight+bottomThick]) rotate([90,180,180]) translate([0,0,0]) catchPlate();
  }
}
module atxBoxTop() {
  sd=2;
  union() {
    // box outer
    boxHeight = 30;
    topHeight = 5;
    bd=10;
    innerX = 141;
    innerY = 60;
    bottomThick = 2;
    wallWidth = 2;
    outerX = innerX +(2*wallWidth);
    outerY = innerY +(2*wallWidth);
    topOuterX = outerX + (2*wallWidth) + 1;
    topOuterY = outerY + (2*wallWidth) + 1;
    difference(){
      roundBox(topOuterX,topOuterY,topHeight+bottomThick,5);
      translate([wallWidth,wallWidth,bottomThick]) 
	roundBox((outerX+1),(outerY+1),(topHeight+.1),5);
      // screw holes in corners
      translate([(5+wallWidth+.5),(5+wallWidth+.5),0]) cylinder(r=(3.5/2), h=bottomThick+.1);
      translate([((outerX-5)+wallWidth+.5),(5+wallWidth+.5),0]) cylinder(r=(3.5/2), h=bottomThick+.1);
      translate([(5+wallWidth+.5),((outerY-5)+wallWidth+.5),0]) cylinder(r=(3.5/2), h=bottomThick+.1);
      translate([((outerX-5)+wallWidth+.5),((outerY-5)+wallWidth+.5),0]) cylinder(r=(3.5/2), h=bottomThick+.1);
    }
  }
}
module atxBoxBottom() {
  sd=2;
  union() {
    // box outer
    boxHeight = 35;
    bd=10;
    innerX = 141;
    innerY = 60;
    bottomThick = 2;
    wallWidth = 2;
    outerX = innerX +(2*wallWidth);
    outerY = innerY +(2*wallWidth);
    difference(){
      roundBox(outerX,outerY,boxHeight,5);
      translate([wallWidth,wallWidth,bottomThick]) 
	roundBox((outerX-(2*wallWidth)),(outerY-(2*wallWidth)),(boxHeight),5);
      //cutout for atx  plug
      translate([43,-0.1,8]) cube([58,wallWidth+0.2,15]);
      // cutout for usb plugs
      translate([60,-0.1,22]) cube([39,wallWidth+0.2,10]);
      // cutout for power control
      translate([110,-0.1,17]) cube([10,wallWidth+0.2,10]);
      // though holes for board support
      translate([11,12,-0.1])  cylinder(r=1,h=bottomThick+0.2);
      translate([11+123,12,-0.1]) cylinder(r=1,h=bottomThick+0.2);
      translate([11,12+42,-0.1])  cylinder(r=1,h=bottomThick+0.2);
      translate([11+123,12+42,-0.1])cylinder(r=1,h=bottomThick+0.2);
      // mounting holes
      translate([10,(outerY/2)+10,-0.1])  cylinder(r=(5.5/2),h=bottomThick+0.2);
      translate([10,(outerY/2)-10,-0.1])  cylinder(r=(5.5/2),h=bottomThick+0.2);
      translate([outerX-10,(outerY/2)+10,-0.1])  cylinder(r=(5.5/2),h=bottomThick+0.2);
      translate([outerX-10,(outerY/2)-10,-0.1])  cylinder(r=(5.5/2),h=bottomThick+0.2);
      
    }  // difference (cutouts and holes)
    // box cover supports/screws in the 4 corners
   translate([5,5,0]) standoff(10,3,boxHeight+0.1,bd);
   translate([(outerX-5),5,0]) standoff(10,3,boxHeight+0.1,bd);
   translate([5,(outerY-5),0]) standoff(10,3,boxHeight+0.1,bd);
   translate([(outerX-5),(outerY-5),0]) standoff(10,3,boxHeight+0.1,bd);
  //standoffs for board mount 
  translate([11,12,0])  standoff(5,2,6,7); // reference
  translate([11+123,12,0])  standoff(5,2,6,7);
  translate([11,12+42,0])  standoff(5,2,6,7); 
  translate([11+123,12+42,0])  standoff(5,2,6,7);
  } // union
} //atxBoxBottom
module beltClip(bottom=false) {
  difference() {
    union() {
      hull() {
	cylinder(h=3, r=5);
	translate([12,0,0]) cylinder(h=3, r=5);
      }
      if(bottom) {
	translate([0,0,0]) cylinder(h=6, r=4);
	translate([12,0,0]) cylinder(h=6, r=4);
      }
    }
    translate([0,0,-0.1]) cylinder(h=6.2, r=(3.5/2));
    translate([12,0,-0.1]) cylinder(h=6.2, r=(3.5/2));
    if(bottom) {
      translate([0,0,3.5]) cylinder(h=3, r=6.3/2,$fn=6);
      translate([12,0,3.5]) cylinder(h=3, r=6.3/2,$fn=6);
    }
  }
}

// Right rear brackets
//translate ([0,4,0]) rearBracket(8,left=false,in=true);
//translate ([0,-4,0]) rearBracket(8,left=false,in=false);

//left rear brackets
//translate ([0,-4,0]) rearBracket(8,left=true,in=true);
//translate ([0,4,0]) rearBracket(8,left=true,in=false);

//roundedRearBlank(8);
//mirror([0,1,0]) roundedRearBlank(8);
// front right side brackets
//translate ([0,4,0]) frontBracket(8,left=false,in=true);
//translate ([0,-4,0]) frontBracket(8,left=false,in=false);

// front left side brackets
//translate ([0,-4,0]) frontBracket(8,left=true,in=true);
//translate ([0,4,0]) frontBracket(8,left=true,in=false);

//passive bracket for right end motor is on the left (in == rear)
//translate ([0,-4,0]) XpassiveBracket(8,left=true,in=true);
//translate ([0,4,0] ) XpassiveBracket(8,left=true,in=false);

// driven bracket for x with motor to the rear
//translate ([0,4,0]) XdrivenBracket(8,left=false,in=true);
//translate ([0,-4,0]) XdrivenBracket(8,left=false,in=false);

//test the blank shapes
//XpassiveBlank(1);
//XdrivenBlank(1);
//halfRoundBox(20,20,1,5);
//translate([0,135,10]) rotate([0,90,0]) rotate([0,0,90]) clippedCylinder(2,7.6,6,7);
//beltClamp6(5);
//smoothieBoardBoxBottom();
//smoothieBoardBoxTop();
//fan50mmv(2);
//fanin(2);
//rotate(a=90,v=[1,0,0]) roundBox(20,20,2+0.1,5);

//headMount();
//atxBoxBottom();
//atxBoxTop();

beltClip();
translate([0,12,0]) beltClip(bottom=true);
