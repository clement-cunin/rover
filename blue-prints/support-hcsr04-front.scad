H = 31;
R = 100;
r = 88;
L = 150;

dv1 = 3;
hv1 = 11;

hcsr04L = 47;
hcsr04H = 22;
hcsr04W = 1.5;
hcsr04dv1 = 2;
hcsr04dc = 17.25;
hcsr04ec = 9;



translate([0,20-R,-H/2])
difference() {
	intersection() {
		translate([-L/2,R-40,0])
			cube([L,40,H]);

		difference() {
			cylinder(h=H, r=R, $fn=360);
			translate([0,0,-1]) cylinder(h=H+2, r=r, $fn=360);
		}
	}

	color("red")
	for( a = [-41.945, /*-33.192,*/ -25.141, -9.085, /*0,*/ 9.085, 25.141, /*33.192,*/ 41.945 ] ) {
		rotate([0, 0, a]) translate([0, 95, -1]) cylinder(h=hv1+1,d=dv1,$fn=60);	
	}

	color("red")
	for( a = [/*-41.945,*/ -33.192, /*-25.141, -9.085,*/ 0, /*9.085, 25.141,*/ 33.192/*, 41.945*/ ] ) {
		rotate([0, 0, a]) translate([0, 95, H-hv1]) cylinder(h=hv1+1,d=dv1,$fn=60);	
	}

	for( a = [-34, 0, 34] ) {

	translate([0, 0, H/2+2.5])
	rotate([0,90,90+a]) 
	translate([0,0,89])
	rotate([0,-8,0])
	union() {
		translate([-hcsr04H/2, -hcsr04L/2, -9.9])
			cube([hcsr04H, hcsr04L, 10]);

		translate([hcsr04H/2-6, -6, 0])
			cube([6, 12, 5]);

		for( x = [(hcsr04dc+hcsr04ec)/2, -(hcsr04dc+hcsr04ec)/2] )
			translate([0, x, 0])
				cylinder(h=15,d=hcsr04dc,$fn=90);

		/*color("red") {
			for( x = [-17.5/2, 17.5/2] ) {
				for( y = [-42.5/2, 42.5/2] ) {
					translate([-x, -y, 0]) cylinder(h=6,d=hcsr04dv1,$fn=60);	
				}
			}
		}*/
	}
	}
}
