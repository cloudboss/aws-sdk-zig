const TagCondition = @import("tag_condition.zig").TagCondition;
const OrCondition = @import("or_condition.zig").OrCondition;

/// An object that can be used to specify Tag conditions.
pub const TagFilter = union(enum) {
    /// A list of conditions which would be applied together with an `AND`
    /// condition.
    and_conditions: ?[]const TagCondition,
    /// A list of conditions which would be applied together with an `OR` condition.
    or_conditions: ?[]const OrCondition,
    /// A leaf node condition which can be used to specify a tag condition.
    tag_condition: ?TagCondition,

    pub const json_field_names = .{
        .and_conditions = "andConditions",
        .or_conditions = "orConditions",
        .tag_condition = "tagCondition",
    };
};
