function show_mesh(obj, show_conductivity)
%shows the mesh.
%show_conductivity:
%A boolean to determine whether the conductivity distribution should be
%shown by colouring the different elements of the mesh or whether only the
%structure of the mesh should be shown.
%e.g.
%show_conductivity = true;
%or 
%show_conductivity = false;
if nargin == 1
    show_conductivity = false;
end

if show_conductivity == false
    show_fem(obj.EIDORS_FEM);
elseif show_conductivity == true
    show_fem(obj.EIDORS_image);
else
    error('Please enter either the boolean "true" or "false" for the variable "show_conductivity"');
end
end