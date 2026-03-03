const TargetInstance = @import("target_instance.zig").TargetInstance;

/// Details for the modification recommendation.
pub const ModifyRecommendationDetail = struct {
    /// Determines whether this instance type is the Amazon Web Services default
    /// recommendation.
    target_instances: ?[]const TargetInstance = null,

    pub const json_field_names = .{
        .target_instances = "TargetInstances",
    };
};
