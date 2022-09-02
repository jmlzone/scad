// Drag chain, best printed together as much as possible
// Common sizes 8x8, 10x10, 10x20
// Copyright (c) R. Linder
// This work is licensed under a Creative Commons Attribution 4.0 International License.

// Internal dimension (min 5)
link_height=10;
// Internal dimension (min 5)
link_width=15;
// Thickness of part body (Typical 1.8 min 1.4)
shell_thickness=1.8;
// Print as many as your bed can fit
number_of_links = 10;
// Add anti stick if your chain is fused solid.
anti_stick = 0.15;		// [0.0:0.01:0.35]
// Select what to print
part_selection = 999;		// [0:Chain only, 1:Male mount, 2:Female mount, 3:Chain with mounts, 4 mounts only 5 male side mount 6 femaleEndMount]

linkHeight = link_height + 2 * shell_thickness;
linkWidth = link_width + 4 * shell_thickness;

linkLength = link_height * 2.8;
//pinRad = linkHeight / 6;
pinRad = 2.9;
pinSpace = ((linkLength / 2) - (linkHeight / 2)) * 2;
//tabLen = linkHeight / 2;
tabLen = 10;
//echo("Tablen = ", tabLen) ;

$fn=140;
module mountPlate4040() {
  x=40;
  y=40;
  z=6;
  r=5;
  thr = 2.75;
  cbr = 5.2;
  cbd = 3; // the button head screws have a head thickness of 2.9 mm
    points = [[r,r,0], [(x-r),r,0], [(x-r),(y-r),0],[r,(y-r),0]];
    holes = [[10,10,0],[10,30,0],[30,10,0],[30,30,0]];
    difference() {
      hull() {
        for(p=points) {
	  translate(p) cylinder(r=r,h=z);
        }
      }
      for(p=holes) {
	translate(p) translate([0,0,-0.1]) cylinder(r=thr,h=z+0.2);
	translate(p) translate([0,0,(z-cbd)]) cylinder(r=cbr,h=cbd+0.2);
      }
    }
}

module femaleMount() {
  difference () {
    union () {
      difference () {
	translate ([linkHeight/2, 0, 0]) hull () {
	  translate ([0, pinSpace/2, 0]) cylinder (h=linkWidth+0.6, r=linkHeight/2);
	  translate ([-linkHeight/2,-pinSpace/6, 0]) cube ([linkHeight, 1, linkWidth+0.6]);
	  translate ([0,-pinSpace*1.5, 0]) cube ([linkHeight/2, 5, linkWidth+0.6]);
	}
	femaleEnd (mount=1);
      }
    }
    translate ([-shell_thickness,-pinSpace*1.5-0.6, shell_thickness*2]) cube (size=[linkHeight, pinSpace*2.5, linkWidth- (shell_thickness*4)+0.6]);
    // M3 Holes
    if (link_width >= 10) {
      for (off = [0:2]) {
	rotate ([0, 90, 0]) translate ([-linkWidth/2-off- (link_width) /6+0.6,-linkLength/2.5- (linkLength/6), link_height+0.6]) cylinder (h=shell_thickness*2, r=1.6);
	rotate ([0, 90, 0]) translate ([-linkWidth/2+off+ (link_width) /6-1.2,-linkLength/2.5+ (linkLength/6), link_height+0.6]) cylinder (h=shell_thickness*2, r=1.6);
      }
    } else {
      rotate ([0, 90, 0]) translate ([-linkWidth/2-0.3,-linkLength/2.5, link_height+0.6]) cylinder (h=shell_thickness*2, r=1.6);
    }
  }
}
module femaleEndMount() {
  difference() {
    hull() {
      cube([23.4,16,12]); // outside dimensions
      translate([0,(16/2),12]) rotate([0,90,0]) cylinder(r=8,h=23.4);
    }
    translate([2,-0.1,2]) cube([19.4,16.2,18.1]); // carve out main center
    translate([-0.1,(16/2),12]) rotate([0,90,0]) cylinder(r=2.8,h=23.6) ; // pin holes
    translate([(23.4/2),(16/2),-0.1]) cylinder(h=2.2,r=2.75); // mounting screw hole
  }			       
}
module femaleEndMount2() {
  extraHeight = 15;
  extraThick = 1;
  difference() {
    hull() {
      cube([23.4+(2*extraThick),16,12+extraHeight]); // outside dimensions
      translate([0,(16/2),12+extraHeight]) rotate([0,90,0]) cylinder(r=8,h=23.4+(2*extraThick));
    }
    translate([2+extraThick,-0.1,2+extraThick]) cube([19.4,16.2,18.1+extraHeight+extraThick]); // carve out main center
    translate([-0.1,(16/2),12+extraHeight+extraThick]) rotate([0,90,0]) cylinder(r=2.8,h=23.6+(2*extraThick)) ; // pin holes
    translate([(23.4/2),(16/2),-0.1]) cylinder(h=2.2+extraThick,r=2.75); // mounting screw hole
  }			       
}

