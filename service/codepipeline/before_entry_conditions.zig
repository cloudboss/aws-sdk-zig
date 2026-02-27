const Condition = @import("condition.zig").Condition;

/// The conditions for making checks for entry to a stage. For more information
/// about
/// conditions, see [Stage
/// conditions](https://docs.aws.amazon.com/codepipeline/latest/userguide/stage-conditions.html)
/// and [How do
/// stage conditions
/// work?](https://docs.aws.amazon.com/codepipeline/latest/userguide/concepts-how-it-works-conditions.html).
pub const BeforeEntryConditions = struct {
    /// The conditions that are configured as entry conditions.
    conditions: []const Condition,

    pub const json_field_names = .{
        .conditions = "conditions",
    };
};
