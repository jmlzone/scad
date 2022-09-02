/* box / bracket for Pi + 2.5inch SSD + hub.
 HDD is 70x100 mm with 2.5mm screws 74-80mm apart use 3mmx5mm slots
 Pi has holes that are 55 mm apart use 2.5mm holes and tap for 3mm.
 hub will cable tie to the side and is 45 mm wide.
 it will mount to the underside with gull wing tabs
 generally 2mm thick.
*/
$fa=1;
$fs=0.4;

module roundSlotXZ(r,l,w){
  points = [[r,0,r], [(l-(2*r)),0,r] ];
    hull() {
        for(p=points) {
	  translate(p) rotate([270,0,0]) cylinder(r=r,h=w);
            }
        }
    }

module piMount() {
  difference() {
    union() {
      // outer box
      translate([0,10,0]) cube([100,74,50]);
      cube([20,94,2]);
      translate([80,0,0]) cube([20,94,2]);
    }
    // hollow out main part
      translate([-0.1,12,2]) cube([100.2,70,46]);
      // holes on the 4 tabs
      translate([10,5,-0.10]) cylinder(r=2,h=2.2);
      translate([90,5,-0.10]) cylinder(r=2,h=2.2);
      translate([10,89,-0.10]) cylinder(r=2,h=2.2);
      translate([90,89,-0.10]) cylinder(r=2,h=2.2);
      // slots for the 4 ssd screws
      translate([10,9.9,5]) roundSlotXZ(1.75,5,2.2);
      translate([85,9.9,5]) roundSlotXZ(1.75,5,2.2);
      translate([10,81.9,5]) roundSlotXZ(1.75,5,2.2);
      translate([85,81.9,5]) roundSlotXZ(1.75,5,2.2);
    // holes for the pi mount
    translate([27,47,47.9]) cylinder(h=2.2,r=1.3);
    translate([82,47,47.9]) cylinder(h=2.2,r=1.3);
    // hollow out the base and top
    translate([20,17,-0.1]) cube([20,20,52.2]);
    translate([20,57,-0.1]) cube([20,20,52.2]);
    translate([60,17,-0.1]) cube([20,20,52.2]);
    translate([60,57,-0.1]) cube([20,20,52.2]);
    // thin sides
      translate([20,9.9,12]) cube([20,74.2,33]);
      translate([60,9.9,12]) cube([20,74.2,33]);
      // slot for power and hdmi
     translate([42+14,9.9,30]) cube([40,2.2,10]);
     // slots for cable ties for usb hub
     translate([12,81.9,48]) cube([6,2.2,1.5]);
     translate([82,81.9,48]) cube([6,2.2,1.5]);
     translate([12,81.9,10]) cube([6,2.2,1.5]);
     translate([82,81.9,10]) cube([6,2.2,1.5]);

   
  }
}
piMount();
