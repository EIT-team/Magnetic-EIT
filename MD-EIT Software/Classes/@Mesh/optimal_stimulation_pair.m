%Finds the magnetic optimal stimulation and stores information about this
%including the optimal stimulation amplitude and the optimal electrodes and
%magnetic field sensors.
%amplitude:
%The desired stimulation amplitude either in Amps or Volts depending on
%whether it is constant current or constant voltage stimulation. 
%e.g.
%amplitude = 1e-3;
%chunk:
%This is the number of loop iterations that the magnetic field calculation
%should be broken down into in order not to exceed the total RAM. The lower
%this number the faster the code will run so this should be set to 1 if
%possible. This number must be a factor of the number of stimulation pairs.
%e.g. if the number of stimulation pairs = 32:
%chunk = 1,2,4,8,16 or 32.
%voltage_sitm:
%Determines whether the stimulation is constant current or constant
%voltage.
%e.g.
%voltage_stim = 'true';
%for voltage stimulation.
%voltage_stim = 'false';
%for current stim.

function obj = optimal_stimulation_pair(obj,perturbation_number, amplitude, chunk, voltage_stim)

if nargin == 3
    chunk = 1;
    voltage_stim = false;
elseif nargin == 4
    voltage_stim = false;
end

temp_img = obj.EIDORS_image;
stim = mk_stim_patterns(length(obj.EIDORS_FEM.electrode), 1, [0,1],[0,1],{}, amplitude);
stim = stim(1:end-1);
if voltage_stim ==true
    stim = current2voltage(stim, amplitude);
end
temp_img.fwd_model.stimulation = stim;
obj.optimal_stimulation_data{perturbation_number} = optimal_stimulation(temp_img,obj.centres,  obj.volumes, obj.magnetic_field_sensor_locations, obj.electrode_positions, obj.perturbation_indices, perturbation_number, obj.perturbation_conductivity_increase, obj.perturbation_location, obj.perturbation_radius, obj.centre, chunk);
end