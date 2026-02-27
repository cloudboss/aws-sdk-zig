const MeasureValueType = @import("measure_value_type.zig").MeasureValueType;

/// A mapping of a source event data field to a measure in a Timestream for
/// LiveAnalytics record.
pub const MultiMeasureAttributeMapping = struct {
    /// Dynamic path to the measurement attribute in the source event.
    measure_value: []const u8,

    /// Data type of the measurement attribute in the source event.
    measure_value_type: MeasureValueType,

    /// Target measure name to be used.
    multi_measure_attribute_name: []const u8,

    pub const json_field_names = .{
        .measure_value = "MeasureValue",
        .measure_value_type = "MeasureValueType",
        .multi_measure_attribute_name = "MultiMeasureAttributeName",
    };
};
