const MultiMeasureAttributeMapping = @import("multi_measure_attribute_mapping.zig").MultiMeasureAttributeMapping;

/// Maps multiple measures from the source event to the same Timestream for
/// LiveAnalytics record.
///
/// For more information, see [Amazon Timestream for LiveAnalytics
/// concepts](https://docs.aws.amazon.com/timestream/latest/developerguide/concepts.html)
pub const MultiMeasureMapping = struct {
    /// Mappings that represent multiple source event fields mapped to measures in
    /// the same
    /// Timestream for LiveAnalytics record.
    multi_measure_attribute_mappings: []const MultiMeasureAttributeMapping,

    /// The name of the multiple measurements per record (multi-measure).
    multi_measure_name: []const u8,

    pub const json_field_names = .{
        .multi_measure_attribute_mappings = "MultiMeasureAttributeMappings",
        .multi_measure_name = "MultiMeasureName",
    };
};
