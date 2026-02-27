const WeightedTarget = @import("weighted_target.zig").WeightedTarget;

/// An object that represents the action to take if a match is determined.
pub const HttpRouteAction = struct {
    /// An object that represents the targets that traffic is routed to when a
    /// request matches the route.
    weighted_targets: []const WeightedTarget,

    pub const json_field_names = .{
        .weighted_targets = "weightedTargets",
    };
};
