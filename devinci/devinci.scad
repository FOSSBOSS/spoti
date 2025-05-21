$fn =200;
// Octogons have 1080 degrees
sc = 22;
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
linear_extrude(40){
    // Arc 1
    translate([-5, 0, 0])   
    difference() {
        arcz(radius = 3, angle = 120, thickness = 2);
        translate([-1, 0]) arcz(radius = 3, angle = 120, thickness = 2);
    }

    // Arc 2
    translate([-3, 0, 0])
    difference() {
        arcz(radius = 4, angle = 120, thickness = 2);
        translate([-1, 0]) arcz(radius = 4, angle = 120, thickness = 2);
    }

    // Arc 3
    translate([-1, 0, 0])
    difference() {
        arcz(radius = 5, angle = 120, thickness = 2);
        translate([-1, 0]) arcz(radius = 5, angle = 120, thickness = 2);
    }
}
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
 
 //mk_ring();
 difference(){
 translate([0,0,10]){
          octagonz(size = 20, height = sc);
 translate([-20,0,12]){ 
     rotate([90,0,0])
          rotate([0,-90,180])logo();
}
 }
  }

 
translate([-20,0,12]){
    
    rotate([0, 90, 90]) // hull rotation
 hullz(2,3,40);
 }
  
// Cylinder     
 translate([-20,0,22]){
     difference(){
     rotate([90,0,90]) cylinder(40,7.5,7.5);
rotate([90,0,90]) cylinder(40,5.5,5.5);
     }
 }
 translate([0,0,10]){
     cylinder(sc,14,14); //solidify cap
 }
 
// MAKE A BODY
translate([0,0,30]){
difference(){ 
    //how long tho?
    /*
    ah... ring height * 22 rings. so 5*22=110
    + what? 0.. filled body with a different ring
    */
 cylinder(112,12,13.2); //13.2 is 0.13 less than ring inner radius
 cylinder(112,10,10);
}
}
/*
Could make an end cap..
you need 22 rings
*/