%Displays the mesh with the magnetic field sensors represented as spheres.
%Must have magnetic sensors saved to the mesh.
function show_mesh_with_sensors(obj, size_of_sensors)
if nargin == 1
    size_of_sensors = 20;
end
if isempty(obj.magnetic_field_sensor_locations)
    error('There are no magnetic field sensors to display, please assign the magnetic field sensor locations.');
end
loc = obj.magnetic_field_sensor_locations;
plot3(loc(:,1), loc(:,2), loc(:,3), '.', "MarkerSize", size_of_sensors);
hold on 
show_fem(obj.EIDORS_FEM)
hold off
end
