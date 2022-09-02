include <jstph2.scad>
module microphone (c=0.5) {
  union () {
    hull() {
      translate ([0,0,c]) torus(r1=c, r2=3);
      translate ([0,0,(2.7-c)]) torus(r1=c, r2=3);
    }
    translate ([1,1,-2.8]) cylinder(r=0.5, h=10, $fn=100);
    translate ([1,-1,-2.8]) cylinder(r=0.5, h=10, $fn=100);
  }
}
module torus(r1=0.25, r2=10, facets=100) {
  rotate_extrude(convexity = 10, $fn=facets)
    translate([r2-r1,0,0])
    circle(r=r1, $fn=facets);
}

module dummy() {
  cylinder(r=4, h=4, $fn=100);
}
//microphone();

module arc(r1, r2, a1, a2) {
  difference() {
    difference() {
      polygon([[0,0], [cos(a1) * (r1 + 50), sin(a1) * (r1 + 50)], [cos(a2) * (r1 + 50), sin(a2) * (r1 + 50)]]);
      circle(r = r2);
    }
    difference() {
      circle(r=r1 + 100);
      circle(r=r1);
    }
  }
}

//rotate([0,0,120])
module radialSpring( pc = 100) {
  union (){ translate ([0,0,0.5]) linear_extrude(height = 3) {
      arc(5,4.5, 0, pc, $fn=100);
    }
    translate ([0,0,0.5]) cube([4.5,1,3]);
    rotate([0,0,pc]) translate ([4.5,-0.5,0.5]) cube([2.5,1,3]);
  }
}
module threeSprings() {
  radialSpring();
  rotate([0,0,120]) radialSpring();
  rotate([0,0,240]) radialSpring();
}

module micnjst(){
  difference() {
    union() {
      dummy();
      threeSprings();
      rotate([180,0,90]) translate([0,0.45,0.1]) jstph(npins=2);
      // add some support for the jst connector
      translate([2.5,-5,-2.1]) cube([4,10,2]);
      translate([-6.7,-5,-2.1]) cube([5,10,2]);
      translate([-5,3,-2.1]) cube([10,4,2]);
      translate([-5,-7,-2.1]) cube([10,4,2]);
    }
    translate([0,0,0.5]) microphone();
    translate([0,0,3]) cylinder(r=5.5/2, h=2, $fn=100);
    translate([0,0,0]) cylinder(r=5.5/2, h=2, $fn=100);
    rotate([0,0,60]) translate([0,-0.25,-0.1]) cube([4.5,0.5,4.2]);
    rotate([0,0,180]) translate([0,-0.25,-0.1]) cube([4.5,0.5,4.2]);
    rotate([0,0,300]) translate([0,-0.25,-0.1]) cube([4.5,0.5,4.2]);
  }
}
module micBlock() {
  union() {
    difference(){
      cube([14,14,10], center=true);
      translate ([0,0,-1.1]) cylinder(r=6,h=6.2,$fn=100);
      rotate([180,0,90]) translate([0,0.45,1.1]) jstph_void();
    }
    translate([0,0,1.1]) micnjst();
  }
}

module paperGuideMicMount(t1=false,t2=false) {
  difference(){
    union(){
      difference () {
	union() {
	  translate([-5,-5,0]) cube([5,35,14]);
	  translate([-5,-5,0]) cube([35,5,14]);
	  linear_extrude(height = 1) polygon(points=[[0,0],[0,30],[30,0]]);
	}
	// hole out for mic block
	rotate([0,0,45]) translate([0,0,7]) cube([14,12,12], center=true);
	// clip the back
	rotate([0,0,45]) translate([-7,0,7]) cube([14,14,14.1], center=true);
      }
      rotate([0,90,45]) translate([-7,0,2]) micBlock();
    }
    // clean out the top notch
    translate([0,0,13]) linear_extrude(height = 1.1) polygon(points=[[0,0],[0,10],[10,0]]);
    // mounting holes for 2.5 mm screws
    translate([-2.5,27,-0.1]) cylinder(h=14.2,r=1, $fn=100);
    translate([-2.5,12,-0.1]) cylinder(h=14.2,r=1, $fn=100);
    translate([27,-2.5-0.1]) cylinder(h=14.2,r=1, $fn=100);
    translate([12,-2.5,-0.1]) cylinder(h=14.2,r=1, $fn=100);
    // paper guides 1mm deep 2mm in
    if(t1) {
      translate([-10,-5,13]) cube([10.1,35,1.1]);
    } else {
      translate([-1,-1,13]) cube([2.1,35,1.1]);
    }
    if(t2) {
      translate([-5,-10,13]) cube([35,10.1,1.1]);
    } else {
      translate([-1,-1,13]) cube([35,2.1,1.1]);
    }
    
  }
}
paperGuideMicMount(t1=false,t2=true);
//micBlock();
//micnjst();
