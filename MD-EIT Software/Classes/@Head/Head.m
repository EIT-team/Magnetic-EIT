classdef Head < Mesh
    %A subclass of the Mesh superclass. This class is for head shaped
    %meshes. 
    properties
        
    end
    
    methods
        function obj = Head(z_contact)
            %Constructor for the head mesh, initialises variables specific
            %to this mesh.
            obj.EIDORS_FEM = make_head_Mesh01000(z_contact);
            obj.electrode_positions = obj.EIDORS_FEM.electrode_positions;
            obj.contact_impedance = z_contact;
            obj.centre = obj.EIDORS_FEM.middle;
            obj.EIDORS_image = mk_image(obj.EIDORS_FEM, 0.3);
            obj.volumes = get_elem_volume(obj.EIDORS_FEM);
            obj.centres = find_element_centres(obj.EIDORS_FEM);
            obj.EIDORS_image.elem_data = obj.EIDORS_FEM.conductivities;
            obj.EIDORS_image.fwd_solve.get_all_meas = 1;
            obj.homogeneous_data = obj.EIDORS_image.elem_data;
        end
       
        %assigns evenly spaced magnetic field sensors above the mesh.
        obj = fibonacci_head_sensors(obj, number_of_sensors, distance_from_scalp)
        
        %shows information about the mesh
        show_mesh_info(obj);
        
    end
   
end

