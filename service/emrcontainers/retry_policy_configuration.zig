/// The configuration of the retry policy that the job runs on.
pub const RetryPolicyConfiguration = struct {
    /// The maximum number of attempts on the job's driver.
    max_attempts: i32,

    pub const json_field_names = .{
        .max_attempts = "maxAttempts",
    };
};
