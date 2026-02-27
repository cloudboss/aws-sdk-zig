const DataValue = @import("data_value.zig").DataValue;

/// An object that contains information about a value for a time series
/// property.
pub const PropertyValue = struct {
    /// ISO8601 DateTime of a value for a time series property.
    ///
    /// The time for when the property value was recorded in ISO 8601 format:
    /// *YYYY-MM-DDThh:mm:ss[.SSSSSSSSS][Z/±HH:mm]*.
    ///
    /// * *[YYYY]*: year
    ///
    /// * *[MM]*: month
    ///
    /// * *[DD]*: day
    ///
    /// * *[hh]*: hour
    ///
    /// * *[mm]*: minute
    ///
    /// * *[ss]*: seconds
    ///
    /// * *[.SSSSSSSSS]*: additional precision, where precedence is
    /// maintained. For example: [.573123] is equal to 573123000 nanoseconds.
    ///
    /// * *Z*: default timezone UTC
    ///
    /// * *± HH:mm*: time zone offset in Hours and Minutes.
    ///
    /// *Required sub-fields*: YYYY-MM-DDThh:mm:ss and [Z/±HH:mm]
    time: ?[]const u8,

    /// The timestamp of a value for a time series property.
    timestamp: ?i64,

    /// An object that specifies a value for a time series property.
    value: DataValue,

    pub const json_field_names = .{
        .time = "time",
        .timestamp = "timestamp",
        .value = "value",
    };
};
