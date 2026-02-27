/// Contains a timestamp with optional nanosecond granularity.
pub const TimeInNanos = struct {
    /// The nanosecond offset from `timeInSeconds`.
    offset_in_nanos: ?i32,

    /// The timestamp date, in seconds, in the Unix epoch format. Fractional
    /// nanosecond data is
    /// provided by `offsetInNanos`.
    time_in_seconds: i64,

    pub const json_field_names = .{
        .offset_in_nanos = "offsetInNanos",
        .time_in_seconds = "timeInSeconds",
    };
};
