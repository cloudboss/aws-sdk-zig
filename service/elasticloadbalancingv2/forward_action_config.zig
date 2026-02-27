const TargetGroupTuple = @import("target_group_tuple.zig").TargetGroupTuple;
const TargetGroupStickinessConfig = @import("target_group_stickiness_config.zig").TargetGroupStickinessConfig;

/// Information about a forward action.
pub const ForwardActionConfig = struct {
    /// The target groups.
    target_groups: ?[]const TargetGroupTuple,

    /// The target group stickiness for the rule.
    target_group_stickiness_config: ?TargetGroupStickinessConfig,
};
