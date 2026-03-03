const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;

/// The criteria that a specific object attribute must meet to trigger the
/// destination.
pub const ObjectAttribute = struct {
    /// The operator used to compare an attribute against a list of values.
    comparison_operator: ComparisonOperator,

    /// A field defined within an object type.
    field_name: ?[]const u8 = null,

    /// An attribute contained within a source object.
    source: ?[]const u8 = null,

    /// A list of attribute values used for comparison.
    values: []const []const u8,

    pub const json_field_names = .{
        .comparison_operator = "ComparisonOperator",
        .field_name = "FieldName",
        .source = "Source",
        .values = "Values",
    };
};