module maleMount ()
{
	difference ()
	{
		union ()
		{
			difference ()
			{
				union ()
				{
					translate ([linkHeight/2, 0, 0]) hull ()
					{
						translate ([0, pinSpace, 0]) cube ([linkHeight/2, 5, linkWidth+0.6]);
						translate ([0, -pinSpace/2, 0]) cylinder (h=linkWidth+0.6, r=linkHeight/2);
						translate ([-linkHeight/2,-pinSpace/6, 0]) cube ([linkHeight, 1, linkWidth+0.6]);
					}
					translate ([0,- (linkLength+tabLen) /2, shell_thickness+0.3]) cube (size=[(linkHeight+shell_thickness) /2, tabLen*2, linkWidth-shell_thickness*2+0.2]);
				}
				maleEnd ();
			}
			// Locking pins (0.2mm narrower)
			translate ([linkHeight/2, (-pinSpace/2)-1.5, 0.4]) cylinder (h=linkWidth-0.2, r=pinRad-0.25);


		}
		// Top Champher on stopper
		translate ([linkHeight/2+1,-linkLength/2-sqrt (tabLen*tabLen*2), 0]) rotate ([0, 0, 45]) cube ([tabLen, tabLen, linkWidth]);
		// Front Champher on stopper
		translate ([linkHeight/2-0.6,-linkLength/2-tabLen+0.6, 0]) rotate ([0, 0, 70]) cube (size=[2.5, 5, linkWidth+5]);
		// Hole for wires
		translate ([0-shell_thickness,-pinSpace*1.5, shell_thickness*2]) cube (size=[linkHeight, pinSpace*3.5, linkWidth- (shell_thickness*4)+0.6]);

		if (link_width >= 10)
		{
			for (off = [0:2])
			{
				rotate ([0, 90, 0]) translate ([-linkWidth/2-off- (link_width) /6+0.6, linkLength/3+ (linkLength/6), link_height+0.6]) cylinder (h=shell_thickness*2, r=1.6);

				rotate ([0, 90, 0]) translate ([-linkWidth/2+off+ (link_width) /6-1.2, linkLength/3- (linkLength/6), link_height+0.6]) cylinder (h=shell_thickness*2, r=1.6);
			}
		}
		else
		{
			rotate ([0, 90, 0]) translate ([-linkWidth/2-0.3, linkLength/2, link_height+0.6]) cylinder (h=shell_thickness*2, r=1.6);
		}
	}
}
standoffDistance = 20;
module maleSideMount(left=true){
  difference(){
    union(){
      difference(){
	union(){
	  translate ([linkHeight/2, 0, 0]) hull() {
	    translate ([0, pinSpace, 0]) cube ([linkHeight/2, 5, linkWidth+0.6]);
	    translate ([0, -pinSpace/2, 0]) cylinder (h=linkWidth+0.6, r=linkHeight/2);
	    translate ([-linkHeight/2,-pinSpace/6, 0]) cube ([linkHeight, 1, linkWidth+0.6]);
	  }
	  translate ([0,- (linkLength+tabLen) /2, shell_thickness+0.3]) cube (size=[(linkHeight+shell_thickness) /2, tabLen*2, linkWidth-shell_thickness*2+0.2]);
	}
	maleEnd ();
      }
      // Locking pins (0.2mm narrower)
      translate ([linkHeight/2, (-pinSpace/2)-1.5, 0.4]) cylinder (h=linkWidth-0.2, r=pinRad-0.25);
      if(left) {
	// bottom stand off plate
	translate([linkHeight,-tabLen, -standoffDistance]) cube([3,linkLength/*+tabLen*/,(linkWidth+standoffDistance)]);
	translate([(linkHeight-20),-tabLen-((40-linkLength)/2),(-standoffDistance)]) rotate([0,0,0]) mountPlate4040();
	// extra support
	translate([(linkHeight),20-tabLen-((40-linkLength)/2)-2.5,-standoffDistance]) cube([15,5,(linkWidth+standoffDistance)]);
      } else {
	// bottom stand off plate
	translate([linkHeight,-tabLen, 0]) cube([3,linkLength/*+tabLen*/,(linkWidth+standoffDistance)]);
	translate([(linkHeight-20),40-tabLen-((40-linkLength)/2),(linkWidth+standoffDistance)]) rotate([180,0,0]) mountPlate4040();
	// extra support
	translate([(linkHeight),20-tabLen-((40-linkLength)/2)-2.5,0]) cube([15,5,(linkWidth+standoffDistance)]);
      }
    } // union
    // Top Champher on stopper
    translate ([linkHeight/2+1,-linkLength/2-sqrt (tabLen*tabLen*2), 0]) rotate ([0, 0, 45]) cube ([tabLen, tabLen, linkWidth]);
    // Front Champher on stopper
    translate ([linkHeight/2-0.6,-linkLength/2-tabLen+0.6, 0]) rotate ([0, 0, 70]) cube (size=[2.5, 5, linkWidth+5]);
    // Hole for wires
    translate ([0-shell_thickness,-pinSpace*1.5, shell_thickness*2]) cube (size=[linkHeight, pinSpace*3.5, linkWidth- (shell_thickness*4)+0.6]);
    // 3mm notches for link clearence
    if(left) {
      translate([linkHeight-0.1,-(linkLength+1.1),-shell_thickness/2]) cube([3.2,linkLength,3]);
      translate([linkHeight-0.1,-(linkLength+1.1),linkWidth-shell_thickness]) cube([3.2,linkLength,3]);
    }
    }
}



