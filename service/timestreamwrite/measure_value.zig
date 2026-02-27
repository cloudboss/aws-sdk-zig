const MeasureValueType = @import("measure_value_type.zig").MeasureValueType;

/// Represents the data attribute of the time series. For example, the CPU
/// utilization of
/// an EC2 instance or the RPM of a wind turbine are measures. MeasureValue has
/// both name and
/// value.
///
/// MeasureValue is only allowed for type `MULTI`. Using `MULTI`
/// type, you can pass multiple data attributes associated with the same time
/// series in a
/// single record
pub const MeasureValue = struct {
    /// The name of the MeasureValue.
    ///
    /// For constraints on MeasureValue names, see [ Naming
    /// Constraints](https://docs.aws.amazon.com/timestream/latest/developerguide/ts-limits.html#limits.naming) in the Amazon Timestream Developer Guide.
    name: []const u8,

    /// Contains the data type of the MeasureValue for the time-series data point.
    type: MeasureValueType,

    /// The value for the MeasureValue. For information, see [Data
    /// types](https://docs.aws.amazon.com/timestream/latest/developerguide/writes.html#writes.data-types).
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .type = "Type",
        .value = "Value",
    };
};
