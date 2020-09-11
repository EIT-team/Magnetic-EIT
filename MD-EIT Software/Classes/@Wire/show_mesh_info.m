%Displays information about the spherical mesh.
function show_mesh_info(obj)
Mesh_Type = {'Wire'};
Length = 0.1;
Radius = 0.0005;
Number_of_Elements = length(obj.EIDORS_FEM.elems);
Number_of_Nodes = length(obj.EIDORS_FEM.nodes);
Number_of_Electrodes = length(obj.EIDORS_FEM.electrode);
Contact_Impedance = obj.contact_impedance;
info = table(Mesh_Type,Length, Radius, Number_of_Elements, Number_of_Nodes, Number_of_Electrodes, Contact_Impedance);
disp(info);
end

