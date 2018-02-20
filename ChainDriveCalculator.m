%% Chain Drive calculator
%Input initial parameters and run code to retrieve design specs

clc
clear all
close all

%Premilinary chain decisions
pitch = 5/8; %chain pitch determined by chain size selection
CDclearance = 2; %additional CD clearance above minimum in inches

%Static Parameters (Emrax 228 and Vehicle Specs)
at = 3; %0-60 mph acceleration in seconds
tqm = 177.015; %motor torque in lb-ft
w = 771.62; %vehicle weight in lbs
dw = 21; %tire diameter in inches
pinT = 14 %minimum teeth on pinion (determined by desired angle of wrap)


%Gear ratio calculation
a = 60/at*1.487; %acceleration in ft/s^2
f = w/32.2*a; %force to accelerate
tqw = dw/2/12*f; %torque at rear wheel

GR = round(tqw/tqm, 1, 'decimals'); %gear ratio required
gearT = round(GR*pinT)
GR = gearT/pinT

%Center distance and chain length
PD1 = pitch/sind(180/pinT);
PD2 = pitch/sind(180/gearT);
CDmin = (PD2-PD1)/(2*sind(30)) %minimum CD in inches for 120deg angleofwrap
CDdes = CDmin + CDclearance; %add 2 inch to minimum for clearance? just a suggestion
CDpit = CDdes/pitch; %convert CD to unit of pitches
Lc = 2*CDpit + (gearT + pinT)/2 + (gearT - pinT)^2/(4*pi^2*CDpit);
Lc = round((Lc-2)/2)*2+2 %Lenth of chain in # of pitches (# of links)
CDpitf = (1/4)*(Lc - (gearT + pinT)/2 + sqrt((Lc-(gearT+pinT)/2)^2 - (8*(gearT-pinT)^2)/(4*pi^2)));
CDf = CDpitf * pitch %CD final in inches

