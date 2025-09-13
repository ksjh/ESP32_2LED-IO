part = "c"; // c: case, l: lid

// PCB size
pcbx = 47.5;
pcby = 26.5;
pcbz = 1.6;

pcbo = 1.0;

px = pcbx + pcbo;
py = pcby + pcbo;

fl = 1.2; // floor
wall = 1.2; // wall

// heat insert nut M3, L 4mm, OD 5mm
nutd = 4.4;
nuth = 5;
nutod = nutd + 2 * wall;

// total case size
tx = px + 2 * sidex + 2 * wall;
ty = py + 2 * wall;
tz = 15;
caser = 4;
sidex = nutod;

// standoff
sox = 3;
soz = nuth;
sod = 10;

// mounting screw
scx = 17.5;
scy = 7.5;
scd = 3.2;

// lid hole
hsx = 6.1;
hsy = 13.8;
hox = 4.19;
hoy = 10.62;

// USB connector
usbzl = fl + soz + pcbz;
usbx = 28;
usbsx = 10;
usbsz = 4;
usbsy = 7;

zf = 0.01;
$fn = 90;
pl = 0.2;

fl2 = fl + pl;

module rcube(x, y, z, r) {
  union() {
    translate([0, r, 0]) cube([x, y - 2 * r, z]);
    translate([r, 0, 0]) cube([x - 2 * r, y, z]);
    translate([r, r, 0]) cylinder(r=r, h=z);
    translate([r, y - r, 0]) cylinder(r=r, h=z);
    translate([x - r, r, 0]) cylinder(r=r, h=z);
    translate([x - r, y - r, 0]) cylinder(r=r, h=z);
  }
}

if (part == "c") {
  difference() {
    union() {
      difference() {
        rcube(tx, ty, tz, caser);
        translate([wall + sidex + sox, wall, fl])
          cube([px - 2 * sox, py, tz]);
        translate([wall + sidex, wall, fl + soz])
          cube([px, py, tz]);
        translate([wall, wall, tz - fl2])
          rcube(tx - 2 * wall, ty - 2 * wall, tz, caser - wall);
        translate([wall + nutod / 2, wall + nutod / 2, tz - fl2 - nuth])
          cylinder(d=nutd, h=tz);
        translate([tx - (wall + nutod / 2), wall + nutod / 2, tz - fl2 - nuth])
          cylinder(d=nutd, h=tz);
        translate([wall + nutod / 2, ty - (wall + nutod / 2), tz - fl2 - nuth])
          cylinder(d=nutd, h=tz);
        translate([tx - (wall + nutod / 2), ty - (wall + nutod / 2), tz - fl2 - nuth])
          cylinder(d=nutd, h=tz);
      }
      translate([wall + sidex + pcbo / 2 + scx, wall + pcbo / 2 + scy, 0])
        cylinder(d=sod, h=fl + soz);
    }
    translate([wall + sidex + pcbo / 2 + scx, wall + pcbo / 2 + scy, fl])
      cylinder(d=nutd, h=fl + soz);
    translate([wall + sidex + pcbo / 2 + usbx, ty - wall - zf, usbzl])
      cube([usbsx, wall + 2 * zf, tz]);
  }
} else if (part == "l") {
  difference() {
    union() {
      translate([wall + pl / 2, wall + pl / 2, 0])
        rcube(tx - 2 * wall - pl, ty - 2 * wall - pl, fl, caser - wall - pl / 2);
      translate([tx - (wall + sidex + pcbo / 2 + usbx) - usbsx + pl / 2, ty - usbsy, 0])
        cube([usbsx - pl, usbsy, tz - usbzl - usbsz]);
    }
    translate([wall + nutod / 2, wall + nutod / 2, -zf])
      cylinder(d=scd, h=fl + 2 * zf);
    translate([tx - (wall + nutod / 2), wall + nutod / 2, -zf])
      cylinder(d=scd, h=fl + 2 * zf);
    translate([wall + nutod / 2, ty - (wall + nutod / 2), -zf])
      cylinder(d=scd, h=fl + 2 * zf);
    translate([tx - (wall + nutod / 2), ty - (wall + nutod / 2), -zf])
      cylinder(d=scd, h=fl + 2 * zf);
    translate([tx - (wall + sidex + pcbo / 2 + hox) - hsx, wall + pcbo / 2 + hoy, -zf])
      cube([hsx, hsy, fl + 2 * zf]);
  }
}
