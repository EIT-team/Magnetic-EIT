%Obtains the voltage on current injection electrodes for all stimulations.
function obj = voltage_on_injection_electrodes(obj)
    stim = obj.stimulation_pattern;
    for i = 1:length(stim)
        stim(i).meas_pattern = speye(length(obj.EIDORS_image.fwd_model.electrode));
    end
    img = obj.EIDORS_image;
    img.fwd_model.stimulation = stim;
    vh = fwd_solve(img);
    obj.voltages_on_injection_electrodes = voltage_on_current_injecting_electrodes(vh, stim);
end

