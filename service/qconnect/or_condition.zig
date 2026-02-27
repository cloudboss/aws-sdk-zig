const TagCondition = @import("tag_condition.zig").TagCondition;

/// A list of conditions which would be applied together with an `OR` condition.
pub const OrCondition = union(enum) {
    /// A list of conditions which would be applied together with an `AND`
    /// condition.
    and_conditions: ?[]const TagCondition,
    /// A leaf node condition which can be used to specify a tag condition.
    tag_condition: ?TagCondition,

    pub const json_field_names = .{
        .and_conditions = "andConditions",
        .tag_condition = "tagCondition",
    };
};
