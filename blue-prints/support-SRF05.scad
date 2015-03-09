w = 8;
h = 25;
l = 47;

dv1 = 17;
dv2 = 3;
hv2 = 3;

difference() {
	translate([-h/2,-l/2,-w/2]) {
		cube([h,l,w]);
	}
	
 	for( a = [dv1/2+3.5, -dv1/2-3.5] ) {
		translate([0, a, -w]) {
			cylinder(h=2*w,d=dv1,$fn=60);	
		}
	}	

 	for( a = [-15, 15] ) {
		translate([-h/2-1, a, 0]) {
			rotate([0, 90, 0]) {
				cylinder(h=hv2+1,d=dv2,$fn=60);	
			}
		}
	}
		translate([-h/2-1, 0, -1]) {
			rotate([0, 90, 0]) {
				cylinder(h=hv2+1,d=dv2,$fn=60);	
			}
		}

	translate([7.5, 19, -1]) {
		cylinder(h=w,d=2,$fn=60);	
	}

	translate([-7.5, -19, -1]) {
		cylinder(h=w,d=2,$fn=60);	
	}

	translate([-h/2-1, -8, w/2-2]) {
		cube([5,16,w]);
	}
}