const PrimaryValue = @import("primary_value.zig").PrimaryValue;
const DataTableAttributeValueType = @import("data_table_attribute_value_type.zig").DataTableAttributeValueType;

/// A data table evaluated value.
pub const DataTableEvaluatedValue = struct {
    /// The value's attribute name.
    attribute_name: []const u8,

    /// The value's error.
    @"error": bool = false,

    /// The value's evaluated value.
    evaluated_value: []const u8,

    /// The value's found.
    found: bool = false,

    /// The value's primary values.
    primary_values: []const PrimaryValue,

    /// The value's record ID.
    record_id: []const u8,

    /// The value's value type.
    value_type: DataTableAttributeValueType,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .@"error" = "Error",
        .evaluated_value = "EvaluatedValue",
        .found = "Found",
        .primary_values = "PrimaryValues",
        .record_id = "RecordId",
        .value_type = "ValueType",
    };
};
