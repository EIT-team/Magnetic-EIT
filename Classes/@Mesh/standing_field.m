%Solves the magnetic forward problem for the unperturbed case to find the
%standing field. 
%scalar_or_vector:
%A string indicating whether the standing field should be saved in vector
%or scalar format. 
%e.g.
%scalar_or_vector = 'scalar';
%or
%scalar_or_vector = 'vector';
%If the vector form of the magnetic field is chosen then the data is stored
%in a 3 dimensional matrix, the first dimension represents the different
%mangetic field sensor locations, the second dimension represents the x,y
%and z components of the magnetic field and the third dimension represents
%the different stimulation pairs.
function obj = standing_field(obj, scalar_or_vector)
obj.standing_field_form = scalar_or_vector;
if strcmp(scalar_or_vector,'vector') == true && isempty(obj.unperturbed_magnetic_field) == false && isempty(obj.unperturbed_voltages) == false
    obj.standing_field_data.electric_field = obj.unperturbed_voltages;
    obj.standing_field_data.magnetic_field = obj.unperturbed_magnetic_field;
else
    obj.standing_field_data.electric_field = fwd_solve(obj.EIDORS_image);
    obj.standing_field_data.magnetic_field = magnetic_field(obj.EIDORS_image, obj.standing_field_data.electric_field, obj.magnetic_field_sensor_locations, obj.volumes, obj.centres, 1, scalar_or_vector);
    obj.unperturbed_voltages = obj.standing_field_data.electric_field;
    obj.unperturbed_magnetic_field = obj.standing_field_data.magnetic_field;
end
end

