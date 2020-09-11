classdef Wire < Mesh
    %A subclass of the Mesh superclass. Always generates a wire mesh of
    %10cm in length and 1mm in radius.
    properties
    end
    
    methods
        function obj = Wire(conductivity, z_contact)
            %constructor for the Wire class, initialises variables specific
            %to this mesh. 
            obj.EIDORS_FEM = make_wire(z_contact);
            obj.electrode_positions = obj.EIDORS_FEM.electrode_positions;
            obj.contact_impedance = z_contact;
            obj.centre = [0,0,0];
            obj.EIDORS_image = mk_image(obj.EIDORS_FEM, conductivity);
            obj.volumes = get_elem_volume(obj.EIDORS_FEM);
            obj.centres = find_element_centres(obj.EIDORS_FEM);
            obj.EIDORS_image.fwd_solve.get_all_meas = 1;
            obj.homogeneous_data = obj.EIDORS_image.elem_data;
        end
        
        %Assigns magnetic field sensors in a cylindrical configuration
        obj = assign_cylindrical_sensors(obj, distances, heights, points_on_circle)
        
        %shows information about the mesh
        show_mesh_info(obj);
    end
end

