/// The timeout configuration for a notebook run in Amazon DataZone.
pub const TimeoutConfig = struct {
    /// The timeout for the notebook run, in minutes. The minimum value is 60
    /// minutes (1 hour), the maximum value is 1440 minutes (24 hours), and the
    /// default value is 720 minutes (12 hours).
    run_timeout_in_minutes: ?i32 = null,

    pub const json_field_names = .{
        .run_timeout_in_minutes = "runTimeoutInMinutes",
    };
};
