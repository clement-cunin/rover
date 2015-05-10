H = 30;
W = 13;
L = 97;

dv1 = 3;
hv1 = 9;
hv2 = 19;

switchH = 16;
switchL = 8;

e = 4;
alpha = atan(e/H);


translate([0,20-R,-H/2]) 
union() {


difference() {
	// pièce
	translate([-L/2, 0, 0])
	intersection() {
		translate([0,-e,0]) cube([L,W+e,H]);
		
		rotate([alpha,0,0]) translate([0,0,-10]) cube([100,W,H*2]);
		/*difference() {
			translate([0, R-R/cos(alpha), 0]) rotate([alpha,0,0]) cylinder(h=2*H, r=R, $fn=360, center=true);
			translate([0, r-r/cos(alpha), 0]) rotate([alpha,0,0]) cylinder(h=2*H+1, r=r, $fn=360, center=true);
		}*/
	}

	#color("red") {
		translate([31.5, 8, -1]) cylinder(h=hv2+1,d=dv1,$fn=60);
		translate([42, 6, -1]) cylinder(h=hv2+1,d=dv1,$fn=60);
		translate([-31.5, 8, -1]) cylinder(h=hv1+2,d=dv1,$fn=60);
		translate([-42, 6, -1]) cylinder(h=hv2+1,d=dv1,$fn=60);

		translate([42, 6-e, H-hv1]) cylinder(h=hv1+1,d=dv1,$fn=60);
		translate([-42, 6-e, H-hv1]) cylinder(h=hv1+1,d=dv1,$fn=60);
	}

	// piles
	translate([-59/2, -20, -1]) cube([59, 50, H+2]);
	translate([59/2-1, -20, H-12]) cube([6, 50, 13]);

	// interupteur
	rotate([0, 90-alpha, 90])
	translate([-18, 29, 0])
	color("blue") {
		translate([-switchH/2, -1, -1])
			cube([switchH, switchL+1, 20]);
		for( a = [-9.5, 9.5] )
			translate([a,switchL/2,-1])
				cylinder(h=13, d=2, $fn=360);
	}

}
}