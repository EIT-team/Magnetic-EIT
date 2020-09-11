function show_optimal_electric_stim(obj, perturbation_number)
%Shows the mesh with the optimal stimulation electrodes. 
%perturbation_number:
%This number indexes the perturbation for which the optimal stimulation is
%to be shown.

    if isempty(obj.electric_optimal_stimulation_data)
        error('Please run the function "optimal_stimulation_pair" for this perturbation first to find the optimal stimulation pair to show');
    end
    
    plot3(obj.electric_optimal_stimulation_data{perturbation_number}.electrode_positions(:,1), obj.electric_optimal_stimulation_data{perturbation_number}.electrode_positions(:,2), obj.electric_optimal_stimulation_data{perturbation_number}.electrode_positions(:,3), 'b.', "MarkerSize", 60);
    hold on
    show_mesh_perturbation(obj, perturbation_number);
    hold off
end