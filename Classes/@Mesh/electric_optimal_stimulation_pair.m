%Finds the electric optimal stimulation and stores information about this
%including the optimal stimulation amplitude and the optimal stimulation electrodes
%amplitude:
%The desired stimulation amplitude either in Amps or Volts depending on
%whether it is constant current or constant voltage stimulation. 
%e.g.
%amplitude = 1e-3;
%voltage_sitm:
%Determines whether the stimulation is constant current or constant
%voltage.
%e.g.
%voltage_stim = 'true';
%for voltage stimulation.
%voltage_stim = 'false';
%for current stim.
function obj = electric_optimal_stimulation_pair(obj,perturbation_number, amplitude, voltage_stim)
if nargin == 3
    voltage_stim = false;
end

temp_img = obj.EIDORS_image;
stim = all_combinations_stim(length(temp_img.fwd_model.electrode), amplitude);
if voltage_stim ==true
    stim = current2voltage(stim, amplitude);
end
temp_img.fwd_model.stimulation = stim;
obj.electric_optimal_stimulation_data{perturbation_number} = electric_optimal_stimulation(temp_img,  obj.volumes, obj.electrode_positions, obj.perturbation_indices, perturbation_number, obj.perturbation_conductivity_increase, obj.perturbation_location, obj.perturbation_radius, obj.centre, obj.electric_optimal_unperturbed_voltages);

if isempty(obj.electric_optimal_unperturbed_voltages)
    idx = find(~cellfun('isempty', obj.electric_optimal_stimulation_data));
    obj.electric_optimal_unperturbed_voltages = obj.electric_optimal_stimulation_data{idx(1)}.raw_data.unperturbed_voltages;
end

end

