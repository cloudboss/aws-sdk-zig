/// Information about how traffic will be distributed between multiple target
/// groups in a
/// forward rule.
pub const TargetGroupTuple = struct {
    /// The Amazon Resource Name (ARN) of the target group.
    target_group_arn: ?[]const u8,

    /// The weight. The range is 0 to 999.
    weight: ?i32,
};
