/// An object that contains information about the per-day and per-second sending
/// limits
/// for your Amazon SES account in the current Amazon Web Services Region.
pub const SendQuota = struct {
    /// The maximum number of emails that you can send in the current Amazon Web
    /// Services Region over a
    /// 24-hour period. A value of -1 signifies an unlimited quota. (This value is
    /// also referred
    /// to as your *sending quota*.)
    max_24_hour_send: f64 = 0,

    /// The maximum number of emails that you can send per second in the current
    /// Amazon Web Services Region.
    /// This value is also called your *maximum sending rate* or your
    /// *maximum TPS (transactions per second) rate*.
    max_send_rate: f64 = 0,

    /// The number of emails sent from your Amazon SES account in the current Amazon
    /// Web Services Region over the
    /// past 24 hours.
    sent_last_24_hours: f64 = 0,

    pub const json_field_names = .{
        .max_24_hour_send = "Max24HourSend",
        .max_send_rate = "MaxSendRate",
        .sent_last_24_hours = "SentLast24Hours",
    };
};
