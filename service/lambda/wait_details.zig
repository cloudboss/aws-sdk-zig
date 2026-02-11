/// Details about a wait operation.
pub const WaitDetails = struct {
    /// The date and time when the wait operation is scheduled to complete, in
    /// [ISO-8601 format](https://www.w3.org/TR/NOTE-datetime)
    /// (YYYY-MM-DDThh:mm:ss.sTZD).
    scheduled_end_timestamp: ?i64,

    pub const json_field_names = .{
        .scheduled_end_timestamp = "ScheduledEndTimestamp",
    };
};
