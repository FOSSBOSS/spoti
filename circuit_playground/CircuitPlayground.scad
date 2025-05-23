$fn=200;

//marginaly more parametric
bolt=1.55;
nut=5.43;

module outer_ring() {
    difference() {
        // Main solid cylinder
        cylinder(h = 3, r = 25.3, $fn = 200);

        // 16 evenly spaced holes, skipping i = 1 and 8
        for (i = [0 : 17]) {
            if (i != 1 && i != 9) {
                angle = i * 20;
                r_offset = 25.3 - 1.5 - 0.83;
                translate([r_offset * cos(angle), r_offset * sin(angle), -0.5])
                    cylinder(h = 6, r = bolt, $fn = 100);
            }
        }
    }
}

difference(){
outer_ring();
cylinder(5,3.5,3.5);
}
module hexagon(f2f = 5, thickness = 2.0) {
    r = f2f / (2 * cos(30));  // convert flat-to-flat to radius
    cylinder(h = thickness, r = r, $fn = 6);
}

module hexagon(f2f = nut, thickness = 2) {
    r = f2f / (2 * cos(30));  // Convert flat-to-flat to radius
    cylinder(h = thickness, r = r, $fn = 6);
}

module outer_ring_with_holes_and_hexes() {
    difference() {
        // Main solid cylinder
        cylinder(h = 5, r = 25.3, $fn = 200);

        // Holes + hex recesses
        for (i = [0 : 17]) {
            if (i != 1 && i != 9) {
                //angle = i * 22.5;
                angle = i * 20;
                r_offset = 25.3 - 1.5 - 0.83;

                x = r_offset * cos(angle);
                y = r_offset * sin(angle);

                // Round through-hole
                translate([x, y, -0.5])
                    cylinder(h = 6, r = bolt, $fn = 100);

                // Hex nut retainer (2mm deep)
                translate([x, y, 3])  // start at top surface (Z=3 to Z=5)
                    hexagon();
            }
        }
    }
}
translate([51,0,])

outer_ring_with_holes_and_hexes();

