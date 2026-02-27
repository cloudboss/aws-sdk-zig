/// An object that contains information about the per-day and per-second sending
/// limits
/// for your Amazon Pinpoint account in the current AWS Region.
pub const SendQuota = struct {
    /// The maximum number of emails that you can send in the current AWS Region
    /// over a
    /// 24-hour period. This value is also called your *sending
    /// quota*.
    max_24_hour_send: f64 = 0,

    /// The maximum number of emails that you can send per second in the current AWS
    /// Region.
    /// This value is also called your *maximum sending rate* or your
    /// *maximum TPS (transactions per second) rate*.
    max_send_rate: f64 = 0,

    /// The number of emails sent from your Amazon Pinpoint account in the current
    /// AWS Region over the
    /// past 24 hours.
    sent_last_24_hours: f64 = 0,

    pub const json_field_names = .{
        .max_24_hour_send = "Max24HourSend",
        .max_send_rate = "MaxSendRate",
        .sent_last_24_hours = "SentLast24Hours",
    };
};
