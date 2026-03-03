/// How long, in days, message data is kept.
pub const RetentionPeriod = struct {
    /// The number of days that message data is kept. The `unlimited` parameter must
    /// be
    /// false.
    number_of_days: ?i32 = null,

    /// If true, message data is kept indefinitely.
    unlimited: bool = false,

    pub const json_field_names = .{
        .number_of_days = "numberOfDays",
        .unlimited = "unlimited",
    };
};
