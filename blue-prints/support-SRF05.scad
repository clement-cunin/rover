w = 19;
h = 36.5;
l = 47;

dv1 = 17.25;
dv2 = 3;
hv2 = 5;

pcbL = 44;
pcbH = 21;
pcbW = 1.5;

difference() {
	intersection() {
		translate([-h/2,-l/2,-w/2])
			cube([h,l,w]);

		rotate([0,90,0])
			translate([-89,0,-100])
					cylinder(h=200, r=95, $fn=360);
	}

	
 	for( a = [-15, 15] )
		translate([+h/2+1, a, 0])
			rotate([0, -90, 0])
				cylinder(h=hv2+1,d=dv2,$fn=60);	

	translate([h/2+1, 0, -1])
		rotate([0, -90, 0])
			cylinder(h=hv2+1,d=dv2,$fn=60);

	for( a = [-15, 15] )
		translate([-h/2-1, a, 0])
			rotate([0, 90, 0])
				cylinder(h=hv2+1,d=dv2,$fn=60);	

	translate([-h/2-1, 0, -1])
		rotate([0, 90, 0])
			cylinder(h=hv2+1,d=dv2,$fn=60);

	rotate([180,8,0]) 
		translate([0,0,-8]) {
			union() {
				translate([-pcbH/2, -pcbL/2, -9.9])
					cube([pcbH,pcbL,10]);

				translate([pcbH/2-3,-6, 0])
					cube([3,12,1.5]);

				for( a = [dv1/2+3.25, -dv1/2-3.25] )
					translate([0, a, 0])
						cylinder(h=15,d=dv1,$fn=90);
			}

			color("red") {
				translate([7.5, -19, -1])
					cylinder(h=10,d=2.5,$fn=60);	

				translate([-7.5, 19, -1])
					cylinder(h=10,d=2.5,$fn=60);	
			}
		}
}
	
