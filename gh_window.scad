include <gears.scad>;
gear_width=8;
//rack(modul, rack_length, rack_height, width)

//spur_gear (modul, gear_teeth, width, gear_bore)
module driveGear(){
  union() {
    spur_gear(2,14,gear_width+2,6);
    translate([-2,2.5,0]) cube([4,1,gear_width+3]);
  }
}
module driveGear2(){
  difference() {
    spur_gear(2,14,gear_width+2,10.5);
    //verticle holes for screws
    translate([-5.5,-5.5,-0.1]) cylinder(r=4/2,h=gear_width+3);
    translate([-5.5,5.5,-0.1]) cylinder(r=4/2,h=gear_width+3);
    translate([5.5,-5.5,-0.1]) cylinder(r=4/2,h=gear_width+3);
    translate([5.5,5.5,-0.1]) cylinder(r=4/2,h=gear_width+3);
    translate([-20,0,6.5]) rotate([0,90,0]) cylinder(r=4/2, h=40);
  }
}
module rackSlide() {
  difference(){
    union() {
      cube([12,199,2]);
      translate([2,100,10]) rotate([90,0,90]) rack (2, 200, 10, gear_width);
      translate([1,199,0]) cube([10,5,12]);
      translate([1,204,6]) rotate([0,90,0]) cylinder(r=10/2, h=10);
    }
    translate([0,204,6]) rotate([0,90,0]) cylinder(r=3.5/2, h=11.1);
    // pockets for magnets
    translate([6,5,-0.1]) cylinder(r=3,h=3.2);
    translate([6,200,-0.1]) cylinder(r=3,h=3.2);
  }
}
module rackSlide2() {
  difference(){
    union() {
      cube([12,199,2]);
      translate([2,100,10]) rotate([90,0,90]) rack (2, 200, 10, gear_width);
      translate([1,199,0]) cube([10,5,12]);
      translate([1,204,6]) rotate([0,90,0]) cylinder(r=10/2, h=10);
      // block for stop screw
      translate([2,193,0]) cube([20,5,12]);
    }
    translate([0,204,6]) rotate([0,90,0]) cylinder(r=3.5/2, h=11.1);
    // pockets for magnets
    //translate([6,5,-0.1]) cylinder(r=3,h=3.2);
    //translate([6,200,-0.1]) cylinder(r=3,h=3.2);
    // hole for stop screw 6mm up
    translate([18,190,6]) rotate([-90,0,0]) cylinder(r=2.9/2, h=11.1);
    // hole for endstop screw
    translate([6,-1,5]) rotate([-90,0,0]) cylinder(r=2.9/2, h=15.1);
    // hollow for steel reenforcement
    translate([6-(4.8/2),15,2]) cube([4.8,185,4.8]);
    
  }
}
module endCap() {
  difference(){
    union() {
      cube([26,12,2]);
      translate([0,0,0]) cube([6,10,4]);
      translate([14,0,0]) cube([12,10,4]);
    }

    translate([10,12-5,-0.1]) cylinder(r=3.5/2,h=3);
  }
}

module rackMount() {
    genericMount(extraOffset=0,tangGap=10,flange=10,pillar=5,width=10);
}
/*
  extraOffset = 7;
  difference(){
    union() {
      cube([45,12,2]);
      translate([12.5,1,0]) cube([5,10,12+extraOffset]);
      translate([27.5,1,0]) cube([5,10,12+extraOffset]);
    }
    // pin (bolt) hole
    translate([0,6,8+extraOffset]) rotate([0,90,0]) cylinder(r=2.9/2, h=45);
    // mounting holes 
    translate([8,6,-0.1]) cylinder(r=4/2, h=3);
    translate([37,6,-0.1]) cylinder(r=4/2, h=3);
  }
}
*/
module cpillar(x,y,z) {
  r = y/2;
  hull() {
    translate([-x/2,-y/2,0]) cube([x,y,z-r]);
    translate([-x/2,0,z-r]) rotate([0,90,0]) cylinder(r=r,h=x);
  }
}

