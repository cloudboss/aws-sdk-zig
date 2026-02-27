const BooleanComparisonType = @import("boolean_comparison_type.zig").BooleanComparisonType;

/// A boolean search condition for Search APIs.
pub const BooleanCondition = struct {
    /// Boolean property comparison type.
    comparison_type: ?BooleanComparisonType,

    /// A name of the property to be searched.
    field_name: ?[]const u8,

    pub const json_field_names = .{
        .comparison_type = "ComparisonType",
        .field_name = "FieldName",
    };
};
