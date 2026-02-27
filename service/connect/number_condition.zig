const NumberComparisonType = @import("number_comparison_type.zig").NumberComparisonType;

/// A leaf node condition which can be used to specify a numeric condition.
///
/// The currently supported value for `FieldName` is `limit`.
pub const NumberCondition = struct {
    /// The type of comparison to be made when evaluating the number condition.
    comparison_type: ?NumberComparisonType,

    /// The name of the field in the number condition.
    field_name: ?[]const u8,

    /// The maxValue to be used while evaluating the number condition.
    max_value: ?i32,

    /// The minValue to be used while evaluating the number condition.
    min_value: ?i32,

    pub const json_field_names = .{
        .comparison_type = "ComparisonType",
        .field_name = "FieldName",
        .max_value = "MaxValue",
        .min_value = "MinValue",
    };
};