module boxMount() {
  genericMount(extraOffset=6,tangGap=25.3,flange=9,pillar=5,width=10);
}
module genericMount(extraOffset=6,tangGap=25.3,flange=9,pillar=5,width=10) {
  baseWidth = width + 2;
  hullR = baseWidth/2;
  difference(){
    union() {
      translate([-((tangGap/2)+pillar+flange)+hullR,0,0])
	hull() {
	cylinder(r=hullR, h=2);
	translate([(tangGap+(2*(pillar+flange))-(2*hullR)),0,0]) cylinder(r=hullR, h=2);
      }
      //translate([-((tangGap/2)+pillar),-(width/2),0]) cube([pillar,width,12+extraOffset]);
      //translate([(tangGap/2),-(width/2),0]) cube([pillar,width,12+extraOffset]);
      translate([-((tangGap/2)+pillar/2),0,0]) cpillar(pillar,width,12+extraOffset);
      translate([(tangGap/2)+pillar/2,0,0]) cpillar(pillar,width,12+extraOffset);
    }
    // pin (bolt) hole
    translate([-(1+(tangGap/2)+pillar),0,8+extraOffset]) rotate([0,90,0]) cylinder(r=2.9/2, h=2+tangGap+(2*pillar));
    // mounting holes 
    translate([-((tangGap/2)+pillar+(flange/2)),0,-0.1]) cylinder(r=4/2, h=3);
    translate([((tangGap/2)+pillar+(flange/2)),0,-0.1]) cylinder(r=4/2, h=3);
  }
}

