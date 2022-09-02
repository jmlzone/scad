/* 
  loading tray alternate 13mm and 10mm squares
*/
module loadingTray(d=12) {
 
  difference () {
    translate ([-1.5,-1.5,0]) cube([142,142,d+1]);
    union() {
      for (r = [0 : 9]) {
	for (c = [0 : 9]) {
	  even =    ((r%2) == (c%2)); 
	  if(even) {translate([c*14,r*14,1]) cube([13,13,d+0.1]);
	  } else {
	    translate([1+c*14,1+r*14,-0.1]) cube([11,11,d+0.1]);
	  }
	}
      }
    } // union
      // more diff: text
    // text on x0 side  
    translate([70,-1,(d/2) +0.5]) rotate([90,0,0]) linear_extrude(height=0.6) {text("45 ACP", size=(d*0.6), halign = "center", valign = "center", $fn = 16);}
    // X max side
    translate([70,140,(d/4) +0.5]) rotate([90,0,180]) linear_extrude(height=0.6) {text("two-sided 50 round loading tray - JML December 12, 2021", size=(d*0.3), halign = "center", valign = "center", $fn = 16);}
    // text on y0 side
    translate([-1,70,(d/2) +0.5]) rotate([-90,0,90]) linear_extrude(height=0.6) {text(".380, 9mm", size=(d*0.6), halign = "center", valign = "center", $fn = 16);}
    // Y max side
    translate([140,70,(d*0.75) +0.5]) rotate([90,180,90]) linear_extrude(height=1.6) {text("two-sided 50 round loading tray - JML December 12, 2021", size=(d*0.3), halign = "center", valign = "center", $fn = 16);}
    
    } //difference
} // module
loadingTray();

