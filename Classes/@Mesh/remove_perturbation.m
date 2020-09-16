function obj = remove_perturbation(obj, perturbation_number)
%removes one of the inserted perturbations.
%perturbation_number:
%indexes the perturbation that is to be removed.
obj.perturbation_indices(perturbation_number) = [];
obj.perturbation_location(perturbation_number,:) = [];
obj.perturbation_radius(perturbation_number,:) = [];
obj.perturbation_conductivity_increase(perturbation_number,:) = [];
obj.perturbation_volume(perturbation_number, :) = [];
end