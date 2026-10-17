const CleanupFailureErrorCode = @import("cleanup_failure_error_code.zig").CleanupFailureErrorCode;

/// The Amazon S3 output resources associated with an upstream step that the
/// Cleanup step could not delete.
pub const CleanupFailure = struct {
    /// The error code that identifies why the Cleanup step could not delete the
    /// output resources associated with the upstream step.
    error_code: ?CleanupFailureErrorCode = null,

    /// A message describing why the Cleanup step could not delete the output
    /// resources associated with the upstream step.
    error_message: ?[]const u8 = null,

    /// The name of the upstream step whose Amazon S3 output resources the Cleanup
    /// step could not delete.
    step_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .step_name = "StepName",
    };
};
