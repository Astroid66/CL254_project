SetFactory("OpenCASCADE");

Hi=0.2;
Ho=0.4;
L0=0.1;
L=0.4;
NH=20;
NL=50;
NL0=NL/L*L0;

Point(1) = {0, -Hi/2, 0, 1.0};
Point(2) = {L0, -Hi/2, 0, 1.0};
Point(3) = {L0+L, -Ho/2, 0, 1.0};
Point(4) = {2*L0+L, -Ho/2, 0, 1.0};
Point(5) = {2*L0+L, Ho/2, 0, 1.0};
Point(6) = {L0+L, Ho/2, 0, 1.0};
Point(7) = {L0, Hi/2, 0, 1.0};
Point(8) = {0, Hi/2, 0, 1.0};

Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 5};
Line(5) = {5, 6};
Line(6) = {6, 7};
Line(7) = {7, 8};
Line(8) = {8, 1};
Line(9) = {7, 2};
Line(10) = {6, 3};
Curve Loop(1) = {8, 1, -9, 7};
Plane Surface(1) = {1};
Curve Loop(2) = {9, 2, -10, 6};
Plane Surface(2) = {2};
Curve Loop(3) = {5, 10, 3, 4};
Plane Surface(3) = {3};

Transfinite Curve {8, 9, 10, 4} = NH Using Progression 1;
Transfinite Curve {6, 2} = NL Using Progression 1;
Transfinite Curve {7, 1, 5, 3} = NL0 Using Progression 1;
Transfinite Surface {1};
Transfinite Surface {2};
Transfinite Surface {3};
Recombine Surface {1, 2, 3};

Extrude {0, 0, 0.2} {
  Surface{1}; Surface{2}; Surface{3}; Layers{5}; Recombine;
}

Physical Surface("fixedwall", 29) = {7, 11, 13, 5, 9, 14};
Physical Surface("inlet", 30) = {4};
Physical Surface("outlet", 31) = {15};
Physical Surface("empty", 32) = {1, 2, 3, 8, 12, 16};
Physical Volume("volume", 33) = {1, 2, 3};
