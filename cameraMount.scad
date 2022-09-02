module backMount() {
  difference() {
    // outer box
    cube([38,38,12]);
    //hollow out main hole
    translate([6.5,6.5,-0.1]) cube([25,25,12.2]);
    //notch for cable bottom
    translate([13,-0.1,-0.1]) cube([12,8.2,18.2]);
     //notch for cable top
    translate([13,29.9,-0.1]) cube([12,8.2,18.2]);
    //mounting holes 28mm square
    translate([(19-14),(19-14),6]) cylinder(h=6.1,r=1);
    translate([(19-14),(19+14),6]) cylinder(h=6.1,r=1);
    translate([(19+14),(19-14),6]) cylinder(h=6.1,r=1);
    translate([(19+14),(19+14),6]) cylinder(h=6.1,r=1);
      }
}
module lightWedge() {
    union(){
    translate([0,10,20]) rotate([0,-90,180]) 
    linear_extrude(height=20,center=true,convexity=10,twist=0)
    polygon(points=[[0,0], [10,0], [0,10]],paths=[[0,1,2]]);
        translate([-10,0,0]) cube([20,10,20]);
    }
}
module base() {
    difference() {
        cube([60,60,4]);
        // mounting holes
        translate([10,10,-0.1]) cylinder(h=4.2,r=2.75);
        translate([50,10,-0.1]) cylinder(h=4.2,r=2.75);
    }
}
module lightCamMount(){
    difference() {
    union() {
        base();
        translate([11,0,4]) backMount();
        translate([30,50,4]) lightWedge();
        translate([10,20,4]) rotate(90) lightWedge();
        translate([50,20,4]) rotate(-90) lightWedge();
        translate([15,40,4]) rotate(45) lightWedge();
        translate([45,40,4]) rotate(-45) lightWedge();
    }
    // clearance for screws
        translate([10,10,4]) cylinder(h=16,r=5.5);
        translate([50,10,4]) cylinder(h=16,r=5.5);
    // hole for cable exit
    translate([25,19,-0.1]) cube([10.1,5.1,4.2]);
}
    
}
//backMount();
//lightWedge();
//base();
lightCamMount();
