classdef Sphere < Mesh
    %A subclass of the mesh superclass. This always generates a spherical
    %mesh of 0.1m radius.
    properties
        
    end
    
    methods
        function obj = Sphere(z_contact, max_size_of_elements)
            %Constructor for the Sphere class, initialises variables
            %specific to this mesh.
            %z_contact:
            %A single scalar value indicating the contact impedance for all
            %electrodes in ohms.
            %e.g.
            %z_contact = 1000;
            %max_size_of_elements:
            %(Optional) A single scalar value indicating the maximum size of an
            %element in metres.
            %e.g. max_size_of_elements = 0.009;
            if nargin == 1
                max_size_of_elements = 0.1;
            end
            obj.mesh_name = 'Sphere';
            obj.EIDORS_FEM = make_sphere(max_size_of_elements);
            electrode_positions = EEG_10_20_sphere_positions(0.1);
            obj.electrode_positions = electrode_positions(:,1:3);
            obj.contact_impedance = z_contact;
            obj.centre = [0,0,0];
            for ii = 1:length(obj.electrode_positions)
                obj.EIDORS_FEM.electrode(ii).z_contact = z_contact*obj.electrode_area;
            end
            obj.EIDORS_image = mk_image(obj.EIDORS_FEM,0.3);
            obj.volumes = get_elem_volume(obj.EIDORS_FEM);
            obj.centres = find_element_centres(obj.EIDORS_FEM);
            obj.EIDORS_image = sphere_conductivity(obj.EIDORS_image, obj.centres);
            obj.EIDORS_image.fwd_solve.get_all_meas = 1;
            obj.homogeneous_data = obj.EIDORS_image.elem_data;
        end
        
        %Generates evenly spaced magnetic field sensors above the top
        %hemisphere of the 
        obj = fibonacci_hemisphere_magnetic_field_sensors(obj, number_of_sensors, radius);
        
        %Displays information about the spherical mesh
        show_mesh_info(obj);
 
    end
end

