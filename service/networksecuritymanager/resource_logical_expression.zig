const ResourceCriteria = @import("resource_criteria.zig").ResourceCriteria;

/// A logical expression that selects resources. Exactly one of `criteria`,
/// `and`, `or`, or `not` is set.
pub const ResourceLogicalExpression = union(enum) {
    /// A list of subexpressions that must all match.
    @"and": ?[]const ResourceLogicalExpression,
    /// A leaf condition that matches resources by tag or by resource-type-specific
    /// configuration.
    criteria: ?ResourceCriteria,
    /// A subexpression that must not match.
    not: ?*const ResourceLogicalExpression,
    /// A list of subexpressions of which at least one must match.
    @"or": ?[]const ResourceLogicalExpression,

    pub const json_field_names = .{
        .@"and" = "and",
        .criteria = "criteria",
        .not = "not",
        .@"or" = "or",
    };
};
