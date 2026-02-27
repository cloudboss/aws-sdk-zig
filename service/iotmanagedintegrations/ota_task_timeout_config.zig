/// Over-the-air (OTA) task timeout config.
pub const OtaTaskTimeoutConfig = struct {
    /// Specifies the amount of time the device has to finish execution of this
    /// task. The timeout interval can be anywhere between 1 minute and 7 days.
    in_progress_timeout_in_minutes: ?i64,

    pub const json_field_names = .{
        .in_progress_timeout_in_minutes = "InProgressTimeoutInMinutes",
    };
};
