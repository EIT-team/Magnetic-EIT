%Overwrites the default conductivity distribution (which is a 4 shell model
%of the human head) with a custom conductivity distribution.
%conductivities:
%An Nx1 list containing the conductivity of each element of the mesh in
%Sm^(-1) where N = number of elements in the mesh.
function obj = new_conductivity_distribution(obj, conductivities)
obj.EIDORS_image.elem_data = conductivities;
end

