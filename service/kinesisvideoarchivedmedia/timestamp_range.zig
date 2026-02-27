/// The range of timestamps for which to return fragments.
pub const TimestampRange = struct {
    /// The ending timestamp in the range of timestamps for which to return
    /// fragments.
    end_timestamp: i64,

    /// The starting timestamp in the range of timestamps for which to return
    /// fragments.
    start_timestamp: i64,

    pub const json_field_names = .{
        .end_timestamp = "EndTimestamp",
        .start_timestamp = "StartTimestamp",
    };
};
