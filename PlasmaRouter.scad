$fn=50;
//Modules
module profile(lenght,center=false) {
    if (center==false)linear_extrude(height=lenght)import("profile.dxf");
    if (center==true)translate([0,0,-lenght/2])linear_extrude(height=lenght)import("profile.dxf");
}
module br2_holes() {
    tr_xy(24,18)circle(r=2);
}
module motor() {
  difference(){
      translate([-21,-21,0])cube([42,42,50]);
      tr_xy(13.5)cylinder(r=1.5,h=10);
  }
  translate([0,0,-1.5])cylinder(h=1.5,r=11);
  translate([0,0,-15])cylinder(r=3,h=13.5);
}
module slot(x,r,o)  {
    hull()for(i=[-1,1])rotate(o)translate([x/2*i,0])circle(r=r);
}
module motorCut(o=90) {
    slot(2,11,o);
    tr_xy(x=15.5)slot(2,1.5,o);
}
//Library
module tr_xy(x,y=0) {
	if(y==0) {
		for(i=[-1,1])for(j=[-1,1])translate([x*i,x*j])children();
	} else {
		for(i=[-1,1])for(j=[-1,1])translate([x*i,y*j])children();
	}
}
module y() {
    offSet=230;
    translate([21+offSet,45])rotate([90,0,0])linear_extrude(height=5)yBeltHold();
    mirror([1,0,0])translate([21+offSet,45])rotate([90,0,0])linear_extrude(height=5)yBeltHold(false);
    for(i=[1,0])mirror([i,0,0])translate([offSet,0])yRodHold();
    for(i=[-1,1])translate([0,i*34])rotate([0,90,0])cylinder(r=4,h=470,center=true);    
    
}
module yRodHold() {
    difference() {
        cube([34,80,14],center=true);
        tr_xy(x=12,y=21)cylinder(r=2.2,h=15,center=true);
        for(i=[-1,1])translate([0,34*i])rotate([0,90,0])cylinder(r=4.1,h=35,center=true);
    }
    difference() {
        translate([0,34.5,0])cube([34,11,42],center=true);
        translate([0,41,0])rotate([90,0,0]) {
            tr_xy(x=12,y=16)cylinder(r=1.6,h=14);    
            translate([0,-18])cylinder(r=6,h=14);
        }
        translate([0,34])rotate([0,90,0])cylinder(r=4.1,h=35,center=true);
    }
    
}
module yBeltHold(motor=true) {
    difference() {
        if(motor==true)translate([4,0])square([84,42],center=true);
        if(motor==false)translate([-6,0])square([64,42],center=true);
        if(motor==true) {
            translate([21,0])motorCut(o=0);
            translate([-21,0])tr_xy(x=12,y=16)circle(r=1.6);
        }
        if(motor==false) {
            translate([8,0])circle(r=8);
            translate([-21,0])tr_xy(x=12,y=16)circle(r=1.6);
        }
        translate([-21,-18])circle(r=6);
    }
}
module x() {
    rotate([90,0,0])profile(500,true);
    translate([0,0,32])rotate([90,0,0])cylinder(r=4,h=470,center=true);
    for(i=[0,1])mirror([0,i,0])translate([0,-230,20])rotate([0,0,90])rodHold();
    translate([0,0,32])bearingOne();
    translate([20,-295,-20])rotate([0,0,180])rotate([90,0,0])rotate([0,-90,0])linear_extrude(height=5)
        connectionMotor();
    translate([25,295,-20])rotate([90,0,0])rotate([0,-90,0])linear_extrude(height=5)
        connectionMotor(false);   
    translate([22,295,-20])rotate([90,0,0])rotate([0,-90,0])linear_extrude(height=3)
        translate([25,61])connectionCover();
}
module rodHold() {
    difference() {
        translate([-7.5,0,10])cube([25,40,20],center=true);
        tr_xy(x=10)cylinder(r=2.5,h=20);      
        translate([0,0,12])rotate([0,90,0])cylinder(r=4.1,h=12,center=true);
    }
}
module bearingOne() {
    difference() {
        cube([34,58,20],center=true);
        tr_xy(12,21)cylinder(r=2.5,h=11);
        rotate([90,0,0])cylinder(r=4,h=58,center=true);
    }
}
module connectionMotor(motor=true) {
    difference() {
        hull(){
            square([90,40]);
            square([50,90]);
        }
        for(i=[25,70])translate([i,20])tr_xy(x=10)circle(r=2.5);
        if(motor==true)translate([25,61])motorCut();
        if(motor==false)translate([25,61]){
            circle(r=6.5);
            tr_xy(x=9)circle(r=1.5);
        }
    }
}
module connectionCover() {
    difference() {
        circle(r=18.5);
        circle(r=6.5);
        tr_xy(x=9)circle(r=1.5);
    }
}
module assembly() {
    for(i=[0,1])mirror([0,i,0])translate([0,270])rotate([0,90,0])profile(500,true);
    for(i=[0,1])mirror([i,0,0])translate([230,0])x();
    *translate([0,0,49])y();
}
assembly();
module xRodHold(bottom=true,top=false) {
    difference() {
        square(40,center=true);
        if(bottom==true)tr_xy(x=10)circle(r=2.5);
        if(bottom==false){
            tr_xy(x=10)circle(r=2.5);
            translate([0,10])square([8,20],center=true);
        }
        if(top==true)translate([0,10])square([40,20],center=true);
    }
}
!xRodHold();
//Cutting Aid
module cuttingAid() {
    difference() {
        square([80,40],center=true);
        for(i=[-1,1])translate([i*20,0])tr_xy(x=10)circle(r=2.5);
   }
}