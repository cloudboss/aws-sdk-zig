const ClipRange = @import("clip_range.zig").ClipRange;
const UpdateProgramTransition = @import("update_program_transition.zig").UpdateProgramTransition;

/// Schedule configuration parameters.
pub const UpdateProgramScheduleConfiguration = struct {
    /// Program clip range configuration.
    clip_range: ?ClipRange = null,

    /// Program transition configuration.
    transition: ?UpdateProgramTransition = null,

    pub const json_field_names = .{
        .clip_range = "ClipRange",
        .transition = "Transition",
    };
};
