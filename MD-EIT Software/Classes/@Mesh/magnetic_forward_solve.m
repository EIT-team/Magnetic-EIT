
function obj = magnetic_forward_solve(obj, perturbation_number, scalar_or_vector)
%Solves the forward solution for the unperturbed case and with a
%perturbation present. 
%perturbation_number:
%A single scalar number indexing the perturbation for which the magnetic
%forward solution should be found. 
%e.g. 
%perturbation_number = 2;
%scalar_or_vector:
%A string indicating whether the magnetic field should be ouput in scalar
%or vector format. 
%e.g.
%scalar_or_vector = 'scalar';
%or
%scalar_or_vector = 'vector';
%The default is for the vector form.
%
%If the vector form of the magnetic field is chosen then the data is stored
%in a 3 dimensional matrix, the first dimension represents the different
%mangetic field sensor locations, the second dimension represents the x,y
%and z components of the magnetic field and the third dimension represents
%the different stimulation pairs.
if nargin == 2
    scalar_or_vector = 'vector';
end

if isempty(obj.unperturbed_voltages)
    obj.magnetic_forward_solve_data{perturbation_number}.unperturbed_voltages = fwd_solve(obj.EIDORS_image);
    obj.unperturbed_voltages = obj.magnetic_forward_solve_data{perturbation_number}.unperturbed_voltages;
else
    obj.magnetic_forward_solve_data{perturbation_number}.unperturbed_voltages = obj.unperturbed_voltages;
end

if isempty(obj.unperturbed_magnetic_field)
    obj.magnetic_forward_solve_data{perturbation_number}.unperturbed_magnetic_field = magnetic_field(obj.EIDORS_image, obj.magnetic_forward_solve_data{perturbation_number}.unperturbed_voltages, obj.magnetic_field_sensor_locations, obj.volumes, obj.centres, 1, 'vector');
    obj.unperturbed_magnetic_field = obj.magnetic_forward_solve_data{perturbation_number}.unperturbed_magnetic_field;
else
    obj.magnetic_forward_solve_data{perturbation_number}.unperturbed_magnetic_field = obj.unperturbed_magnetic_field;
end

obj.magnetic_forward_solve_data{perturbation_number}.unperturbed_current_density = calc_tet_element_current_densities_range(obj.EIDORS_image, obj.magnetic_forward_solve_data{perturbation_number}.unperturbed_voltages, obj.volumes, [1,length(obj.EIDORS_FEM.stimulation)]);
temp_img = obj.EIDORS_image;
temp_img.elem_data = obj.homogeneous_data;
temp_img.elem_data(obj.perturbation_indices{perturbation_number}) = (1 + obj.perturbation_conductivity_increase(perturbation_number))*temp_img.elem_data(obj.perturbation_indices{perturbation_number});

obj.magnetic_forward_solve_data{perturbation_number}.perturbed_voltages = fwd_solve(temp_img);
obj.magnetic_forward_solve_data{perturbation_number}.perturbed_magnetic_field = magnetic_field(temp_img, obj.magnetic_forward_solve_data{perturbation_number}.perturbed_voltages, obj.magnetic_field_sensor_locations, obj.volumes, obj.centres, 1, 'vector');


obj.magnetic_forward_solve_data{perturbation_number}.change_in_magnetic_field = obj.magnetic_forward_solve_data{perturbation_number}.perturbed_magnetic_field - obj.magnetic_forward_solve_data{perturbation_number}.unperturbed_magnetic_field;
obj.magnetic_forward_solve_data{perturbation_number}.perturbed_current_density = calc_tet_element_current_densities_range(obj.EIDORS_image, obj.magnetic_forward_solve_data{perturbation_number}.perturbed_voltages, obj.volumes, [1,length(obj.EIDORS_FEM.stimulation)]);


if strcmp(scalar_or_vector, 'scalar')
    obj.magnetic_forward_solve_data{perturbation_number}.unperturbed_magnetic_field = squeeze(vecnorm(permute(obj.magnetic_forward_solve_data{perturbation_number}.unperturbed_magnetic_field,[2,1,3])));
    obj.magnetic_forward_solve_data{perturbation_number}.perturbed_magnetic_field = squeeze(vecnorm(permute(obj.magnetic_forward_solve_data{perturbation_number}.perturbed_magnetic_field,[2,1,3])));
    obj.magnetic_forward_solve_data{perturbation_number}.change_in_magnetic_field = squeeze(vecnorm(permute(obj.magnetic_forward_solve_data{perturbation_number}.change_in_magnetic_field,[2,1,3])));
end
obj.magnetic_forward_solve_data{perturbation_number}.perturbation_number = perturbation_number;
end

