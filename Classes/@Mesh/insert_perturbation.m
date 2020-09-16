%Stores a spherical perturbation of determined size and offset for the mesh. 
%radius:
%A single scalar value indicating the radius of the perturbation.
%e.g.
%radius = 0.01;
%offset:
%A 1x3 matrix indicating the offset from the centre of the mesh.
%e.g.
%offset = [0.01,0.02,0];
%percentage_increase:
%The percentage increase in conductivity (in percent) that the perturbation
%should have.
%e.g.
%percentage_increase = 5;
%for a 5% increase.
%only_include_grey_white_matter:
%A boolean to indicate whether all non grey or white matter elements should
%be excluded from the perturbation, if so set to true.
%e.g.
%only_include_grey_white_matter = true;
%to exclude non grey or white matter elements from the perturbation
%or
%only_include_grey_white_matter = false;
%to keep non grey and white matter.

function obj = insert_perturbation(obj,radius, offset, percentage_increase, only_include_grey_white_matter)
pert_idx = find_perturbation_indices(obj.centres, 1, radius, obj.centre + offset);

if only_include_grey_white_matter == true
    pert_idx = remove_non_grey_and_white_matter_data(pert_idx, obj.EIDORS_image);
end
if isempty(pert_idx{1})
    error('This perturbation includes no nodes.');
end
% for i = 1:length(obj.perturbation_indices)
%     if size(pert_idx{1}) == size(obj.perturbation_indices{i})
%         if pert_idx{1} == obj.perturbation_indices{i}
%             error('This perturbation already exists.');
%         end
%     end
% end
obj.perturbation_indices = [obj.perturbation_indices, pert_idx];
obj.perturbation_location = [obj.perturbation_location ; obj.centre + offset];
obj.perturbation_radius = [obj.perturbation_radius; radius];
obj.perturbation_conductivity_increase = [obj.perturbation_conductivity_increase ; percentage_increase/100]; 
obj.perturbation_volume = [obj.perturbation_volume ; sum(obj.volumes(obj.perturbation_indices{end}))];
end