 function show_mesh_perturbation(obj, perturbation_number)
 %Shows the mesh with a perturbation. 
 %perturbation_number:
 %Indexes the perturbation that is to be shown. 
if isempty(obj.perturbation_indices)
    error('There is no perturbation');
end
    temp_img = obj.EIDORS_image;
    temp_img.elem_data = zeros(length(temp_img.elem_data),1);
    temp_img.elem_data(obj.perturbation_indices{perturbation_number}) = temp_img.elem_data(obj.perturbation_indices{perturbation_number})+1;
    show_fem(temp_img);
 end