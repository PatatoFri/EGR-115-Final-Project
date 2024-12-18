function [distance] = programmerdefinedfunction(lattitude1,longitude1,lattitude2,longitude2)

phi1 = deg2rad(single(lattitude1));

phi2 = deg2rad(single(lattitude2));
lambda1 = deg2rad(single(longitude1));
lambda2 = deg2rad(single(longitude2));

%compute distance
dlat = phi2 - phi1;
%disp(dlat)
dlon = lambda2 - lambda1;
%disp(dlon)
    a = sin(dlat/2).^2 + cos(phi1).*cos(phi2).*sin(dlon/2).^2;
idontknowwhatsgoingon = 2 * atan2(sqrt(a), sqrt(1-a));
R = 3959; %Radius of Earth in mi
%disp(R)
%disp(idontknowwhatsgoingon)
distance = R * idontknowwhatsgoingon;
%disp(idontknowwhatsgoingon)
%disp(distance)

%{
Kyle Kirchoff
Kirchok1@my.erau.edu
4/18/2023
This function calculates distance in miles between two sets of cordinates
%}