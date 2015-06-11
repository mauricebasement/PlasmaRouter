$fn=10;
//Modules
module profile(lenght,center=false) {
    if (center==false)linear_extrude(height=lenght)import("profile.dxf");
    if (center==true)translate([0,0,-lenght/2])linear_extrude(height=lenght)import("profile.dxf");
}
module br1_holes() {
    tr_xy(42,24)circle(r=2);
}
module br2_holes() {
    tr_xy(24,18)circle(r=2);
}
//Library
module tr_xy(x,y=0) {
	if(y==0) {
		for(i=[-1,1])for(j=[-1,1])translate([x*i,x*j])children();
	} else {
		for(i=[-1,1])for(j=[-1,1])translate([x*i,y*j])children();
	}
}
//X
module x() {
    rotate([90,0,0])profile(500,true);
    translate([0,0,32])rotate([90,0,0])cylinder(r=4,h=470,center=true);
    for(i=[0,1])mirror([0,i,0])translate([0,-230,20])rotate([0,0,90])rodHold();
    translate([0,0,32])bearingOne();
}
module rodHold() {
    difference() {
        translate([-7.5,0,10])cube([25,40,20],center=true);
        tr_xy(x=10)cylinder(r=2.5,h=20);      
        translate([0,0,12])rotate([0,90,0])cylinder(r=4,h=12,center=true);
    }
}
module bearingOne() {
    difference() {
        cube([34,58,22],center=true);
        tr_xy(12,21)cylinder(r=2.5,h=11);
        rotate([90,0,0])cylinder(r=4,h=58,center=true);
    }
}
module assembly() {
    for(i=[0,1])mirror([i,0,0])translate([230,0])x();
    for(i=[0,1])mirror([0,i,0])translate([0,270])rotate([0,90,0])profile(500,true);
}
!assembly();
/*
//Profiles
for(i=[-1,1])translate([i*270,0])rotate([90,0,0])profile(500,true);
for(i=[-1,1])translate([0,i*270])rotate([90,0,90])profile(500,true);
//Rods
rodOffset=50;
for(i=[-1,1])translate([i*270,0,rodOffset])rotate([90,0,0])cylinder(r=4,h=470,center=true);
*/


/*
br1_holes();
br2_holes();
*/