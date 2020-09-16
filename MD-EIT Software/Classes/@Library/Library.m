classdef Library < Mesh
    %A subclass of the Mesh superclass. Used for dealing with pre-defined
    %FEMs from EIDORS using the mk_library_model function. For detailed
    %information read the 'Pre-packaged models' tutorial on the EIDORS
    %website: http://eidors3d.sourceforge.net/tutorial/netgen/mk_library_model.shtml
    %and the documentation for the mk_library_model function.
    properties(Access = protected)
        electrode_radius;
    end
    
    methods
        function obj = Library(mesh_name, z_contact)
        %constructor for Library class which loads predefined meshes from
        %the EIDORS library and initialises properties.
        %mesh_name:
        %A string value indicating the mesh that should be loaded.
        %e.g.
        %mesh_name = 'adult_male_16el';
        %z_contact:
        %A single scalar value indicating the contact impedance in ohms for all
        %electrodes.
        %e.g.
        %z_contact = 1000;
        obj.EIDORS_FEM = mk_library_model(mesh_name);
        centre_height = mean([max(obj.EIDORS_FEM.nodes(:,3)), min(obj.EIDORS_FEM.nodes(:,3))]);
        obj.EIDORS_FEM.nodes = obj.EIDORS_FEM.nodes - [0,0,centre_height];
        for i = 1:length(obj.EIDORS_FEM.electrode)
             electrode_nodes = obj.EIDORS_FEM.nodes(obj.EIDORS_FEM.electrode(i).nodes,:);
             radii(i) = max(electrode_nodes(:,3)) - mean(electrode_nodes(:,3));
        end
        radius = mean(radii);
        obj.electrode_radius = radius;
        obj.electrode_area = pi*radius^2;
        for i = 1:length(obj.EIDORS_FEM.electrode)
          obj.EIDORS_FEM.electrode(i).z_contact = obj.electrode_area*z_contact;
        end
        obj.contact_impedance = z_contact;
        obj.mesh_name = mesh_name;
        obj.centre = [0,0,0];
        obj.EIDORS_image = mk_image(obj.EIDORS_FEM, 1);
        obj.volumes = get_elem_volume(obj.EIDORS_FEM);
        obj.centres = find_element_centres(obj.EIDORS_FEM);
        obj.EIDORS_image.fwd_solve.get_all_meas = 1;
        obj.homogeneous_data = obj.EIDORS_image.elem_data;
        end
        
        %shows information about the mesh
        show_mesh_info(obj)
    end
    methods (Static)
        %displays all the different pre-packaged models available.
        display_pre_packaged_models();
    end
end

