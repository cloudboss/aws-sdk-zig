/// Represents a duration of time defined by start and end timestamps.
pub const TimePeriod = struct {
    /// The end (exclusive) of the time period. ISO-8601 formatted timestamp, for
    /// example: `YYYY-MM-DDThh:mm:ss.sssZ`
    end: i64,

    /// The start (inclusive) of the time period. ISO-8601 formatted timestamp, for
    /// example: `YYYY-MM-DDThh:mm:ss.sssZ`
    start: i64,

    pub const json_field_names = .{
        .end = "End",
        .start = "Start",
    };
};
