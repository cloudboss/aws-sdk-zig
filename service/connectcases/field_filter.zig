const FieldValue = @import("field_value.zig").FieldValue;

/// A filter for fields. Only one value can be provided.
pub const FieldFilter = union(enum) {
    /// Object containing field identifier and value information.
    contains: ?FieldValue,
    /// Object containing field identifier and value information.
    equal_to: ?FieldValue,
    /// Object containing field identifier and value information.
    greater_than: ?FieldValue,
    /// Object containing field identifier and value information.
    greater_than_or_equal_to: ?FieldValue,
    /// Object containing field identifier and value information.
    less_than: ?FieldValue,
    /// Object containing field identifier and value information.
    less_than_or_equal_to: ?FieldValue,

    pub const json_field_names = .{
        .contains = "contains",
        .equal_to = "equalTo",
        .greater_than = "greaterThan",
        .greater_than_or_equal_to = "greaterThanOrEqualTo",
        .less_than = "lessThan",
        .less_than_or_equal_to = "lessThanOrEqualTo",
    };
};
