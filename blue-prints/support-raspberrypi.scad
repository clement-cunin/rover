hBase=3;
wBase=6;

H = 20;
d = 7;
dv1 = 2;
dv2 = 3;

wEnforcement = 2;
sizeEnforcement = 12;

difference() {
	union() {
		for( a = [40.19, -40.19, 180+40.19, 180-40.19] ) {
			rotate([0,0,a]) {
				translate([-wBase/2,10,0]) {
					cube([wBase,28,hBase]);
				}
				translate([0,38,0]) {
				difference() {
						cylinder(h=H,d=d,$fn=60);
						translate([0,0,H-10]) {
							cylinder(h=11,d=dv1,$fn=60);	
						}
					}
				}
				intersection() {
					translate([-wEnforcement/2,0,0]) cube([wEnforcement,38-dv1/2,sizeEnforcement]);
					translate([-wEnforcement/2,38-d/2-sizeEnforcement,h]) rotate([-45,0,0]) cube([wEnforcement,200,200]);
				}
			}
		}
		translate([-10,-15,0]) {
			cube([20, 30, hBase]);
		}
	}
	for( i= [-10, 0, 10] ) {
		translate([-5, i, -1]) {
			cylinder(h=(hBase+2),d=dv2,$fn=20);
		}
	}
}

/*
translate([-24.5, -29, H+1]) {
	cube([49,58,1]);
}
*/
