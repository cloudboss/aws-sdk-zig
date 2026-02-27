const DimensionValueType = @import("dimension_value_type.zig").DimensionValueType;

/// Maps source data to a dimension in the target Timestream for LiveAnalytics
/// table.
///
/// For more information, see [Amazon Timestream for LiveAnalytics
/// concepts](https://docs.aws.amazon.com/timestream/latest/developerguide/concepts.html)
pub const DimensionMapping = struct {
    /// The metadata attributes of the time series. For example, the name and
    /// Availability Zone
    /// of an Amazon EC2 instance or the name of the manufacturer of a wind turbine
    /// are
    /// dimensions.
    dimension_name: []const u8,

    /// Dynamic path to the dimension value in the source event.
    dimension_value: []const u8,

    /// The data type of the dimension for the time-series data.
    dimension_value_type: DimensionValueType,

    pub const json_field_names = .{
        .dimension_name = "DimensionName",
        .dimension_value = "DimensionValue",
        .dimension_value_type = "DimensionValueType",
    };
};
