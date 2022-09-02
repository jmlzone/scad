module camHeadMount() {
  difference() {
    union(){
      translate([0,-6,0]) cube([10,12,35]);
      translate([0,-20,0]) cube([10,40,15]);
      translate([0,-4.5,0]) cube([44,9,10]);
      translate([37.42,-4.5,0]) cube([9,9,30]);
      //translate([37.42,-4.5,0]) cube([14,9,30]);
      //translate([48,6,10]) rotate([90,0,0]) cylinder(r=(7/2),h=2,$fn=100);
      translate([57,5,16]) rotate([90,0,0]) cylinder(r=(7/2),h=2,$fn=100);
      translate([46.42,0,16]) rotate([0,45,0]) cube([22,8,22],center=true);
      //translate([48,6,41]) rotate([90,0,0]) cylinder(r=(7/2),h=2,$fn=100);
      translate([-12,-1,0]) rotate([0,0,60]) lightwing();
      translate([25,-63.5,0]) rotate([0,0,120]) lightwing();
      translate([-10,-3,0]) cube([16,6,6]); //back tail
      //translate([-8,-3,0]) cube([6,6,12]); // back horizontal wire guide
      translate([-10,-3,0]) cube([6,6,25]); //back vertical wire guide
    }
    //camera body mount
    translate([42.42,0,-0.1]) cylinder(r=(7.5/2),h=45.2,$fn=100);
    // slot for tension
    translate([45,-2,-0.1]) cube([20,4,45.2]);
    // bolt holes for bracket
    translate([-0.1,0,20]) rotate([0,90,0]) cylinder(r=(3.5/2),h=50,$fn=100);
    translate([-0.1,0,20]) rotate([0,90,0]) cylinder(r=(6.3/2),h=2,$fn=6);
    translate([-0.1,0,30]) rotate([0,90,0]) cylinder(r=(3.5/2),h=50,$fn=100);
    translate([-0.1,0,30]) rotate([0,90,0]) cylinder(r=(6.3/2),h=2,$fn=6);
    // mount tensioning holes
    translate([57,5.1,16]) rotate([90,0,0]) cylinder(r=(3.5/2),h=10.2,$fn=100);
    translate([57,5.5,16]) rotate([90,0,0]) cylinder(r=(6.3/2),h=2.2,$fn=6);
    //translate([48,5.1,26]) rotate([90,0,0]) cylinder(r=(3.5/2),h=10.2,$fn=100);
    //translate([48,6.1,26]) rotate([90,0,0]) cylinder(r=(6.3/2),h=2.2,$fn=6);
    //translate([48,5.1,41]) rotate([90,0,0]) cylinder(r=(3.5/2),h=10.2,$fn=100);
    //translate([48,6.1,41]) rotate([90,0,0]) cylinder(r=(6.3/2),h=2.2,$fn=6);
    //back horizontal wire guide.
    translate([-8.1,0,9]) rotate([0,90,0]) cylinder(r=2,h=7,$fn=100);
    translate([-8.1,-0.5,10]) cube([8,1,6]);
    //back verticle wire guide
    translate([-7,0,6]) cylinder(r=2,h=20,$fn=100);
    translate([-7,-0.5,7]) cube([4,1,20]);
    
    translate([0,-27.25,4.5]) cube([20,6,3]); // back wiring on left wing
    translate([0,23.25,0.8]) cube([20,6,3.5]); // back wiring on right wing
    // clip wings at 40 mm
    translate([0,-50,-0.1]) cube([20,10,10]);
    translate([0,40,-0.1]) cube([20,10,10]);
    // clip tensioner supports
    translate([61,-10,0]) cube([20,20,20]);
    translate([27.4,-5,10]) cube([10,10,20]);
    translate([45,-5,30]) cube([10,10,10]);
  }
}
module lightwing(){
  //linear_extrude(height=20) {polygon([[0,0],[10,0],[10,8],[8,8]]);}
  translate([25,0,0]) rotate([0,0,0]) translate([0,-2,0]) difference() {
    union(){
      cube([25,2,2]);
      translate([0,-7,7]) cube([25,10,2]);
      rotate([45,0,0]) 
	difference() {
	cube([25,10,10]);
	translate([2.5,10.1,8]) rotate([90,0,0]) cylinder(r=1,h=11,$fn=100);
	translate([7.5,10.1,8]) rotate([90,0,0]) cylinder(r=1,h=11,$fn=100);
	translate([17.5,10.1,2]) rotate([90,0,0]) cylinder(r=1,h=11,$fn=100);
	translate([22.5,10.1,2]) rotate([90,0,0]) cylinder(r=1,h=11,$fn=100);
      } 
    }
    translate([-0.1,2,-0.1]) cube([25.2,10,10]); 
    translate([-0.1,-8,8]) cube([25.2,14,10]); 
  }
}

camHeadMount();
//lightwing();
