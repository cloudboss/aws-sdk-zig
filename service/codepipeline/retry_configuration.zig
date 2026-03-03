const StageRetryMode = @import("stage_retry_mode.zig").StageRetryMode;

/// The retry configuration specifies automatic retry for a failed stage, along
/// with the
/// configured retry mode.
pub const RetryConfiguration = struct {
    /// The method that you want to configure for automatic stage retry on stage
    /// failure. You
    /// can specify to retry only failed action in the stage or all actions in the
    /// stage.
    retry_mode: ?StageRetryMode = null,

    pub const json_field_names = .{
        .retry_mode = "retryMode",
    };
};
