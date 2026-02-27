const MultiMeasureAttributeMapping = @import("multi_measure_attribute_mapping.zig").MultiMeasureAttributeMapping;

pub const MultiMeasureMappings = struct {
    multi_measure_attribute_mappings: []const MultiMeasureAttributeMapping,

    target_multi_measure_name: ?[]const u8,

    pub const json_field_names = .{
        .multi_measure_attribute_mappings = "MultiMeasureAttributeMappings",
        .target_multi_measure_name = "TargetMultiMeasureName",
    };
};
