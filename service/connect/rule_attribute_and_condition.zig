const TagCondition = @import("tag_condition.zig").TagCondition;

/// A list of conditions which would be applied together with an `AND`
/// condition.
pub const RuleAttributeAndCondition = struct {
    /// A list of tag conditions that need to be applied with `AND` condition.
    tag_conditions: ?[]const TagCondition = null,

    pub const json_field_names = .{
        .tag_conditions = "TagConditions",
    };
};
