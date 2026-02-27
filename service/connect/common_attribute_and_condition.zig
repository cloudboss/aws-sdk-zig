const TagCondition = @import("tag_condition.zig").TagCondition;

/// A list of conditions which would be applied together with an `AND`
/// condition.
pub const CommonAttributeAndCondition = struct {
    /// A leaf node condition which can be used to specify a tag condition.
    tag_conditions: ?[]const TagCondition,

    pub const json_field_names = .{
        .tag_conditions = "TagConditions",
    };
};
