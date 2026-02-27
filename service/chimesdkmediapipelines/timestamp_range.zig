/// The range of timestamps to return.
pub const TimestampRange = struct {
    /// The ending timestamp for the specified range.
    end_timestamp: i64,

    /// The starting timestamp for the specified range.
    start_timestamp: i64,

    pub const json_field_names = .{
        .end_timestamp = "EndTimestamp",
        .start_timestamp = "StartTimestamp",
    };
};
