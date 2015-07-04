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
module extrude(h=5) {
    linear_extrude(height=5)children();
}
//Parts
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
module yRodHold(bottom=false,middle=false,top=false) {
    difference() {
        square([40,100],center=true);
        tr_xy(12,21)circle(r=2.5);
        if(top==true)tr_xy(12,21)circle(r=4);
        tr_xy(12,45)circle(r=1.5);
        if(middle==true){
            for(i=[0,1])mirror([0,i,0])translate([-3.5,35])square([33,8],center=true);
            
        }
    }
    if(middle==true)translate([0,56])difference() {
                square([40,12],center=true);
                translate([-5,0])square([2.5,7],center=true);
    }
    for(i=[0,1])mirror([0,i,0])if(bottom==true)translate([23,44])difference() {
                square([14,12],center=true);
                square([7,2.5],center=true);
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
            circle(r=2.5);
            tr_xy(x=9)circle(r=1.5);
        }
    }
}
module connectionCover() {
    difference() {
        circle(r=18.5);
        circle(r=2.5);
        tr_xy(x=9)circle(r=1.5);
    }
}
module bearingOne() {
    difference() {
        cube([34,58,20],center=true);
        tr_xy(12,21)cylinder(r=2,h=11);
        rotate([90,0,0])cylinder(r=4,h=58,center=true);
    }
}
module carriage() {
    difference(){
        square([100,100],center=true);
        bearingCut();
    }
}
module bearingCut() {
    projection(cut=true)translate([0,0,-2.5])for(j=[1,0])mirror([j,0,0])for(i=[1,0])mirror([0,i,0])translate([30,35])rotate([0,90,0])cylinder(r=7.5,h=24,center=true);
    for(j=[1,0])mirror([j,0,0])for(i=[1,0])mirror([0,i,0])translate([30,35])tr_xy(x=9,y=10)square([6,2],center=true);
}

//Assemblies
module rodHoldX() {
    rotate([0,0,-90]){
        extrude()xRodHold();
        translate([0,0,5])extrude()xRodHold();
        translate([0,0,10])extrude()xRodHold(bottom=false);
        translate([0,0,18])extrude()rotate([0,0,180])xRodHold(top=true);
    }
}
module rodHoldY() {
    extrude()yRodHold(bottom=true);
    translate([0,0,5])extrude()yRodHold(middle=true);
    translate([0,0,13])extrude()yRodHold(top=true);
}
module x() {
    rotate([90,0,0])profile(500,true);
    translate([0,0,32])rotate([90,0,0])cylinder(r=4,h=470,center=true);
    for(i=[0,1])mirror([0,i,0])translate([0,-230,20])rotate([0,0,90])rodHoldX();
    translate([0,0,32])bearingOne();
    translate([20,-295,-20])rotate([0,0,180])rotate([90,0,0])rotate([0,-90,0])extrude()
        connectionMotor();
    translate([25,295,-20])rotate([90,0,0])rotate([0,-90,0])extrude()
        connectionMotor(false);   
    translate([22,295,-20])rotate([90,0,0])rotate([0,-90,0])extrude()
        translate([25,61])connectionCover();
}
module y() {
    offSet=230;
    for(i=[1,0])mirror([i,0,0])translate([offSet,0])rodHoldY();   
    for(i=[-1,1])translate([0,i*35,9])rotate([0,90,0])cylinder(r=4,h=470,center=true);
    translate([0,0,50])extrude()carriage();
}

module assembly() {
    for(i=[0,1])mirror([0,i,0])translate([0,270])rotate([0,90,0])profile(500,true);
    for(i=[0,1])mirror([i,0,0])translate([230,0])x();
    translate([0,0,42])y();
}
assembly();