const StringComparisonType = @import("string_comparison_type.zig").StringComparisonType;

/// A leaf node condition which can be used to specify a string condition.
pub const StringCondition = struct {
    /// The type of comparison to be made when evaluating the string condition.
    comparison_type: ?StringComparisonType = null,

    /// The name of the field in the string condition.
    field_name: ?[]const u8 = null,

    /// The value of the string.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .comparison_type = "ComparisonType",
        .field_name = "FieldName",
        .value = "Value",
    };
};
