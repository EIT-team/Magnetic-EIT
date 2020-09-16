function obj = ring_of_sensors(obj, radius, number_of_sensors_per_ring, z_planes)

theta = (2*pi)/number_of_sensors_per_ring;
sensors = [];

for j = 1:length(z_planes)
    temp_sensors = zeros(number_of_sensors_per_ring, 3);
    for i = 1:number_of_sensors_per_ring
        temp_sensors(i,:) = [radius*cos(theta*i), radius*sin(theta*i), z_planes(j)];
    end
    sensors = [sensors ; temp_sensors];
end

obj.magnetic_field_sensor_locations = sensors;

end

