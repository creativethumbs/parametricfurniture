thickness = 4; 
gap = 1; 

module weirdshape() {
linear_extrude(height = thickness, center = true, convexity = 10)
   import (file = "output.dxf");
}

module weirdshapehole() {
    scale([0.7,0.7,1]){
linear_extrude(height = 20, center = true, convexity = 10)
   import (file = "output.dxf");
    }
}

module weirdshape2() {
    difference() {
    weirdshape(); 
    weirdshapehole(); 
    }
} 

difference() {
    union() {
for(i = [1:15]) {
    rotate([0,0,i*5]) translate([0,0,thickness*i]) {
        scale([pow(0.95,i), pow(0.95,i), 1]) {
            weirdshape2(); 
        }
    }
}
}

translate([60,60,17*thickness]) scale([1,1,-1]) {
    union() {
for(i = [1:19]) {
     rotate([0,0,i*5])  translate([0,0,thickness*i]) 
    scale([0.8, 0.8, 2]) {
         {
            weirdshape(); 
        }
    }
}
}
}


}

translate([0,0,thickness])
scale([1,1,-1])
for(i = [1:17]) {
    rotate([0,0,-i*3]) translate([0,0,thickness*gap*i]) {
        scale([pow(0.98,i), pow(0.98,i), 1]) {
            weirdshape(); 
        }
    }
}
