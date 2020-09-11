%Displays the mesh with the magnetic field sensors represented as spheres.
%Must have magnetic sensors saved to the mesh.
function show_mesh_with_sensors(obj)
if isempty(obj.magnetic_field_sensor_locations)
    error('There are no magnetic field sensors to display, please assign the magnetic field sensor locations.');
end
show_fem(obj.EIDORS_FEM)
loc = obj.magnetic_field_sensor_locations;
hold on 
plot3(loc(:,1), loc(:,2), loc(:,3), '.', "MarkerSize", 20);
hold off
end
