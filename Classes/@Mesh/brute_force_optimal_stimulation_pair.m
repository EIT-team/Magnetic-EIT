%Finds the optimal stimulation pair with a brute force method, not
%recommended for use as the 'optimal_stimulation' method is faster. 
function obj = brute_force_optimal_stimulation_pair(obj,perturbation_number, amplitude, chunk, voltage_stim)
if nargin == 3
  chunk = 1;
  voltage_stim = false;
elseif nargin == 4
  voltage_stim = false;
end

    temp_img = obj.EIDORS_image;
    stim = all_combinations_stim(length(obj.EIDORS_FEM.electrode), amplitude);
    if voltage_stim ==true
        stim = current2voltage(stim, amplitude);
    end
    temp_img.fwd_model.stimulation = stim;
    obj.optimal_stimulation_data{perturbation_number} = brute_force_optimal_stimulation(temp_img,obj.centres,  obj.volumes, obj.magnetic_field_sensor_locations, obj.electrode_positions, obj.perturbation_indices, perturbation_number, obj.perturbation_conductivity_increase, obj.perturbation_location, obj.perturbation_radius, obj.centre, chunk);
end