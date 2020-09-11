%Places a magnetic field sensor over each electrode.
%distance:
%A single scalar value indicating the radial distance in metres between each electrode and its respective magnetic
%field sensor.
%e.g.
%distance = 0.01;
function obj = magnetic_field_sensors_over_electrodes(obj, distance)
    obj.magnetic_field_sensor_locations = sensors_over_electrodes(distance, obj.electrode_positions, mean(obj.centres));
end
