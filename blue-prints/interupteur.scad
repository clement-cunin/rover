
//union() {
difference(){
	translate([-35/2,0,0])
		cube([35, 10, 10]);

	translate([-16/2,-1,-1])
		cube([16, 8.5, 13]);

	for( a = [-9.5, 9.5] )
		translate([a,3.6,-1])
			cylinder(h=32, d=2, $fn=360);

	rotate([90, 0, 0]) {
		translate([27/2,10-7,-20])
			cylinder(h=32, d=2.2, $fn=360);
		translate([-27/2,5,-20])
			cylinder(h=32, d=2.5,$fn=360);
	}
}