const ScalarMeasureValueType = @import("scalar_measure_value_type.zig").ScalarMeasureValueType;

/// Attribute mapping for MULTI value measures.
pub const MultiMeasureAttributeMapping = struct {
    /// Type of the attribute to be read from the source column.
    measure_value_type: ScalarMeasureValueType,

    /// Source column from where the attribute value is to be read.
    source_column: []const u8,

    /// Custom name to be used for attribute name in derived table. If not provided,
    /// source
    /// column name would be used.
    target_multi_measure_attribute_name: ?[]const u8,

    pub const json_field_names = .{
        .measure_value_type = "MeasureValueType",
        .source_column = "SourceColumn",
        .target_multi_measure_attribute_name = "TargetMultiMeasureAttributeName",
    };
};
