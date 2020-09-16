%Solves the forward problem for the unperturbed case and the perturbed case
%and stores information about both cases.
%perturbation_number:
%A single scalar value to index the perturbation for which the forward
%problem should be solved.
%e.g.
%perturbation_number = 2;
function obj = electric_forward_solve(obj, perturbation_number)
if isempty(obj.unperturbed_voltages)
    obj.electric_forward_solve_data{perturbation_number}.unperturbed_voltages = fwd_solve(obj.EIDORS_image);
    obj.unperturbed_voltages = obj.electric_forward_solve_data{perturbation_number}.unperturbed_voltages;
else
    obj.electric_forward_solve_data{perturbation_number}.unperturbed_voltages = obj.unperturbed_voltages;
end
temp_img = obj.EIDORS_image;
temp_img.elem_data = obj.homogeneous_data;
temp_img.elem_data(obj.perturbation_indices{perturbation_number}) = (1 + obj.perturbation_conductivity_increase(perturbation_number))*temp_img.elem_data(obj.perturbation_indices{perturbation_number});
obj.electric_forward_solve_data{perturbation_number}.perturbed_voltages = fwd_solve(temp_img);
obj.electric_forward_solve_data{perturbation_number}.perturbation_number = perturbation_number;
end