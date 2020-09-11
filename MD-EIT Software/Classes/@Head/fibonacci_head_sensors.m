%Assigns evenly spaced magnetic field sensors a set radial distance above
%the top hemisphere of the head mesh. 
%number_of_sensors:
%A single scalar value indicating the desired number of magnetic field
%sensors.
%e.g.
%number_of_sensors = 25;
%distance_from_scalp:
%A single scalar value indicating the radial distance between the mesh and
%the magetic field sensors in metres.
%e.g.
%distance_from_scalp = 0.01;
%for a 1cm distance.
function obj = fibonacci_head_sensors(obj, number_of_sensors, distance_from_scalp)
img = obj.EIDORS_image;
obj.magnetic_field_sensor_locations = fibonacci_head_sensors(img, number_of_sensors, distance_from_scalp);
end