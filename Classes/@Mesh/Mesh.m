
classdef Mesh
    %Superclass of specific FEM subclasses.
    %Each method has its own specific description, you can use 'help'
    %or 'doc' to learn more about each method or function.
    %This class contains the methods and properties which are general to
    %all FEM subclasses.
    
    %Properties available only to subclasses.
    properties (Access = protected)
       %EIDORS forward model FEM
       EIDORS_FEM;
       
       %EIDORS image
       EIDORS_image;
       
       %Matrix of electrode positions in coordinate format (x,y,z)
       electrode_positions;
       
       %Matrix of element volumes for each element in the FEM
       volumes;
       
       %Matrix of element centres in coordinate format (x,y,z)
       centres;
       
       %The contact impedance of the electrodes
       contact_impedance;
       
       %A structure with information about the stimulation pattern used to inject current or voltage.
       stimulation_pattern;
       
       %Lists of nodes contained within different perturbations, stored in a cell array.
       perturbation_indices;
       
       %A list of scalar numbers indicating the radius of each perturbation in metres.
       perturbation_radius;
       
       %A matrix of perturbation centres in coordinate format (x,y,z)
       perturbation_location;
       
       %A list of the percentage conductivity increase of each perturbation
       perturbation_conductivity_increase;
       
       %A list of the volume of each perturbation
       perturbation_volume;
       
       %A matrix of the locations of each magnetic field sensor in coordinate format (x,y,z)
       magnetic_field_sensor_locations;
       
       %stores the unperturbed conductivity distribution
       homogeneous_data;
       
       %The centre point of the mesh in coordinate format (x,y,z)
       centre;
       
       %Stores whether the standing field is in vector or scalar format
       standing_field_form;
       
       %Stores the unperturbed voltages for normal forward solve
       unperturbed_voltages;
       
       %Stores the unperturbed magnetic field for normal forward solve
       unperturbed_magnetic_field;
       
       %Stores unperturbed voltages for magnetic optimal stim 
       magnetic_optimal_unperturbed_voltages;
       
       %Stores unperturbed magnetic field for magnetic optimal stim
       magnetic_optimal_unperturbed_magnetic_field;
       
       %Stores unperturbed voltages for electric optimal stim
       electric_optimal_unperturbed_voltages;
    end
    
    %Public properties, storing data for analysis/observation.
    properties (Access = public)
        %Name of mesh
        mesh_name;
        
        %Data relating to a magnetic forward solution for a perturbed and unperturbed case
        magnetic_forward_solve_data = {};
        
        %Data relating to an electric forward solution for a perturbed and unperturbed case
        electric_forward_solve_data = {};
        
        %Data relating to the optimal forward solution for the magnetic case. 
        optimal_stimulation_data = {};
        
        %Data relating to the optimal forward solution for the electric case. 
        electric_optimal_stimulation_data = {};
        
        %Data about the standing magnetic field (magnetic field for the unperturbed mesh)
        standing_field_data;
        
        %Data about the voltage on current injection electrodes
        voltages_on_injection_electrodes;
    end
    
    %Constant values.
    properties (Access = protected)
        %The area of each electrode.
        electrode_area = pi*0.005^2;
        
        %magnetic vacuum permeability
        mu0 = 1.25663706212e-6;
    end
    
    %Methods applicable for all subclasses.
    methods
        %Methods for all meshes, organised into categories.
        function obj = Mesh()
            %constructor for Mesh, initialises variables common to all
            %subclasses
            obj.perturbation_radius = [];
            obj.perturbation_location = [];
            obj.perturbation_indices = {};
            obj.perturbation_volume = [];     
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%Assigning/Deleting/Changing Variables
        
        %Assigns a stimulation pattern
        obj = assign_stimulation_pattern(obj, new_stim_pattern)
        
        %Saves a perturbation which can be used for forward solutions
        obj = insert_perturbation(obj,radius, offset, percentage_increase, only_include_grey_white_matter)
        
        %Removes a saved perturbation
        obj = remove_perturbation(obj, perturbation_number)
        
       %Places a magnetic field sensor over each electrode
        obj = magnetic_field_sensors_over_electrodes(obj, distance)
        
        %Sets homogeneous conductivity
        obj = homogeneous_conductivity(obj, conductivity)
        
        %Overwrite the conductivity distribution
        obj = new_conductivity_distribution(obj, conductivities)
        
        %Assigns custom magnetic field sensor locations.
        assign_custom_magnetic_field_sensor_locations(obj, locations)
                
        %Adds a circular ring of magnetic field sensors
        obj = ring_of_sensors(obj, radii, number_of_sensors_per_ring, z_planes)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%Showing Images
 
        %Displays the mesh
        show_mesh(obj, show_conductivity);
        
        %Displays the mesh with the selected perturbation highlighted
        show_mesh_perturbation(obj, perturbation_number)
        
        %Displays the injection electrodes and magnetic field sensor associated with the optimal stimulation setup for the magnetic case.
        show_optimal_stim(obj, perturbation_number)
        
        %Displays the injection electrodes associated with the optimal stimulation setup for the electric case.
        show_optimal_electric_stim(obj, perturbation_number)
        
        %Shows the mesh with magnetic field sensors
        show_mesh_with_sensors(obj, size_of_sensors);
        
        %Displays the standing field at every magnetic field sensor location as a vector arrow.
        show_standing_field(obj, stimulation_number, arrow_size);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%Solving Forward Problems
        %Completes an electric forward solver for the perturbed and unperturbed case for the selected perturbation  
        obj = electric_forward_solve(obj, perturbation_number)
        
        %Completes a magnetic forward solver for the perturbed and unperturbed case for the selected perturbation
        obj = magnetic_forward_solve(obj, perturbation_number, scalar_or_vector)  
        
        %Solves the magnetic forward problem for the optimal stimulation pair and the optimal stimulation signal.
        obj = optimal_stimulation_pair(obj,perturbation_number, amplitude, chunk, voltage_stim)
        
        %Solves the magnetic forward problem for the optimal stimulation pair and the optimal stimulation signal using a brute force method.
        obj = brute_force_optimal_stimulation_pair(obj,perturbation_number, amplitude, chunk, voltage_stim);
        
        %Solves the electric forward problem for the optimal stimulation pair and the optimal stimulation signal using a brute force method.
        obj = electric_optimal_stimulation_pair(obj,perturbation_number, amplitude, voltage_stim);
        
        %Solves the forward problem for the unperturbed case to find the
        %standing magnetic field. 
        obj = standing_field(obj, scalar_or_vector)
        
        %Obtains voltage on injection electrodes for all stimulations
        obj = voltage_on_injection_electrodes(obj)
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%Showing Tables
        
        %Displays a table with information about all the different perturbations that have been inserted.
        display_perturbations(obj);
        
        %Shows information about the conductivity distribution
        show_conductivity_info(obj)
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%Extracting data
        
        %Retrieves the EIDORS image for use with EIDORS software traditionally
        img = get_eidors_image(obj)
        
        %Retrieves the element centres matrix
        centres = get_element_centres(obj)



    end
end

