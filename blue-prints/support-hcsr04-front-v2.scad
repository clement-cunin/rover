H = 31;
R = 100;
r = 89;
L = 150;

dv1 = 3;
hv1 = 11;

hcsr04L = 47;
hcsr04H = 22;
hcsr04W = 6;
hcsr04dv1 = 2;
hcsr04dc = 17.25;
hcsr04ec = 9;

e = 4;
alpha = atan(e/H);


module capteur_hcsr04() {
	union() {
		translate([-hcsr04H/2, -hcsr04L/2, -hcsr04W+0.1])
			cube([hcsr04H, hcsr04L, hcsr04W]);
		
		translate([hcsr04H/2-6, -6, 0])
			cube([6, 12, 5]);

		translate([-hcsr04H/2, -5.5, 0])
			cube([3, 11, 1]);

		for( x = [(hcsr04dc+hcsr04ec)/2, -(hcsr04dc+hcsr04ec)/2] )
			translate([0, x, 0])
				cylinder(h=11.5,d=hcsr04dc,$fn=90);
	}
}

translate([0,20-R,-H/2]) 
union() {
	// roue
	%translate([50,25,12.5])
	rotate([0,90,0])
	cylinder(h=25, d=65, $fn=60);


difference() {
	// pièce
	intersection() {
		translate([-L/2,R-40,0])
			cube([L,40,H]);
		
		difference() {
			translate([0, R-R/cos(alpha), 0]) rotate([alpha,0,0]) cylinder(h=2*H, r=R, $fn=360, center=true);
			translate([0, r-r/cos(alpha), 0]) rotate([alpha,0,0]) cylinder(h=2*H+1, r=r, $fn=360, center=true);
		}
	}

	// Vis 
	#color("red") {
		// bottom
		for( a = [-41.945, /*-33.192,*/ -25.141, -9.085, /*0,*/ 9.085, 25.141, /*33.192,*/ 41.945 ] )
		rotate([0, 0, a]) translate([0, 95, -1]) cylinder(h=hv1+1,d=dv1,$fn=60);	
	
		// top
		translate([0,-e,0])
		for( a = [/*-41.945,*/ -33.192, /*-25.141, -9.085,*/ 0, /*9.085, 25.141,*/ 33.192/*, 41.945*/ ] )
			rotate([0, 0, a]) translate([0, 95, H-hv1]) cylinder(h=hv1+1,d=dv1,$fn=60);	
	}

	// capteurs lateraux
	for( a = [-35, 0, 35] ) {
		translate([0, 9, H/2+1])
		rotate([0,90,90+a]) 
		translate([0,0,82-e/2+(a==0?-2:0)])
		rotate([0,-6,0])
		capteur_hcsr04();
	}

	
}
}