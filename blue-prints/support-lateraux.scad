H = 30;
dv1 = 3;
hv1 = 9;
hv2 = 19;
e = 4;
alpha = atan(e/H);

W = 15;
L = 40;

module support() 
translate([-W-5,0,0])
difference() {
	// pièce
	intersection() {
		translate([0,-L/2-e,0]) cube([W,L+e,H]);
		rotate([alpha,0,0]) translate([0,-L/2,-10]) cube([W,cos(alpha)*L,H*2]);
	}

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