module motorBox() {
  difference(){
    union() {
      cube([50,35,2]); // bottom gear diameter is just under 33
            
      translate([-1,-1,0]) cube([2,37,19]); // dead side
      translate ([49,-1,0]) cube([2,48,19]); // motor side
      translate ([-1,-2,0]) cube([52,2,19]); // bottom side
      translate ([-1,34,0]) cube([52,2,19]); // top
      // gear bumpers
      translate ([35,12,0]) cube([15,10,14]); // bottom bumper
      // corner supports
      translate([3,2,0]) cylinder(r=4,h=19);
      translate([3,32,0]) cylinder(r=4,h=19);
      translate([47,32,0]) cylinder(r=4,h=19);
      translate([47,2,0]) cylinder(r=4,h=19);
      // mounting plate
      translate([51,45,0]) cube([12,2,33]);
      // gusset
      translate([50,33,0]) linear_extrude(2) polygon([[0,0],[0,13],[13,13]]); 
    }
    // motor shaft hole
    translate([19.5,(33/2),-0.1]) cylinder(r=7/2,h=2.2);
    // holes to mount to motor
    translate([10,(33/2)-9,-0.1]) cylinder(r=3.5/2,h=2.2);
    translate([10,(33/2)+9,-0.1]) cylinder(r=3.5/2,h=2.2);
    translate([10+33,(33/2)-9,-0.1]) cylinder(r=3.5/2,h=2.2);
    translate([10+33,(33/2)+9,-0.1]) cylinder(r=3.5/2,h=2.2);
    // slot for the liner gear rack.  Back is 26 mm from center of the shaft.
    translate ([(19.5 + 25.5 -2.5),-2.2,4]) cube([2.5,40,13]);
    // slot for the gear
    translate ([(19.5 + 25.5 -12.5),-2.2,6]) cube([11,40,8.5]);
    // corner screws
    translate([3,2,10]) cylinder(r=1.4,h=19);
    translate([3,32,10]) cylinder(r=1.4,h=19);
    translate([47,32,10]) cylinder(r=1.4,h=19);
    translate([47,2,10]) cylinder(r=1.4,h=19);
    // hanger mount
    translate([57,44,7]) rotate([-90,0,0]) cylinder(r=3.5/2, h=4);
    translate([57,44,27]) rotate([-90,0,0]) cylinder(r=3.5/2, h=4);
    // text on x0 side  
    translate([2,-1.6,12]) rotate([90,0,0]) linear_extrude(height=0.6) {text("JML 5/14/2022", size=(3), halign = "left", valign = "center", $fn = 16);}
    translate([2,-1.6,6]) rotate([90,0,0]) linear_extrude(height=0.6) {text("gh_window.scad", size=(3), halign = "left", valign = "center", $fn = 16);}

    }
}
module motorBox2() {
  difference(){
    union() {
      cube([50,35,2]); // bottom gear diameter is just under 33
            
      translate([-1,-1,0]) cube([2,37,19]); // dead side
      translate ([49,-1,0]) cube([2,37,19]); // motor side
      translate ([-1,-2,0]) cube([52,2,19]); // bottom side
      translate ([-1,34,0]) cube([52,2,19]); // top
      // gear bumpers
      translate ([35,12,0]) cube([15,10,14]); // bottom bumper
      // corner supports
      translate([3,2,0]) cylinder(r=4,h=26);
      translate([3,32,0]) cylinder(r=4,h=26);
      translate([47,32,0]) cylinder(r=4,h=26);
      translate([47,2,0]) cylinder(r=4,h=26);
      //mounting point
      translate([50,27,0]) cube([10,10,26]);
      translate([60,32,0]) cylinder(r=5,h=26);
      // mounting plate
      //translate([51,45,0]) cube([12,2,33]);
      // gusset
      //translate([50,33,0]) linear_extrude(2) polygon([[0,0],[0,13],[13,13]]); 
    }
    // motor shaft hole
    translate([19.5,(33/2),-0.1]) cylinder(r=7/2,h=2.2);
    // holes to mount to motor
    translate([10,(33/2)-9,-0.1]) cylinder(r=3.5/2,h=2.2);
    translate([10,(33/2)+9,-0.1]) cylinder(r=3.5/2,h=2.2);
    translate([10+33,(33/2)-9,-0.1]) cylinder(r=3.5/2,h=2.2);
    translate([10+33,(33/2)+9,-0.1]) cylinder(r=3.5/2,h=2.2);
    // slot for the liner gear rack.  Back is 26 mm from center of the shaft.
    translate ([(19.5 + 25.5 -2.5),-2.2,4]) cube([2.5,40,13]);
    // slot for the gear
    translate ([(19.5 + 25.5 -12.5),-2.2,6]) cube([11,40,8.5]);
    // corner screws
    translate([3,2,10]) cylinder(r=1.4,h=26);
    translate([3,32,10]) cylinder(r=1.4,h=26);
    translate([47,32,10]) cylinder(r=1.4,h=26);
    translate([47,2,10]) cylinder(r=1.4,h=26);
    // hanger mount
      translate([60,32,-0.11]) cylinder(r=3.5/2,h=27);
    //translate([57,44,7]) rotate([-90,0,0]) cylinder(r=3.5/2, h=4);
    //translate([57,44,27]) rotate([-90,0,0]) cylinder(r=3.5/2, h=4);
    //trim for top
      translate([-1.1,-1.1,19]) cube([2.2,37.2,19]); // dead side
      translate ([48.9,-1,19]) cube([2.2,48.2,19]); // motor side
      translate ([-0.9,-2,19]) cube([52.2,2.2,19]); // bottom side
      translate ([-1.1,33.9,19]) cube([52.3,2.2,19]); // top
    // text on x0 side
    translate([2,-1.6,12]) rotate([90,0,0]) linear_extrude(height=0.6) {text("JML 6/2/2022", size=(3), halign = "left", valign = "center", $fn = 16);}
    translate([2,-1.6,6]) rotate([90,0,0]) linear_extrude(height=0.6) {text("gh_window.scad", size=(3), halign = "left", valign = "center", $fn = 16);}

    }
}
module motorBoxCover() {
  difference(){
    union() {
      translate([-1,-2,0]) cube([52,38,2]); // bottom gear diameter is just under 33
    }
    // corner screws
    translate([3,2,-1]) cylinder(r=3.5/2,h=4);
    translate([3,32,-1]) cylinder(r=3.5/2,h=4);
    translate([47,32,-1]) cylinder(r=3.5/2,h=4);
    translate([47,2,-1]) cylinder(r=3.5/2,h=4);
    }
}
module motorBoxCoverWswitches() {
  difference(){
    union() {
      translate([-1,-2,0]) cube([52,38,2]); // bottom gear diameter is just under 33
      // 7mm high walls to account for switches
      translate([-1,-2,0]) cube([52,2,9]);
      translate([-1,-2,0]) cube([2,38,9]);
      translate([-1,34,0]) cube([52,2,9]);
      translate([49,-2,0]) cube([2,38,9]);
      // corner supports
      //translate([3,2,0]) cylinder(r=4,h=9);
      //translate([3,32,0]) cylinder(r=4,h=9);
      //translate([47,32,0]) cylinder(r=4,h=9);
      //translate([47,2,0]) cylinder(r=4,h=9);
      // insultator
      translate([18.5,16,0]) cube([20,1,9]);
    }
    // corner screws
    translate([3,2,-1]) cylinder(r=3.5/2,h=14);
    translate([3,32,-1]) cylinder(r=3.5/2,h=14);
    translate([47,32,-1]) cylinder(r=3.5/2,h=14);
    translate([47,2,-1]) cylinder(r=3.5/2,h=14);
    // switch mount holes
    translate([33,10,-1]) cylinder(r=2.5/2,h=4);
    translate([23.5,10,-1]) cylinder(r=2.5/2,h=4);
    translate([33,24,-1]) cylinder(r=2.5/2,h=4);
    translate([23.5,24,-1]) cylinder(r=2.5/2,h=4);
    // switch travel notch
    translate([35,-2.1,2]) cube([7,40,9]);
    // wire exit
    translate([46,16,2]) cube([6,2,9]);
    
    }
}

//motorBox();
//motorBox2();
//translate ([-20,-20,0]) rackSlide();
//translate([20,40,0])
//rackMount();
//translate([0,-40,0])
//motorBoxCover();
//translate([0,-40,0]) motorBoxCoverWswitches();
//boxMount();
//translate ([-20,0,0])driveGear();
rackSlide2();
//endCap();
//driveGear2();
