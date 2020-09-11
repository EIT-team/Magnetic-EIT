%Assigns custom magnetic field sensor locations.
%locations:
%An Mx3 matrix of locations in coordinate format (x,y,z) where M = number
%of magnetic field sensors.
%e.g.
%locations = [0,1,2 ; 0.4,0.6,7 ; 7,1,2];
function obj = assign_custom_magnetic_field_sensor_locations(obj, locations)
    obj.magnetic_field_sensor_locations = locations;
end

