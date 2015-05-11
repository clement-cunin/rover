H = 31;
L = 247;
W = 155;

e = 4;
alpha = atan(e/H);

dv1 = 3;
hv1 = 11;
hv2 = 21;


module capteur_hcsr04() {
	hcsr04L = 47;
	hcsr04H = 22;
	hcsr04W = 6;
	hcsr04dv1 = 2;
	hcsr04dc = 17.25;
	hcsr04ec = 9;
	#union() {
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

module base() {
	h = 2;

	difference() {
		union() {
			intersection() {
				translate([-W/2, -L/2+100, -2.05]) cube([W, L/2, h]);
				cylinder(h=2*h, r=100, $fn=360, center=true);
			}
			translate([-W/2, -L+100, -2.05]) cube([W, L/2, h]);
		}
		translate([97/2, -13, -2*h]) cube([30, 73, 3*h]);
		translate([-97/2-30, -13, -2*h]) cube([30, 73, 3*h]);
		translate([97/2, -126, -2*h]) cube([30, 73, 3*h]);
		translate([-97/2-30, -126, -2*h]) cube([30, 73, 3*h]);
		translate([-83/2, -L+100-2, -2*h]) cube([83, 10, 3*h]);
	}
}

module front() {
	r = 89;
	l = 153;
	R = 100;

	difference() {
	
		// pièce
		intersection() {
			translate([-l/2,R-40,0]) cube([l,40,H]);
		
			difference() {
				translate([0, R-R/cos(alpha), 0]) rotate([alpha,0,0]) cylinder(h=2*H, r=R, $fn=360, center=true);
				translate([0, r-r/cos(alpha), 0]) rotate([alpha,0,0]) cylinder(h=2*H+1, r=r, $fn=360, center=true);
			}
		}

		// Vis 
		color("red") {
			// bottom
			for( a = [-41.945, /*-33.192,*/ -25.141, -9.085, /*0,*/ 9.085, 25.141, /*33.192,*/ 41.945 ] )
			rotate([0, 0, a]) translate([0, 95, -1]) cylinder(h=hv1+1,d=dv1,$fn=60);	
	
			// top
			translate([0,-e,0])
			for( a = [/*-41.945,*/ -33.192, /*-25.141, -9.085,*/ 0, /*9.085, 25.141,*/ 33.192/*, 41.945*/ ] )
				rotate([0, 0, a]) translate([0, 95, H-hv1]) cylinder(h=hv1+1,d=dv1,$fn=60);	
		}

		// capteurs HC_SR04
		for( a = [-35, 0, 35] ) {
			translate([0, 9, H/2+1])
			rotate([0,90,90+a]) 
			translate([0,0,82-e/2+(a==0?-2:0)])
			rotate([0,-6,0])
			capteur_hcsr04();
		}
	}
}

module back() {
	w = 13;
	l = 97;
	switchH = 16;
	switchL = 8;

	translate([0, -L+100+8, 0])
	difference() {
		// pièce
		translate([-l/2, 0, 0])
		intersection() {
			translate([0,-e,0]) cube([l,w+e,H]);
		
			rotate([alpha,0,0]) translate([0,0,-10]) cube([100,w,H*2]);
		}

		// vis
		#color("red") {
			translate([31.5, 8, -1]) cylinder(h=hv2+1,d=dv1,$fn=60);
			translate([42, 6, -1]) cylinder(h=hv2+1,d=dv1,$fn=60);
			translate([-31.5, 8, -1]) cylinder(h=hv1+2,d=dv1,$fn=60);
			translate([-42, 6, -1]) cylinder(h=hv2+1,d=dv1,$fn=60);

			translate([42, 6-e, H-hv1]) cylinder(h=hv1+1,d=dv1,$fn=60);
			translate([-42, 6-e, H-hv1]) cylinder(h=hv1+1,d=dv1,$fn=60);
		}

		// piles
		translate([-59/2, -10, -1]) cube([59, 50, H+2]);
		translate([59/2-1, -10, H-12]) cube([6, 30, 13]);

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

module lateraux() {
	w = 12;
	gearD = 118;
	size=110;

	translate([-W/2+15,-33,0])
	difference() {
		// pièce
		translate([-w,-gearD/2-e,0]) cube([w,gearD,H]);
	
		// gear 1
		if( e<3) translate([-w-1, gearD/2, 12.5]) rotate([0, 90, 0]) cylinder(h=w+2, r=40, $fn=90);
		if( e>=3) translate([-w-1, 20+size-e, H]) rotate([0, 90, 0]) cylinder(h=w+2, r=size, $fn=90);

		// gear 2
		translate([-w-1, -gearD/2, 12.5]) rotate([0, 90, 0]) cylinder(h=w+2, r=40, $fn=90);
	
		// vis
		# color("red") {
			translate([-w/2, 13.5/2, -1]) cylinder(h=hv1+1,d=dv1,$fn=60);
			translate([-w/2, -13.5/2, -1]) cylinder(h=hv1+1,d=dv1,$fn=60);
			translate([-w/2, 13.5/2-e, H-hv1]) cylinder(h=hv1+1,d=dv1,$fn=60);
			//translate([-w/2, -13.5/2-e, H-hv1]) cylinder(h=hv1+1,d=dv1,$fn=60);
		}

		rotate([180,90,0]) translate([-H/2, 0, 1]) capteur_hcsr04();
	}
}

module gears() {
	d=64;
	translate([50,25,12.5]) rotate([0,90,0]) cylinder(h=25, d=d, $fn=60);
	translate([50,25-115,12.5]) rotate([0,90,0]) cylinder(h=25, d=d, $fn=60);
	mirror([]) {
		translate([50,25,12.5]) rotate([0,90,0]) cylinder(h=25, d=d, $fn=60);
		translate([50,25-115,12.5]) rotate([0,90,0]) cylinder(h=25, d=d, $fn=60);
	}
}


union() {
	%gears();
	%base();
	%rotate([0,180,0]) translate([0, -e, -H]) base();

	front();
	back();

	lateraux();
	mirror() lateraux();
}