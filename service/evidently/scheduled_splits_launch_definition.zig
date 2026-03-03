const ScheduledSplit = @import("scheduled_split.zig").ScheduledSplit;

/// An array of structures that define the traffic allocation percentages among
/// the feature variations during each step of a launch. This also defines the
/// start time of each step.
pub const ScheduledSplitsLaunchDefinition = struct {
    /// An array of structures that define the traffic allocation percentages among
    /// the feature variations during each step of the launch. This also defines the
    /// start time of each step.
    steps: ?[]const ScheduledSplit = null,

    pub const json_field_names = .{
        .steps = "steps",
    };
};
