%Places magnetic field sensors at evenly spaced locations on the surface of
%a hemisphere. 
%number_of_sensors:
%A single scalar value indicating the number of desired magnetic field sensors on the surface of the
%hemisphere.
%e.g.
%number_of_sensors = 10;
%radius:
%A single scalar value indicating the radius in metres from the centre of the mesh under consideration at which the
%magnetic field sensors are placed.
%e.g.
%radius = 0.01;
function obj = fibonacci_hemisphere_magnetic_field_sensors(obj, number_of_sensors, radius)
            obj.magnetic_field_sensor_locations = fibonacci_hemisphere(number_of_sensors, radius, [0,0,0]);
end