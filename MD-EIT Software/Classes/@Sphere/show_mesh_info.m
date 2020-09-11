%Displays information about the spherical mesh.
function show_mesh_info(obj)
Mesh_Type = {'Sphere'};
Number_of_Elements = length(obj.EIDORS_FEM.elems);
Number_of_Nodes = length(obj.EIDORS_FEM.nodes);
Number_of_Electrodes = length(obj.EIDORS_FEM.electrode);
Contact_Impedance = obj.contact_impedance;
Radius = 0.1;
info = table(Mesh_Type, Radius, Number_of_Elements, Number_of_Nodes, Number_of_Electrodes, Contact_Impedance);
disp(info);
end

