function obj =insert_cylindrical_perturbation(obj,radius, offset, percentage_increase, only_include_grey_white_matter)
pert_idx = find_cylindrical_perturbation_indices(obj.centres, radius, obj.centre + offset);
if only_include_grey_white_matter == true
    pert_idx = remove_non_grey_and_white_matter_data(pert_idx, obj.EIDORS_image);
end

if isempty(pert_idx{1})
    error('This perturbation includes no nodes.');
end
obj.perturbation_indices = [obj.perturbation_indices, pert_idx];
obj.perturbation_location = [obj.perturbation_location ; obj.centre + offset];
obj.perturbation_radius = [obj.perturbation_radius; radius];
obj.perturbation_conductivity_increase = [obj.perturbation_conductivity_increase ; percentage_increase/100]; 
obj.perturbation_volume = [obj.perturbation_volume ; sum(obj.volumes(obj.perturbation_indices{end}))];
end

