
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
                cylinder(h = height + 2, r = a, $fn = 64);
        }
}
module mk_ring(){
// Show octagon
octagon_height = 5;
octagon_size = 20;
octagonz(octagon_size, octagon_height);

// hullz 1
translate([0, octagon_size, octagon_height / 2])
    rotate([0, 90, 0])
        hullz(length = 2, w = 3, h = octagon_height);


// hullz 2
translate([-14, 14, octagon_height / 2])
    rotate([0, 90, 45]) // hull rotation
        hullz(length = 3, w = 3, h = octagon_height);

// hullz 3
translate([-20, 0, octagon_height / 2])
    rotate([0, 90, 90]) // hull rotation
        hullz(length = 4, w = 3, h = octagon_height);
        
// hullz 4
translate([-11, -10, octagon_height / 2])
    rotate([0, 90, -45]) // hull rotation
        hullz(length = 5, w = 3, h = octagon_height);        
        
// hullz 5
translate([0, -15, octagon_height / 2])
    rotate([0, 90, 0]) // hull rotation
        hullz(length = 6, w = 3, h = octagon_height);           
    
// hullz 6
translate([10.5, -10.5, octagon_height / 2])
    rotate([0, 90, 45]) // hull rotation
        hullz(length = 7, w = 3, h = octagon_height); 
        
// hullz 7
translate([15, 0, octagon_height / 2])
    rotate([0, 90, 90]) // hull rotation
        hullz(length = 8, w = 3, h = octagon_height);

// hullz 8
translate([14, 14, octagon_height / 2])
    rotate([0, 90, -45]) // hull rotation
        hullz(length = 9, w = 3, h = octagon_height);  
 
 }
 
 mk_ring();
