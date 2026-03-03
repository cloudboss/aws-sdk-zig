const DateComparisonType = @import("date_comparison_type.zig").DateComparisonType;

/// An object to specify the hours of operation override date condition.
pub const DateCondition = struct {
    /// An object to specify the hours of operation override date condition
    /// `comparisonType`.
    comparison_type: ?DateComparisonType = null,

    /// An object to specify the hours of operation override date field.
    field_name: ?[]const u8 = null,

    /// An object to specify the hours of operation override date value.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .comparison_type = "ComparisonType",
        .field_name = "FieldName",
        .value = "Value",
    };
};
