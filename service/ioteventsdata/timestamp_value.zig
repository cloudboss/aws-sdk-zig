/// Contains information about a timestamp.
pub const TimestampValue = struct {
    /// The value of the timestamp, in the Unix epoch format.
    time_in_millis: ?i64,

    pub const json_field_names = .{
        .time_in_millis = "timeInMillis",
    };
};
