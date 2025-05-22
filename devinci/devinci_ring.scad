//Octogon has 1080 degrees,
//Changed dimensions based on a working model
// Hull shape module
module hullz(length = 1, w = 3, h = 1) {
    radius = w / 2;

    rotate([90, 90, 0]) {
        hull() {
            translate([-length / 2, 0, 0])
                cylinder(h = h, r = radius, $fn = 32);
            translate([length / 2, 0, 0])
                cylinder(h = h, r = radius, $fn = 32);
        }
    }
}

// Octagon with center hole
module octagonz(size = 20, height = 5) {
    a = size / 1.5;
    
    echo("A: ", a);
    points = [
        for (i = [0 : 7])
            [ size * cos(360 * i / 8), size * sin(360 * i / 8) ]
    ];

    rotate([0, 0, 22.5])  // align flat side
        difference() {
            linear_extrude(height)
                polygon(points);

            translate([0, 0, -1])  // penatrate
                cylinder(h = height + 2, r = a, $fn = 100);
        }
}

module mk_ring() {
    octagon_height = 5;
    octagon_size = 42; //A=28 at 42

    // Show octagon
    octagonz(octagon_size, octagon_height);

    // Loop to place 8 hullz()
    for (itter = [0 : 7]) {
        angle = itter * 45;
        len = 4.5 + 2.625 * itter;

        translate([
            octagon_size * cos(angle),
            octagon_size * sin(angle),
            octagon_height / 2
        ])
       
        rotate([90, 90, angle])
            hullz(length = len, w = 3, h = octagon_height);
    }
}

mk_ring();
