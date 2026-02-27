const ClipRange = @import("clip_range.zig").ClipRange;
const Transition = @import("transition.zig").Transition;

/// Schedule configuration parameters. A channel must be stopped before changes
/// can be made to the schedule.
pub const ScheduleConfiguration = struct {
    /// Program clip range configuration.
    clip_range: ?ClipRange,

    /// Program transition configurations.
    transition: Transition,

    pub const json_field_names = .{
        .clip_range = "ClipRange",
        .transition = "Transition",
    };
};
