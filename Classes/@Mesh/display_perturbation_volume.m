function display_perturbation_volume(obj, perturbation_number)
    pert_vol = obj.volumes(obj.perturbation_indices{perturbation_number});
    disp(pert_vol);
end