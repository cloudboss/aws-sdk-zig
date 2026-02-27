/// Describes how to interpret an application-defined timestamp value from an
/// MQTT message
/// payload and the precision of that value.
pub const LocationTimestamp = struct {
    /// The precision of the timestamp value that results from the expression
    /// described in `value`.
    ///
    /// Valid values: `SECONDS` | `MILLISECONDS` |
    /// `MICROSECONDS` | `NANOSECONDS`. The default is
    /// `MILLISECONDS`.
    unit: ?[]const u8,

    /// An expression that returns a long epoch time value.
    value: []const u8,

    pub const json_field_names = .{
        .unit = "unit",
        .value = "value",
    };
};
