%Displays a table with information about the perturbations stored for the
%mesh.
function display_perturbations(obj)
    for i = 1:length(obj.perturbation_indices)
        Perturbation_number(i,:) = i; 
        Number_of_elements(i,:) = length(obj.perturbation_indices{i});
    end
    Location = obj.perturbation_location;
    Radius = obj.perturbation_radius;
    Conductivity_Increase_Percentage = obj.perturbation_conductivity_increase*100;
    Volume = obj.perturbation_volume;
    perturbations = table(Perturbation_number, Location, Radius, Conductivity_Increase_Percentage, Volume, Number_of_elements);
    disp(perturbations);
end