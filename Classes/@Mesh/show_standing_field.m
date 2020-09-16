

function show_standing_field(obj, stimulation_number, arrow_size)
%Shows the standing magnetic field, the magnetic field at each sensor
%location is represented by an arrow. The size of the arrow is proportional
%to the magnitude of the magnetic field and the direction indicates the
%direction in which the magnetic field points. 
%stimulation_number:
%A single scalar value indicating which injection pair of electrodes the
%standing field should be shown for.
%e.g.
%stimulation_number = 2;
%%arrow_size:
%A single scalar value to indicate the size of the arrows displayed.
%e.g.
% arrow_size = 1;
if strcmp(obj.standing_field_form, 'scalar')
    error('Please find the vector form of the standing field for the field lines to be shown');
end

if isempty(obj.standing_field_data.magnetic_field)
    error('Please run the function "standing_field" first to calculate a magnetic field to show.');
end
if isempty (obj.magnetic_field_sensor_locations)
    error('Please assign magnetic field sensor locations');
end
loc = obj.magnetic_field_sensor_locations;
mag = obj.standing_field_data.magnetic_field(:,:,stimulation_number);
quiver3(loc(:,1), loc(:,2), loc(:,3), mag(:,1), mag(:,2), mag(:,3), 'AutoScaleFactor', arrow_size);
end