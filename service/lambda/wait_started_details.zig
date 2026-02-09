/// Details about a wait operation that has started.
pub const WaitStartedDetails = struct {
    /// The duration to wait, in seconds.
    duration: i32,

    /// The date and time when the wait operation is scheduled to complete, in
    /// [ISO-8601 format](https://www.w3.org/TR/NOTE-datetime)
    /// (YYYY-MM-DDThh:mm:ss.sTZD).
    scheduled_end_timestamp: i64,
};
