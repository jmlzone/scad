// board is 43.5 x 18
// pins bottom to top 19mm
bw=18.5;  // board width
bl=44.0;  // board length
oah = 20; // overall height
wt = 1.6; // wall thickness

module pinSilo(pd) {
  difference(){
    cube([2.6,2.6,pd],center=true);
    cube([1,1,pd+0.2],center=true);
  }
}
module dipHoles(numpins=30,wid=15.24,pd=6) {
  hp = numpins/2;
  hw = wid/2;
  xoff = -(hp * 2.54) / 2;
  yoff = hw;
  for(i=[0:hp]) {
    translate([xoff+(i*2.54),-yoff,0]) pinSilo(pd);
    translate([xoff+(i*2.54),yoff,0]) pinSilo(pd);
  }
}
module eqTriPsm(pw,l) {
  hpw=pw/2;
  rotate([0,0,90]) translate ([0,(l/2),0]) rotate([90,0,0]) linear_extrude(l) polygon(points=[[-hpw,0],[hpw,0],[0,pw],[-hpw,0]]);
}
module miniUsbHole(l) {
    // trapazoid bottom 7, hieght 4 top 8
  tbh = 7.5/2;
  tth = 8.5/2;
  th = 4.5;
  rotate([0,0,90]) translate ([0,0,0]) rotate([90,0,0]) linear_extrude(l) polygon(points=[[-tbh,0],[tbh,0],[tth,th],[-tth,th],[-tbh,0]]);
}

module nanoBoxBottom(){
  union() {
    difference(){
      cube([bl+(2*wt),bw+(2*wt),oah+(2*wt)], center=true); // outisde box
      cube([bl,bw,oah+0.01], center=true); // inside clearnace
      translate([wt-0.1,0,oah/2]) eqTriPsm(bw+wt,bl+wt+wt+0.2); //dove tail top
      translate([(bl/2)-0.1,(1/2)]) miniUsbHole(3);// usb connector
    }
    //translate([0,0,(-oah/2)+3]) dipHoles(30,15.24,6);
  }
}
module nanoBoxTop() {
  difference() {
    eqTriPsm(wt+bw-0.1,bl+wt); // main shape
    translate([0,0,wt+(oah/2)]) cube([2*wt+bl+0.1,bw,oah], center=true); // clip top
    translate([(-bl/2)+2.54,-4.5,-0.1]) cube([4,9,2]); //dupont connector hole
  }
}
//nanoBoxBottom();
nanoBoxTop();
//miniUsbHole(3);
