/// Represents sending statistics data. Each `SendDataPoint` contains
/// statistics for a 15-minute period of sending activity.
pub const SendDataPoint = struct {
    /// Number of emails that have bounced.
    bounces: i64 = 0,

    /// Number of unwanted emails that were rejected by recipients.
    complaints: i64 = 0,

    /// Number of emails that have been sent.
    delivery_attempts: i64 = 0,

    /// Number of emails rejected by Amazon SES.
    rejects: i64 = 0,

    /// Time of the data point.
    timestamp: ?i64,
};
