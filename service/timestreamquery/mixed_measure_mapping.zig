const MeasureValueType = @import("measure_value_type.zig").MeasureValueType;
const MultiMeasureAttributeMapping = @import("multi_measure_attribute_mapping.zig").MultiMeasureAttributeMapping;

/// MixedMeasureMappings are mappings that can be used to ingest data into a
/// mixture of
/// narrow and multi measures in the derived table.
pub const MixedMeasureMapping = struct {
    /// Refers to the value of measure_name in a result row. This field is required
    /// if
    /// MeasureNameColumn is provided.
    measure_name: ?[]const u8 = null,

    /// Type of the value that is to be read from sourceColumn. If the mapping is
    /// for MULTI,
    /// use MeasureValueType.MULTI.
    measure_value_type: MeasureValueType,

    /// Required when measureValueType is MULTI. Attribute mappings for MULTI value
    /// measures.
    multi_measure_attribute_mappings: ?[]const MultiMeasureAttributeMapping = null,

    /// This field refers to the source column from which measure-value is to be
    /// read for
    /// result materialization.
    source_column: ?[]const u8 = null,

    /// Target measure name to be used. If not provided, the target measure name by
    /// default
    /// would be measure-name if provided, or sourceColumn otherwise.
    target_measure_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .measure_name = "MeasureName",
        .measure_value_type = "MeasureValueType",
        .multi_measure_attribute_mappings = "MultiMeasureAttributeMappings",
        .source_column = "SourceColumn",
        .target_measure_name = "TargetMeasureName",
    };
};
