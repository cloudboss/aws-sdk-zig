const RetryTrigger = @import("retry_trigger.zig").RetryTrigger;

/// The details of a specific automatic retry on stage failure, including the
/// attempt
/// number and trigger.
pub const RetryStageMetadata = struct {
    /// The number of attempts for a specific stage with automatic retry on stage
    /// failure. One
    /// attempt is allowed for automatic stage retry on failure.
    auto_stage_retry_attempt: ?i32,

    /// The latest trigger for a specific stage where manual or automatic retries
    /// have been
    /// made upon stage failure.
    latest_retry_trigger: ?RetryTrigger,

    /// The number of attempts for a specific stage where manual retries have been
    /// made upon
    /// stage failure.
    manual_stage_retry_attempt: ?i32,

    pub const json_field_names = .{
        .auto_stage_retry_attempt = "autoStageRetryAttempt",
        .latest_retry_trigger = "latestRetryTrigger",
        .manual_stage_retry_attempt = "manualStageRetryAttempt",
    };
};
