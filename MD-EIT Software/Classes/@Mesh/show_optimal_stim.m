
function show_optimal_stim(obj, perturbation_number)
%Shows the mesh with the optimal stimulation electrodes and magnetic field
%sensor. 

%perturbation_number:
%This number indexes the perturbation for which the optimal stimulation is
%to be shown.

    if isempty(obj.optimal_stimulation_data)
        error('Please run the function "optimal_stimulation_pair" for this perturbation first to find the optimal stimulation pair to show');
    end
    
    plot3(obj.optimal_stimulation_data{perturbation_number}.electrode_positions(:,1), obj.optimal_stimulation_data{perturbation_number}.electrode_positions(:,2), obj.optimal_stimulation_data{perturbation_number}.electrode_positions(:,3), 'b.', "MarkerSize", 60);
    hold on
    show_mesh_perturbation(obj, perturbation_number);
    plot3(obj.optimal_stimulation_data{perturbation_number}.sensor_location(:,1), obj.optimal_stimulation_data{perturbation_number}.sensor_location(:,2), obj.optimal_stimulation_data{perturbation_number}.sensor_location(:,3), 'r.', "MarkerSize", 60);
    hold off
end