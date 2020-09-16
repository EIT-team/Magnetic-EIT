%Shows unique mesh conductivity values and the number of elements that have
%that conductivity.
function show_conductivity_info(obj)
Conductivity_Value = unique(obj.EIDORS_image.elem_data);
for i = 1:length(Conductivity_Value)
    Number_of_Elements(i,:) = sum(obj.EIDORS_image.elem_data(:) == Conductivity_Value(i));
end
cond_info = table(Conductivity_Value, Number_of_Elements);
disp(cond_info);
end

