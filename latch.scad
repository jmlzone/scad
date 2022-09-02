width = 30;    // overall outside width for the base and the latch
camwidth = 20; // width of the cam toggle
catchDepth=5;
baseHeight = 4;
latchSideWidth = (width-camWidth)/2;
latchCrossBarRadius = (latchSideWidth)/2 ;
camHeight = 5;
catchBaseOffset = 2.5;
pinsize = 3;
give = 0.5;
catchWidth=camwidth;
catchHeight = 2 * camHeight;
catchBaseHeight = baseHeight-catchHeightOffset;
catchBaseY = catchDepth + camHeight;
catchDiag = camHeight *1.42; // diagnal or q square is sqrt(2) * side, we are cutting, so rounding up is OK.

module campins(){
  translate([-width,camwidth/4,camHeight/2])rotate([0,90,0])cylinder(r=pinsize/2,h=2*width);
  translate([-width,camwidth,-camHeight/2])rotate([0,90,0])cylinder(r=pinsize/2,h=2*width);
}


module cam(){
  difference(){
    union(){
      translate([0,camwidth/2,-camHeight])cube([camwidth,camwidth,camHeight+1]);
      difference(){
	cube([camwidth,camwidth*1.5,camHeight]);
	translate([camwidth/4,-1,-1])cube([camwidth/2,camwidth/2+1,camHeight+2]);
      }
    }
    campins();
  }
}

module base(){
  union(){
    difference(){
      translate([camwidth/4,0,-camHeight-height])cube([camwidth/2,camwidth/2,camHeight*2+height]);
      campins();
    }
    translate([-(width-camwidth)/2,0,-camHeight-height])cube([width,width*1,height]);
  }
}



module catch(){
  translate([camwidth,0,0])rotate([0,0,180])
    union(){
    translate([camwidth/4,0,-camHeight-height])cube([camwidth/2,camwidth/2,camHeight*2+height]);
    difference(){
      translate([camwidth/4,0,1])cube([camwidth/2,camwidth*2/3,height]);
      translate([0,camwidth*2/3,-1])rotate([45,0,0])translate([camwidth/4,-camwidth,0])cube([camwidth/2,camwidth*2,height]);
    }
    translate([-(width-camwidth)/2,0,-camHeight-height])cube([width,width*2/3,height]);
  }
}

module latch(){
  difference(){
    translate([-(width-camwidth)/2,-width*2/3,-camHeight])cube([width,width*1.5,camHeight]);
    translate([0,-camwidth/2-give,-camHeight-1])cube([camwidth,camwidth*2,camHeight+2]);
    campins();
    translate([-camwidth,-2.75*camwidth+pinsize,-camHeight-1])cube([camwidth*4,camwidth*2,camHeight+2]);
  }
}

module complete(){
  cam();
  base();
  catch();
  latch();
}

module printable(){
  translate([0,0,height])base();
  translate([width,width+3,0])rotate([180,0,0])cam();
  translate([width+3,0,height])catch();
  translate([-width-3,0,0])latch();
}

//printable();
//complete();
//catch();
cam();
//latch();
//base();