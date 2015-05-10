H = 30;
dv1 = 3;
hv1 = 9;
hv2 = 19;
e = 4;
alpha = atan(e/H);

W = 15;

gearD = 118;

module support() 
translate([-W-5,0,0])
difference() {
	// pièce
	translate([0,-gearD/2-e,0]) cube([W,gearD,H]);
	
	// gear 1
	translate([-1, gearD/2, 12.5]) rotate([0, 90, 0]) cylinder(h=W+2, r=40, $fn=90);

	// gear 1
	translate([-1, -gearD/2, 12.5]) rotate([0, 90, 0]) cylinder(h=W+2, r=40, $fn=90);
	
	// vis
	# color("red") {
		translate([10, 13.5/2, -1]) cylinder(h=hv2+1,d=dv1,$fn=60);
		translate([10, -13.5/2, -1]) cylinder(h=hv2+1,d=dv1,$fn=60);
		
		translate([10, 13.5/2-e, H-hv2]) cylinder(h=hv2+1,d=dv1,$fn=60);
		translate([10, -13.5/2-e, H-hv2]) cylinder(h=hv2+1,d=dv1,$fn=60);
	}
}

support();

mirror([1,0,0]) support();