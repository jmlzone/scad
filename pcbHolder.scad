//Overall length goal, will be rounded up for even triangles
//length=120; // long
length=20; // short
//A side (narrow side) width
aWidth = 4;
//b side (wide side) width
bWidth = 20;
//pylon width (the edge stop)
pylonWidth = 5;
//pylon heigth (the edge stop)
pylonHeight = 2.5;
//Height of board bottom side above bed
pcbHeight=22.8;
//lip on the b side before the cut out supports
lip=4;
//outrigger
outrigger = 10;
//strigger between triangles
stringer = 3;
//diameter of pockets on the side to put a magnet in
magnetDiameter=6;
//height of the pocket for the magnet
magnetHeight=3;
//bottom height thinkness of the full bottom
bottomHeight = 5;

// extra cutoffs to help scad render witch clean cutouts
extra = 0.1;
sqrt3_2 = 0.866;
//calculated/derived values
overallWidth = aWidth + bWidth + pylonWidth;
overallHeight = pcbHeight+pylonHeight;
itriangleHeight = bWidth - lip - stringer;
itriangleS = itriangleHeight/sqrt3_2;
itriangleS2 = itriangleS/2;
otriangleHeight = (bWidth - lip) + stringer + extra;
otriangleS = otriangleHeight/sqrt3_2;
otriangleS2 = otriangleS/2;
triangleSets = ceil((length-stringer)/(itriangleS+stringer));
// adjust length
finalLength = (triangleSets==1) ? (itriangleS+stringer)*triangleSets+stringer
  : (itriangleS+(2*stringer))*triangleSets;

module pcbHolder() {
  difference() {
    union() {
      difference() { // remove triangles
	cube([overallWidth,finalLength,overallHeight]);
	translate([(aWidth+pylonWidth+lip),0,-extra]) triangleSets(triangleSets);
      }
      // add outrigger
      translate([overallWidth-outrigger,0,0]) cube([outrigger,finalLength,bottomHeight]);
    }
      // now carve out everythinge else
      //magnet pockets
    if(finalLength >50) {
      //magnet pockets right side
      for(j=[0:1:2]) {
	translate([0,j*((finalLength-49)/2)+24.5,0]) {
	  translate([overallWidth,0,0 ]) {
	    magnetic_fixation_pocket();
	  }
	}
      }
      //magnet pockets left side
      for(j=[0:1:3]) {
	translate([0,j*((finalLength-15)/3)+7.5,0]) {
	  rotate([0,0,180])
	    magnetic_fixation_pocket();
	}
      }
    } else {
      //magnet pocket right side
      translate([overallWidth,finalLength/2,0 ]) magnetic_fixation_pocket();
      //magnet pockets left side
      translate([0,(magnetDiameter/2)+3,0]) rotate([0,0,180]) magnetic_fixation_pocket();
      translate([0,finalLength-((magnetDiameter/2)+3),0]) rotate([0,0,180]) magnetic_fixation_pocket();
    }
      
    // a side notch
    translate([-extra,-extra,pcbHeight]) cube([aWidth+extra,finalLength+(2+extra),pylonHeight+extra]);
    // b side notch
    translate([(aWidth+pylonWidth),-extra,pcbHeight]) cube([bWidth+extra,finalLength+(2*extra),pylonHeight+extra]);
    // a test triangle
    //translate([(aWidth+pylonWidth+lip), (itriangleS + stringer), -extra]) insideTriangle();
    //translate([(aWidth+pylonWidth+lip), (2*itriangleS + 2*stringer), -extra]) outsideTriangle();
    //translate([(aWidth+pylonWidth+lip), (itriangleS), -extra]) outsideTriangle();
    //chamfer pylon
    translate([aWidth,(finalLength+extra),pcbHeight]) rotate([90,0,0]) linear_extrude(height=(finalLength+(2*extra))){
      polygon([[0,0],[1,0],[1,1],[-((pylonHeight-1)+extra),pylonHeight+extra+1]]);
    }
    translate([aWidth+pylonWidth,(finalLength+extra),pcbHeight]) rotate([90,0,0]) linear_extrude(height=(finalLength+(2*extra))){
      polygon([[0,0],[-1,0],[-1,1],[((-1+pylonHeight)+extra),pylonHeight+extra+1]]);
    }
    // some holes for 2mm screws for stops
    for(h=[0:10:finalLength-2.5]) {
      translate([(aWidth/2),(1*h)+2.5,(pcbHeight-10)]) cylinder(r=1,h=(10+extra),$fn=100);
      translate([aWidth+pylonWidth+(lip/2),(1*h)+2.5,(pcbHeight-10)]) cylinder(r=1,h=(10+extra),$fn=100);
    }
  }
}

module triangleSets(nsets) {
  union() {
    for(i=[0:nsets]) {
      translate([0, (i*(itriangleS+stringer+stringer)),0]) outsideTriangle();
      translate([0, (i*(itriangleS+stringer+stringer))+stringer,0]) insideTriangle();
    }
  }
}

module insideTriangle() {
  linear_extrude(height=(pcbHeight+(2*extra))) {
    polygon([[0,0],[itriangleHeight,itriangleS2],[0,itriangleS]]);
  }
}

module outsideTriangle() {
  linear_extrude(height=(pcbHeight+(2*extra))) {
    polygon([[otriangleHeight,-otriangleS2],[0,0],[otriangleHeight,otriangleS2]]);
  }
}

module magnetic_fixation_pocket() {
    layerBelow=0.25;
    magnetInset=1;
    magnetDiameterOversizedFor3dPrinting=magnetDiameter+0.2;
    
    translate([0,0,layerBelow]) {
            union() {
                translate([-(magnetDiameterOversizedFor3dPrinting)/2-magnetInset,0,0])
                    cylinder(d=magnetDiameterOversizedFor3dPrinting,h=magnetHeight+0.3,$fn=20);
                
                hull() {
                    translate([-(magnetDiameterOversizedFor3dPrinting)/2-magnetInset,0,0])
                        cylinder(d=magnetDiameterOversizedFor3dPrinting-1.4,h=magnetHeight+0.3,$fn=20);
                    translate([0,0,(magnetHeight+0.3)/2])
                        cube([0.1,magnetDiameterOversizedFor3dPrinting+0.4,magnetHeight+0.3],center=true);
                }
                
                translate([-(magnetDiameterOversizedFor3dPrinting)/2-magnetInset,0,0]) {
                    difference() {
                        cylinder(d=magnetDiameterOversizedFor3dPrinting+3,h=magnetHeight+0.3,$fn=20);
                        cylinder(d=magnetDiameterOversizedFor3dPrinting+2,h=magnetHeight+0.3,$fn=20);
                    }
                }
            }
        translate([-(magnetDiameterOversizedFor3dPrinting-magnetInset+1)/2-magnetInset,0,0])
            cube([magnetDiameterOversizedFor3dPrinting,1,1],center=true);
    }
}
            
pcbHolder();
