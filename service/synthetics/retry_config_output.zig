/// This structure contains information about the canary's retry configuration.
pub const RetryConfigOutput = struct {
    /// The maximum number of retries. The value must be less than or equal to 2.
    max_retries: ?i32,

    pub const json_field_names = .{
        .max_retries = "MaxRetries",
    };
};
