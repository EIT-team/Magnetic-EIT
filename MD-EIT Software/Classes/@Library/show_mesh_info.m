%Displays information about the spherical mesh.
function show_mesh_info(obj)
Mesh_Type = {strcat('Cylinder', obj.mesh_name)};
Number_of_Elements = length(obj.EIDORS_FEM.elems);
Number_of_Nodes = length(obj.EIDORS_FEM.nodes);
Number_of_Electrodes = length(obj.EIDORS_FEM.electrode);
Electrode_Radius = obj.electrode_radius;
Contact_Impedance = obj.contact_impedance;
info = table(Mesh_Type, Electrode_Radius,  Number_of_Elements, Number_of_Nodes, Number_of_Electrodes, Contact_Impedance);
disp(info);
end

