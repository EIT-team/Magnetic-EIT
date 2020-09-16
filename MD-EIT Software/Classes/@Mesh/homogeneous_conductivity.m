function obj = homogeneous_conductivity(obj, conductivity)
%Sets all elements to the same conductivity.
%conductivity:
%A single scalar value indicating the conductivity of all elements in Sm^(-1).
%e.g.
%conductivity = 1;
for i = 1:length(obj.EIDORS_image.elem_data)
    obj.EIDORS_image.elem_data(i) = conductivity;
end
obj.homogeneous_data = obj.EIDORS_image.elem_data;
end

