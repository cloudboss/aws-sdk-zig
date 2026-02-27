const SimpleCondition = @import("simple_condition.zig").SimpleCondition;

/// Specifies a condition to evaluate for an activity path in a journey.
pub const MultiConditionalBranch = struct {
    /// The condition to evaluate for the activity path.
    condition: ?SimpleCondition,

    /// The unique identifier for the next activity to perform, after completing the
    /// activity for the path.
    next_activity: ?[]const u8,

    pub const json_field_names = .{
        .condition = "Condition",
        .next_activity = "NextActivity",
    };
};
