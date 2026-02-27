const MeasureValueType = @import("measure_value_type.zig").MeasureValueType;

/// Maps a single source data field to a single record in the specified
/// Timestream
/// for LiveAnalytics table.
///
/// For more information, see [Amazon Timestream for LiveAnalytics
/// concepts](https://docs.aws.amazon.com/timestream/latest/developerguide/concepts.html)
pub const SingleMeasureMapping = struct {
    /// Target measure name for the measurement attribute in the Timestream table.
    measure_name: []const u8,

    /// Dynamic path of the source field to map to the measure in the record.
    measure_value: []const u8,

    /// Data type of the source field.
    measure_value_type: MeasureValueType,

    pub const json_field_names = .{
        .measure_name = "MeasureName",
        .measure_value = "MeasureValue",
        .measure_value_type = "MeasureValueType",
    };
};
