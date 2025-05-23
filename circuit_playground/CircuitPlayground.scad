$fn=200;
/*
    difference(){
sphere(d=51);
cylinder(27,27,27);

}
*/
module outer_ring() {
    difference() {
        // Main solid cylinder
        cylinder(h = 4, r = 25.3, $fn = 200);

        // 16 evenly spaced holes, skipping i = 1 and 8
        for (i = [0 : 15]) {
            if (i != 1 && i != 8) {
                angle = i * 22.5;
                r_offset = 25.3 - 1.5 - 0.83;
                translate([r_offset * cos(angle), r_offset * sin(angle), -0.5])
                    cylinder(h = 6, r = 1.28, $fn = 100);
            }
        }
    }
}

difference(){
outer_ring();
cylinder(5,3.5,3.5);
}
module hexagon(f2f = 5, thickness = 2) {
    r = f2f / (2 * cos(30));  // convert flat-to-flat to radius
    cylinder(h = thickness, r = r, $fn = 6);
}

module hexagon(f2f = 5, thickness = 2) {
    r = f2f / (2 * cos(30));  // Convert flat-to-flat to radius
    cylinder(h = thickness, r = r, $fn = 6);
}

module outer_ring_with_holes_and_hexes() {
    difference() {
        // Main solid cylinder
        cylinder(h = 5, r = 25.3, $fn = 200);

        // Holes + hex recesses
        for (i = [0 : 15]) {
            if (i != 1 && i != 8) {
                angle = i * 22.5;
                r_offset = 25.3 - 1.5 - 0.83;

                x = r_offset * cos(angle);
                y = r_offset * sin(angle);

                // Round through-hole
                translate([x, y, -0.5])
                    cylinder(h = 6, r = 1.5, $fn = 100);

                // Hex nut retainer (2mm deep)
                translate([x, y, 3])  // start at top surface (Z=3 to Z=5)
                    hexagon();
            }
        }
    }
}
translate([51,0,0])

outer_ring_with_holes_and_hexes();

/*
innerWide: 49.3
outer:0.9
innerShort=43.25
mount diameter x 2: 6.05
mount hole : 3mm
mount hole angle guess:22.5

*/