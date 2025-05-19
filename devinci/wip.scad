$fn =200;
// Octogons have 1080 degrees

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
//difference() {
    // Background cylinder
    //cylinder(h = 10, r = 10, $fn = 100);

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
//}
}

translate([0,0,20]){
    
rotate([0,-90,180])logo();
}

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
module octagon_with_hole(size = 20, height = 5) {
    a = size / 1.5;
    points = [
        for (i = [0 : 7])
            [ size * cos(360 * i / 8), size * sin(360 * i / 8) ]
    ];

    rotate([0, 0, 22.5])  // align flat side
        difference() {
            linear_extrude(height)
                polygon(points);

            translate([0, 0, -1])  // penatrate
                cylinder(h = height + 2, r = a, $fn = 64);
        }
}

// Show octagon
octagon_height = 5;
octagon_size = 20;
octagon_with_hole(octagon_size, octagon_height);

// Place hullz aligned to one flat side
translate([0, octagon_size, octagon_height / 2])
    rotate([0, 90, 0])
        hullz(length = 5, w = 3, h = octagon_height);

