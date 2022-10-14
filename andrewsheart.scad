$fn=100;
hr=2.5;
ledSPace=16.666;
magr = 6.4/2;
module heartFront() {
  difference () {
    cylinder(r=55,h=3);
    translate([0,0,-0.1]) cylinder(r=hr, h=10.2);
    translate([ledSPace,0,-0.1]) cylinder(r=hr, h=10.2);
    translate([ledSPace*2,0,-0.1]) cylinder(r=hr, h=10.2);
    translate([-ledSPace,0,-0.1]) cylinder(r=hr, h=10.2);
    translate([-ledSPace*2,0,-0.1]) cylinder(r=hr, h=10.2);
    translate([0,ledSPace,-0.1]) cylinder(r=hr, h=10.2);
    translate([0,ledSPace*2,-0.1]) cylinder(r=hr, h=10.2);
    translate([0,-ledSPace,-0.1]) cylinder(r=hr, h=10.2);
    translate([0,-ledSPace*2,-0.1]) cylinder(r=hr, h=10.2);
    translate([0,0,3]) cube([10,90,4],center=true);
    translate([0,0,3]) cube([90,10,4],center=true);
    translate([ledSPace*2,ledSPace*2,1]) cylinder(r=magr, h=3);
    translate([-ledSPace*2,ledSPace*2,1]) cylinder(r=magr, h=3);
    translate([-ledSPace*2,-ledSPace*2,1]) cylinder(r=magr, h=3);
    translate([ledSPace*2,-ledSPace*2,1]) cylinder(r=magr, h=3);
    
  }
}

module heartBack() {
  difference () {
    cylinder(r=55,h=2);
    translate([ledSPace*2,ledSPace*2,0.4]) cylinder(r=magr, h=3);
    translate([-ledSPace*2,ledSPace*2,0.4]) cylinder(r=magr, h=3);
    translate([-ledSPace*2,-ledSPace*2,0.4]) cylinder(r=magr, h=3);
    translate([ledSPace*2,-ledSPace*2,0.4]) cylinder(r=magr, h=3);
    //translate([45,0,-0.1]) cylinder(r=2,h=2.2);
    translate([45,0,0.75]) cube([4,9,4],center=true);;
    translate([0,0,3]) cube([10,90,4],center=true);
    translate([0,0,3]) cube([90,10,4],center=true);
  }
}




//heartFront();
heartBack();
