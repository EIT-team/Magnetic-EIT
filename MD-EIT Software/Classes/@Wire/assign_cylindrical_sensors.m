%Assigns a number of magnetic field sensors which will be generated in a
%cylindrical shape starting from the bottom of the wire and working towards the top. 
%distances:
%A single scalar number indicating the number of different radial distances at which sensors will be placed. 
%e.g.
%distances = 5;
%heights:
%A single scalar number indicating the number of heights along the wire at
%which sensors will be placed, this starts from the bottom of the wire and
%builds upwards.
%e.g.
%heights = 10;
%points on circle:
%A single scalar number indicating the number of sensors on each circle
%surrounding the wire.
%e.g.
%points_on_circle = 20;
%The total number of sensors is = distances*heights*points_on_circle
function obj = assign_cylindrical_sensors(obj, distances, heights, points_on_circle)
obj.magnetic_field_sensor_locations = cylindrical_sensors(distances, heights, points_on_circle);
end
        
