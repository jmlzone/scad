$fn=100;
// rounded box centered at x=0, y=0,  rising from z=0
module rb (bw, bl, bh, br) {
    hull() {
      translate([-((bw/2)-br), -((bl/2)-br),0]) cylinder(r=br,h=bh);
      translate([((bw/2)-br), -((bl/2)-br),0]) cylinder(r=br,h=bh);
      translate([((bw/2)-br), ((bl/2)-br),0]) cylinder(r=br,h=bh);
      translate([-((bw/2)-br), ((bl/2)-br),0]) cylinder(r=br,h=bh);
    }
}
module worxBatMount(bw=50, bl=50, bh=8, br=2) {
  wallInner = 42;
  wallOuter = 50;
  wallThick = (wallOuter-wallInner)/2;
  flangeOuter = 55;
  flangeRise = 12.5;
  flangeThick = 5.5;
  flangeWidth = (flangeOuter - wallOuter)/2;
  difference() {
    union() {
      // basic base
      rb(bw, bl, bh, br);
      // walls
      translate([-((wallInner/2)+wallThick/2),0,0]) rb(wallThick,bl,(bh+flangeRise),br);
      translate([(wallInner/2)+wallThick/2,0,0]) rb(wallThick,bl,(bh+flangeRise),br);
      // flanges
      translate([-(((wallInner/2)+((flangeWidth+wallThick))/2)),0,(bh+flangeRise-flangeThick)]) rb(flangeWidth+wallThick,bl,flangeThick,br);
      translate([(((wallInner/2)+((flangeWidth+wallThick))/2)),0,(bh+flangeRise-flangeThick)]) rb(flangeWidth+wallThick,bl,flangeThick,br);
      //bump stop
      translate([0,(-(bl/2)+2.5),0]) rb(bw,3,bh+(flangeRise/2),br);
    }
    // slot for tab
    // 4mm x 4mm 21mm from flange outer
    translate([(flangeOuter/2)-22,-((bl/2+0.1)),bh-3.4]) cube([6,bl+0.2,3.5]);
    // screw holed and counter bores
    translate([0,-15,-0.1]) cylinder(r=2.2,h=bh+0.2);
    translate([0,-15,(bh-3)]) cylinder(r=5,h=bh);
    translate([0,15,-0.1]) cylinder(r=2.2,h=bh+0.2);
    translate([0,15,(bh-3)]) cylinder(r=5,h=bh);
  }
}

worxBatMount();
