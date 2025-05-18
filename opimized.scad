$fn = 100;

module arcz(radius = 10, angle = 90, thickness = 2, steps = 100, center = [0, 0]) {
    r1 = radius;
    r2 = radius - thickness;

    outer_points = [
        for (i = [0 : steps])
            let(a = -angle / 2 + i * angle / steps)
            [r1 * cos(a), r1 * sin(a)]
    ];

    inner_points = [
        for (i = [steps : 0 : -1])
            let(a = -angle / 2 + i * angle / steps)
            [r2 * cos(a), r2 * sin(a)]
    ];

    polygon_points = concat(outer_points, inner_points);
    translate(center)
        polygon(points = polygon_points);
}


module logo(){
//--- Main difference block ---
difference() {
    // Background cylinder
    cylinder(h = 10, r = 5.3, $fn = 100);

    // Arc 1
    translate([-5, 0, 0])
    linear_extrude(10)
    difference() {
        arcz(radius = 3, angle = 120, thickness = 2);
        translate([-1, 0]) arcz(radius = 3, angle = 120, thickness = 2);
    }

    // Arc 2
    translate([-3, 0, 0])
    linear_extrude(10)
    difference() {
        arcz(radius = 4, angle = 120, thickness = 2);
        translate([-1, 0]) arcz(radius = 4, angle = 120, thickness = 2);
    }

    // Arc 3
    translate([-1, 0, 0])
    linear_extrude(10)
    difference() {
        arcz(radius = 5, angle = 120, thickness = 2);
        translate([-1, 0]) arcz(radius = 5, angle = 120, thickness = 2);
    }
}
}

logo();

module hullz(length = 1, w = 3, h = 1) {
    radius = w / 2;

    hull() {
        translate([-length / 2, 0, 0])
            cylinder(h = h, r = radius, $fn = 32);
        translate([length / 2, 0, 0])
            cylinder(h = h, r = radius, $fn = 32);
    }
}



module ringz(count, ring_width = 5, height = 10, margin = 0.2) {
    slot_lengths = [2, 9, 3, 8, 4, 7, 5, 6];  // Safe pattern: short/long balanced

    for (i = [2 : count+1]) {
        outer_radius = i * (ring_width + margin);
        inner_radius = outer_radius - ring_width;
        mid_radius = (outer_radius + inner_radius) / 2;

        difference() {
            // Main ring body
            cylinder(h = height, r = outer_radius, $fn = 100);
            cylinder(h = height + 0.1, r = inner_radius, $fn = 100);

            // 8 hullz slots
            for (j = [0 : 7]) {
                angle = j * 45;

                // Set len = 2 for rings 1 and 2; use slot_lengths for ring 3+
                len = (i <= 2) ? 2 : slot_lengths[j];

                rotate([0, 0, angle])
                    translate([mid_radius, 0, 0])
                        rotate([0, 0, 90])
                            hullz(length = len, w = 3 / sqrt(2), h = height + 0.5);
            }
        }
    }
}

ringz(24);

