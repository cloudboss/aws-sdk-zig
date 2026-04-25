/// Configuration settings for after contact work (ACW) timeout.
pub const AfterContactWorkConfig = struct {
    /// The ACW timeout duration in seconds. Minimum: 1 second. Maximum: 2,000,000
    /// seconds (24 days). Enter 0 for indefinite ACW time.
    after_contact_work_time_limit: i32 = 0,

    pub const json_field_names = .{
        .after_contact_work_time_limit = "AfterContactWorkTimeLimit",
    };
};
