const MultiMeasureAttributeMapping = @import("multi_measure_attribute_mapping.zig").MultiMeasureAttributeMapping;

/// Only one of MixedMeasureMappings or MultiMeasureMappings is to be provided.
/// MultiMeasureMappings can be used to ingest data as multi measures in the
/// derived
/// table.
pub const MultiMeasureMappings = struct {
    /// Required. Attribute mappings to be used for mapping query results to ingest
    /// data for
    /// multi-measure attributes.
    multi_measure_attribute_mappings: []const MultiMeasureAttributeMapping,

    /// The name of the target multi-measure name in the derived table. This input
    /// is required
    /// when measureNameColumn is not provided. If MeasureNameColumn is provided,
    /// then value
    /// from that column will be used as multi-measure name.
    target_multi_measure_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .multi_measure_attribute_mappings = "MultiMeasureAttributeMappings",
        .target_multi_measure_name = "TargetMultiMeasureName",
    };
};
