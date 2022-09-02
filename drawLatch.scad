overallWidth = 30;    // overall outside width for the bases (if used) and the loop
toggleWidth = 20; // width of the toggle toggle
catchDepth=5;  // solid part of the catch
baseHeight = 2.5;
loopExtraLength = 0; // some extra clearence
haveBase = false;
loopSideWidth = (overallWidth-toggleWidth)/2;
basePintalWidth = overallWidth - (4*loopSideWidth);
loopHeight = 5;
loopCrossbarRadius = (loopHeight)/2 ;
toggleHeight = loopHeight *2;
catchBaseOffset = 2.5; // if starting n 2 uneaven surfaces
pinSize = 1.75; // use a peice of pla for the pin
pinR = pinSize/2;
pinClearance = 0.25;// for the pin holes that move freely
sideClearance = 0.5; // for the sides
catchWidth=toggleWidth;
catchRoundover = loopHeight/2;
catchRoundoverR = catchRoundover/2;
catchHeight = catchRoundover + loopHeight;
catchBaseHeight = baseHeight-catchBaseOffset;
catchOverallHeight = catchHeight+catchBaseHeight;
catchBaseY = catchDepth + toggleHeight;
catchDiag = toggleHeight *1.42; // diagnal or q square is sqrt(2) * side, we are cutting, so rounding up is OK.
toggleLength = 30;
togglePinOffset = toggleLength/2;
baseY = loopHeight*2.4;
loopLength = loopCrossbarRadius + loopHeight + togglePinOffset+catchDepth + loopHeight + loopExtraLength;
module roundBoxYZ(r,l,w){
  points = [[0,r,r], [0,(l-(2*r)),r] ];
    hull() {
        for(p=points) {
	  translate(p) rotate([0,90,0]) cylinder(r=r,h=w);
            }
        }
    }
module loop() {  // origin is at lower left of loop
  difference(){
    union() {
      roundBoxYZ(loopCrossbarRadius, loopLength, loopSideWidth);
      translate([toggleWidth+loopSideWidth,0,0]) roundBoxYZ(loopCrossbarRadius,loopLength,loopSideWidth);
      translate([0,(loopLength-loopHeight),loopCrossbarRadius]) rotate([0,90,0]) cylinder(r=loopCrossbarRadius-sideClearance,h=overallWidth);
    }
    // hole for the pin
    translate([-0.1,loopCrossbarRadius,loopCrossbarRadius]) rotate([0,90,0]) cylinder(r=pinR+pinClearance,h=overallWidth+0.2);
  }
}
module catchPlate(){
    echo(catchOverallHeight);
  difference(){
    union() {
      if(haveBase) { cube([overallWidth,catchBaseY,catchBaseHeight]); }
      translate([loopSideWidth+sideClearance,0,0]) cube([catchWidth-(2*sideClearance),catchDepth+loopCrossbarRadius,catchOverallHeight]); // main catch block
      translate([loopSideWidth+sideClearance,(catchDepth+loopCrossbarRadius),(catchOverallHeight-catchRoundoverR)]) 
	rotate([0,90,0]) cylinder(r=catchRoundoverR,h=catchWidth-(2*sideClearance));
    }
    // radius out catch
    translate([(loopSideWidth-0.1),(catchDepth+loopCrossbarRadius),(catchBaseHeight+loopCrossbarRadius)]) rotate([0,90,0]) cylinder(r=loopCrossbarRadius,h=catchWidth+0.2);
    // champfer bottom edge
    translate([loopSideWidth-0.1,0,(catchBaseHeight+catchRoundover)]) rotate([45,0,0]) cube([(catchWidth+0.2),catchDiag,catchDiag]);
  }
}
module toggle() {
  difference(){
    roundBoxYZ(loopCrossbarRadius, toggleLength, toggleWidth-(2*sideClearance)); // top of toggle (upside down)
	// cut in a hole for the base
      translate([loopSideWidth-sideClearance,0,-0.1]) cube([basePintalWidth,(loopHeight*2)+loopCrossbarRadius,(loopHeight +0.2)]);
    // top pin for pintle
    translate([-0.1,loopCrossbarRadius,loopCrossbarRadius]) rotate([0,90,0]) cylinder(r=pinR+pinClearance,h=overallWidth+0.2);
    translate([-0.1,togglePinOffset+loopCrossbarRadius,loopCrossbarRadius]) rotate([0,90,0]) cylinder(r=pinR+pinClearance,h=overallWidth+0.2);
  }
}
module base() {
     difference() {
    union() {
      if(haveBase) { cube([overallWidth,baseY,baseHeight]); }
      translate([(loopSideWidth*2)-sideClearance,0,0]) cube([basePintalWidth-(2*sideClearance),loopHeight*2,(baseHeight+loopHeight)]); // main catch block
      translate([(loopSideWidth*2)-sideClearance,loopCrossbarRadius,0]) cube([basePintalWidth-(2*sideClearance),loopHeight*2,(baseHeight+(loopHeight*1.5))]); // main catch block
      translate([(loopSideWidth*2)-sideClearance,loopCrossbarRadius,(baseHeight+loopHeight)]) rotate([0,90,0]) cylinder(r=loopCrossbarRadius,h=basePintalWidth-(2*sideClearance));     }
    translate([0,loopCrossbarRadius,(baseHeight+loopHeight)]) rotate([0,90,0]) cylinder(r=pinR+pinClearance,h=overallWidth+0.2);
        // champfer bottom edge
    //translate([(loopSideWidth*2)-0.1,(loopHeight*2.4),(baseHeight)]) rotate([45,0,0]) cube([(basePintalWidth+0.2),catchDiag,catchDiag]);
    // full bottom champfer
    translate([-0.1,(loopHeight*2.4)+baseHeight,0]) rotate([45,0,0]) cube([(overallWidth+0.2),catchDiag,catchDiag]);
      }
}
module assembled(){
  translate([overallWidth,loopLength-loopCrossbarRadius-catchDepth-loopHeight,baseHeight]) rotate(180) loop();
  translate([overallWidth,0,0]) rotate(180) catchPlate();
  translate([loopSideWidth,0,baseHeight]) toggle();
  base();
}
module print() {
  translate([-overallWidth-4,0,0]) loop();
  translate([0,-2,0]) rotate(180) catchPlate();
  translate([overallWidth +4,-2,0]) toggle();
  base();
}
//print();
// assembled();
//loop();
//toggle();
