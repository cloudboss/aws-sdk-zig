const MeasureValueType = @import("measure_value_type.zig").MeasureValueType;
const MultiMeasureAttributeMapping = @import("multi_measure_attribute_mapping.zig").MultiMeasureAttributeMapping;

pub const MixedMeasureMapping = struct {
    measure_name: ?[]const u8 = null,

    measure_value_type: MeasureValueType,

    multi_measure_attribute_mappings: ?[]const MultiMeasureAttributeMapping = null,

    source_column: ?[]const u8 = null,

    target_measure_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .measure_name = "MeasureName",
        .measure_value_type = "MeasureValueType",
        .multi_measure_attribute_mappings = "MultiMeasureAttributeMappings",
        .source_column = "SourceColumn",
        .target_measure_name = "TargetMeasureName",
    };
};
