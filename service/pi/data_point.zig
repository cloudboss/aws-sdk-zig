/// A timestamp, and a single numerical value, which together represent a
/// measurement at a particular point in time.
pub const DataPoint = struct {
    /// The time, in epoch format, associated with a particular `Value`.
    timestamp: i64,

    /// The actual value associated with a particular `Timestamp`.
    value: f64,

    pub const json_field_names = .{
        .timestamp = "Timestamp",
        .value = "Value",
    };
};
