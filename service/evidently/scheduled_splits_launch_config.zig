const ScheduledSplitConfig = @import("scheduled_split_config.zig").ScheduledSplitConfig;

/// An array of structures that define the traffic allocation percentages among
/// the feature variations during each step of a launch. This also defines the
/// start time of each step.
pub const ScheduledSplitsLaunchConfig = struct {
    /// An array of structures that define the traffic allocation percentages among
    /// the feature variations during each step of the launch. This also defines the
    /// start time of each step.
    steps: []const ScheduledSplitConfig,

    pub const json_field_names = .{
        .steps = "steps",
    };
};
