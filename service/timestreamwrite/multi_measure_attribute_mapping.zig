const ScalarMeasureValueType = @import("scalar_measure_value_type.zig").ScalarMeasureValueType;

pub const MultiMeasureAttributeMapping = struct {
    measure_value_type: ?ScalarMeasureValueType,

    source_column: []const u8,

    target_multi_measure_attribute_name: ?[]const u8,

    pub const json_field_names = .{
        .measure_value_type = "MeasureValueType",
        .source_column = "SourceColumn",
        .target_multi_measure_attribute_name = "TargetMultiMeasureAttributeName",
    };
};
