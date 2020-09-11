%Assigns a stimulation pattern to use for forward solvers.
%new_stim_pattern:
%An EIDORS structure with information about the stimulation pattern to be
%used. For more information see the EIDORS documentation/tutorials.
%e.g.
%new_stim_pattern = mk_stim_patterns(32, 1, [0,1], [0,1], {}, 1);
%for a mesh with 32 electrodes.
function obj = assign_stimulation_pattern(obj, new_stim_pattern)
obj.stimulation_pattern = new_stim_pattern;
obj.EIDORS_FEM.stimulation = new_stim_pattern;
obj.EIDORS_image.fwd_model.stimulation = new_stim_pattern;
end