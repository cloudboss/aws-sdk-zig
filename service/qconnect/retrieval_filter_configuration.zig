const FilterAttribute = @import("filter_attribute.zig").FilterAttribute;

/// Configuration for filtering content during retrieval operations.
pub const RetrievalFilterConfiguration = union(enum) {
    /// Filter configuration that requires all conditions to be met.
    and_all: ?[]const RetrievalFilterConfiguration,
    /// Filter configuration for exact equality matching.
    equals: ?FilterAttribute,
    /// Filter configuration for greater than comparison.
    greater_than: ?FilterAttribute,
    /// Filter configuration for greater than or equal comparison.
    greater_than_or_equals: ?FilterAttribute,
    /// Filter configuration for membership in a set of values.
    in: ?FilterAttribute,
    /// Filter configuration for less than comparison.
    less_than: ?FilterAttribute,
    /// Filter configuration for less than or equal comparison.
    less_than_or_equals: ?FilterAttribute,
    /// Filter configuration for checking if a list contains a value.
    list_contains: ?FilterAttribute,
    /// Filter configuration for inequality matching.
    not_equals: ?FilterAttribute,
    /// Filter configuration for exclusion from a set of values.
    not_in: ?FilterAttribute,
    /// Filter configuration where any condition can be met.
    or_all: ?[]const RetrievalFilterConfiguration,
    /// Filter configuration for prefix matching.
    starts_with: ?FilterAttribute,
    /// Filter configuration for substring matching.
    string_contains: ?FilterAttribute,

    pub const json_field_names = .{
        .and_all = "andAll",
        .equals = "equals",
        .greater_than = "greaterThan",
        .greater_than_or_equals = "greaterThanOrEquals",
        .in = "in",
        .less_than = "lessThan",
        .less_than_or_equals = "lessThanOrEquals",
        .list_contains = "listContains",
        .not_equals = "notEquals",
        .not_in = "notIn",
        .or_all = "orAll",
        .starts_with = "startsWith",
        .string_contains = "stringContains",
    };
};
