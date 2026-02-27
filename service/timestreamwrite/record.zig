const Dimension = @import("dimension.zig").Dimension;
const MeasureValue = @import("measure_value.zig").MeasureValue;
const MeasureValueType = @import("measure_value_type.zig").MeasureValueType;
const TimeUnit = @import("time_unit.zig").TimeUnit;

/// Represents a time-series data point being written into Timestream. Each
/// record
/// contains an array of dimensions. Dimensions represent the metadata
/// attributes of a
/// time-series data point, such as the instance name or Availability Zone of an
/// EC2 instance.
/// A record also contains the measure name, which is the name of the measure
/// being collected
/// (for example, the CPU utilization of an EC2 instance). Additionally, a
/// record contains the
/// measure value and the value type, which is the data type of the measure
/// value. Also, the
/// record contains the timestamp of when the measure was collected and the
/// timestamp unit,
/// which represents the granularity of the timestamp.
///
/// Records have a `Version` field, which is a 64-bit `long` that you
/// can use for updating data points. Writes of a duplicate record with the same
/// dimension,
/// timestamp, and measure name but different measure value will only succeed if
/// the
/// `Version` attribute of the record in the write request is higher than that
/// of
/// the existing record. Timestream defaults to a `Version` of
/// `1` for records without the `Version` field.
pub const Record = struct {
    /// Contains the list of dimensions for time-series data points.
    dimensions: ?[]const Dimension,

    /// Measure represents the data attribute of the time series. For example, the
    /// CPU
    /// utilization of an EC2 instance or the RPM of a wind turbine are measures.
    measure_name: ?[]const u8,

    /// Contains the measure value for the time-series data point.
    measure_value: ?[]const u8,

    /// Contains the list of MeasureValue for time-series data points.
    ///
    /// This is only allowed for type `MULTI`. For scalar values, use
    /// `MeasureValue` attribute of the record directly.
    measure_values: ?[]const MeasureValue,

    /// Contains the data type of the measure value for the time-series data point.
    /// Default
    /// type is `DOUBLE`. For more information, see [Data
    /// types](https://docs.aws.amazon.com/timestream/latest/developerguide/writes.html#writes.data-types).
    measure_value_type: ?MeasureValueType,

    /// Contains the time at which the measure value for the data point was
    /// collected. The time
    /// value plus the unit provides the time elapsed since the epoch. For example,
    /// if the time
    /// value is `12345` and the unit is `ms`, then `12345 ms`
    /// have elapsed since the epoch.
    time: ?[]const u8,

    /// The granularity of the timestamp unit. It indicates if the time value is in
    /// seconds,
    /// milliseconds, nanoseconds, or other supported values. Default is
    /// `MILLISECONDS`.
    time_unit: ?TimeUnit,

    /// 64-bit attribute used for record updates. Write requests for duplicate data
    /// with a
    /// higher version number will update the existing measure value and version. In
    /// cases where
    /// the measure value is the same, `Version` will still be updated. Default
    /// value is
    /// `1`.
    ///
    /// `Version` must be `1` or greater, or you will receive a
    /// `ValidationException` error.
    version: ?i64,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
        .measure_name = "MeasureName",
        .measure_value = "MeasureValue",
        .measure_values = "MeasureValues",
        .measure_value_type = "MeasureValueType",
        .time = "Time",
        .time_unit = "TimeUnit",
        .version = "Version",
    };
};
