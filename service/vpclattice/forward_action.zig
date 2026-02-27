const WeightedTargetGroup = @import("weighted_target_group.zig").WeightedTargetGroup;

/// Describes a forward action. You can use forward actions to route requests to
/// one or more target groups.
pub const ForwardAction = struct {
    /// The target groups. Traffic matching the rule is forwarded to the specified
    /// target groups. With forward actions, you can assign a weight that controls
    /// the prioritization and selection of each target group. This means that
    /// requests are distributed to individual target groups based on their weights.
    /// For example, if two target groups have the same weight, each target group
    /// receives half of the traffic.
    ///
    /// The default value is 1. This means that if only one target group is
    /// provided, there is no need to set the weight; 100% of the traffic goes to
    /// that target group.
    target_groups: []const WeightedTargetGroup,

    pub const json_field_names = .{
        .target_groups = "targetGroups",
    };
};