module link ()
{
	difference ()
	{
		union ()
		{
			difference ()
			{
				union ()
				{
					translate ([linkHeight/2, 0, 0]) hull ()
					{
						translate ([0, pinSpace/2, 0]) cylinder (h=linkWidth+0.6, r=linkHeight/2);
						translate ([0,-pinSpace/2, 0]) cylinder (h=linkWidth+0.6, r=linkHeight/2);
					}
					translate ([0,- (linkLength+tabLen) /2, shell_thickness+anti_stick/2]) cube (size=[(linkHeight+shell_thickness) /2, tabLen*2, linkWidth-shell_thickness*2+0.2]);
				}

				maleEnd ();
				femaleEnd ();
			}

			// Locking pins (0.2mm narrower)
			translate ([linkHeight/2, (-pinSpace/2)-1.5, 0.4]) cylinder (h=linkWidth-0.2, r=pinRad-0.25);
		}
		// Top Champher on stopper
		translate ([linkHeight/2+1,-linkLength/2-sqrt (tabLen*tabLen*2), 0]) rotate ([0, 0, 45]) cube ([tabLen, tabLen, linkWidth]);

		// Front Champher on stopper
		translate ([linkHeight/2-0.6,-linkLength/2-tabLen+0.6, 0]) rotate ([0, 0, 70]) cube (size=[2.5, 5, linkWidth+5]);

		// Hole for cables
		translate ([0+shell_thickness+0.2,-linkLength/2-tabLen, shell_thickness*2]) cube (size=[linkHeight-shell_thickness*2, linkLength+tabLen+1, linkWidth- (shell_thickness*4)+0.6]);

		// trim top brace
		translate ([0,-pinSpace-pinRad*2, shell_thickness*2]) cube (size=[linkHeight+3, linkLength/2, linkWidth- (shell_thickness*4)+0.6]);
	}
}

// The Male end with cutouts

module maleEnd () {
  //Cutouts for opposite side
  translate ([-0.6,-linkLength/2, (linkWidth+0.4)-shell_thickness])  cube (size=[linkHeight+1, pinRad*6-shell_thickness, shell_thickness+0.7]);
  translate ([-0.6,-linkLength/2, -0.6]) cube (size=[linkHeight+1, pinRad*6-shell_thickness, shell_thickness+0.8]);
  // Cut out on rounds to fit on base
  translate ([-0.6, (- (linkLength+tabLen) /1.5)-0.6, 0]) cube (size=[shell_thickness+1.2+anti_stick, pinRad*2.5+tabLen+0.6, linkWidth+0.6]);
}

module femaleEnd (mount=0){
  translate ([linkHeight/2, (pinSpace/2)+1.5,-1]) cylinder (h=linkWidth+3, r=pinRad);
  // Bottom brace
  translate ([-0.6, pinRad*2.5, shell_thickness-anti_stick]) cube (size=[linkHeight+2, pinRad*3+1.2, linkWidth- (shell_thickness*2)+0.6+ (2*anti_stick)]);
  // Top brace
  translate ([linkHeight-shell_thickness-0.6, pinRad*2, shell_thickness-anti_stick]) cube (size=[shell_thickness*2, pinRad*4, linkWidth- (shell_thickness*2)+0.6+anti_stick*2]);
  if (mount){
    translate ([0, 0, shell_thickness]) cube (size=[linkHeight- (shell_thickness), (linkLength/2), linkWidth- (shell_thickness*2)+0.6]);
  } else  {
    translate ([shell_thickness+0.2, -0.6, shell_thickness-anti_stick]) cube (size=[linkHeight- (shell_thickness*2), (linkLength/2)+0.6, linkWidth- (shell_thickness*2)+0.6+ (2*anti_stick)]);
  }
}


rotate ([0, 90, 0]) {
  if (part_selection == 1) {
    maleMount ();
  } else if (part_selection == 2) {
    femaleMount ();
  } else if (part_selection <= 3) {
    if (part_selection == 3) {
      femaleMount ();
      translate ([0, (number_of_links+1) *(pinSpace+3), 0]) maleMount ();
    }
    for (cnt = [0:number_of_links-1]) {
      translate ([0, (cnt+1) *(pinSpace+3), 0]) link ();
    }
  } else if (part_selection == 4) {
      femaleMount ();
      translate ([0, (2) *(pinSpace+3), 0]) maleMount ();
  } else if (part_selection == 5) {
      maleSideMount ();
  } else if (part_selection == 6) {
      femaleEndMount ();
  } else {
    echo ("Invalid Part Selection");
  }
}
femaleEndMount2();
// maleSideMount ();
