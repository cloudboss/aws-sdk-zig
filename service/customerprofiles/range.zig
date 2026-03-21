const Unit = @import("unit.zig").Unit;
const ValueRange = @import("value_range.zig").ValueRange;

/// The relative time period over which data is included in the aggregation.
pub const Range = struct {
    /// The format the timestamp field in your JSON object is specified. This value
    /// should be
    /// one of EPOCHMILLI (for Unix epoch timestamps with second/millisecond level
    /// precision) or
    /// ISO_8601 (following ISO_8601 format with second/millisecond level precision,
    /// with an
    /// optional offset of Z or in the format HH:MM or HHMM.). E.g. if your object
    /// type is MyType
    /// and source JSON is {"generatedAt": {"timestamp":
    /// "2001-07-04T12:08:56.235-0700"}}, then
    /// TimestampFormat should be "ISO_8601".
    timestamp_format: ?[]const u8 = null,

    /// An expression specifying the field in your JSON object from which the date
    /// should be
    /// parsed. The expression should follow the structure of \"{ObjectTypeName.}\".
    /// E.g. if your object type is MyType and source
    /// JSON is {"generatedAt": {"timestamp": "1737587945945"}}, then
    /// TimestampSource should be
    /// "{MyType.generatedAt.timestamp}".
    timestamp_source: ?[]const u8 = null,

    /// The unit of time.
    unit: Unit = .days,

    /// The amount of time of the specified unit.
    value: i32 = 0,

    /// A structure letting customers specify a relative time window over which over
    /// which data
    /// is included in the Calculated Attribute. Use positive numbers to indicate
    /// that the endpoint
    /// is in the past, and negative numbers to indicate it is in the future.
    /// ValueRange overrides
    /// Value.
    value_range: ?ValueRange = null,

    pub const json_field_names = .{
        .timestamp_format = "TimestampFormat",
        .timestamp_source = "TimestampSource",
        .unit = "Unit",
        .value = "Value",
        .value_range = "ValueRange",
    };
};
