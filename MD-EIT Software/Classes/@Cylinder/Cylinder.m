classdef Cylinder < Mesh
    %A subclass of the Mesh superclass dealing with cylindrical FEMs. Uses
    %the ng_mk_cyl_models function, see specific documentation for that
    %function for a more detailed explanation.
    
    properties(Access = protected)
        %height of cylinder
        height;
        
        %radius of cylinder
        radius;
        
        %radius of electrodes on cylinder
        electrode_radius;
        
    end
    
    methods
        function obj = Cylinder(height,radius, number_of_elecs_per_plane,z_planes, electrode_radius, z_contact, max_size_of_mesh_elems)
            %Constructor for cylindrical mesh, initialises variables
            %specific to this mesh.
            %height:
            %A single scalar value indicating the height of the cylinder in
            %metres
            %e.g.
            %height = 1;
            %radius:
            %A single scalar value indicating the radius of the cylinder in
            %metres
            %e.g.
            %radius = 0.5;
            %number_of_elecs_per_plane:
            %A single scalar value indicating the number of electrodes per
            %plane of electrodes (arranged in a ring)
            %z_planes:
            %A vector indicating the point on the z-axis at which the
            %planes should lie.
            %e.g.
            %z_planes = [0,0.5,1,1.5];
            %electrode_radius:
            %A single scalar value indicating the radius of each electrode
            %in metres
            %z_contact:
            %A single scalar value indicating the contact impedance for all
            %electrodes in ohms.
            obj.mesh_name = 'Cylinder';
            centre_height = height/2;
            z_planes = z_planes + height/2;
            obj.electrode_area = (electrode_radius^2)*pi;
            if nargin == 6
                max_size_of_mesh_elems = 1;
            end
            obj.height = height;
            obj.radius = radius;
            obj.electrode_radius = electrode_radius;
            shape = [height, radius, max_size_of_mesh_elems];
            electrode_positions = [number_of_elecs_per_plane, z_planes];
            electrode_shape = [electrode_radius, 0];
            obj.EIDORS_FEM = ng_mk_cyl_models(shape, electrode_positions, electrode_shape);
             %mean([max(obj.EIDORS_FEM.nodes(:,3)), min(obj.EIDORS_FEM.nodes(:,3))]);
            obj.EIDORS_FEM.nodes = obj.EIDORS_FEM.nodes - [0,0,centre_height];
            obj.centre = [0,0,0];
            for i = 1:length(obj.EIDORS_FEM.electrode)
                obj.EIDORS_FEM.electrode(i).z_contact = obj.electrode_area*z_contact;
            end
            obj.contact_impedance = z_contact;
            obj.centre = [0,0,0];
            obj.EIDORS_image = mk_image(obj.EIDORS_FEM, 1);
            obj.volumes = get_elem_volume(obj.EIDORS_FEM);
            obj.centres = find_element_centres(obj.EIDORS_FEM);
            obj.EIDORS_image.fwd_solve.get_all_meas = 1;
            obj.homogeneous_data = obj.EIDORS_image.elem_data;
        end
        
        %Displays a table of information about the mesh
        show_mesh_info(obj)
        
        %insert cylindrical perturbation
        obj = insert_cylindrical_perturbation(obj,radius, offset, percentage_increase, only_include_grey_white_matter)
    end
end

