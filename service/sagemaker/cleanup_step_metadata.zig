const CleanupFailure = @import("cleanup_failure.zig").CleanupFailure;

/// The cleanup outcomes for Amazon S3 output resources associated with upstream
/// steps.
pub const CleanupStepMetadata = struct {
    /// The names of upstream steps whose Amazon S3 output resources the Cleanup
    /// step deleted successfully.
    cleaned_steps: ?[]const []const u8 = null,

    /// The upstream steps whose Amazon S3 output resources the Cleanup step could
    /// not delete.
    failed_steps: ?[]const CleanupFailure = null,

    /// The names of upstream steps that the Cleanup step skipped. The Cleanup step
    /// skips a step when the output properties needed to locate its resources are
    /// unavailable.
    skipped_steps: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .cleaned_steps = "CleanedSteps",
        .failed_steps = "FailedSteps",
        .skipped_steps = "SkippedSteps",
    };
};
