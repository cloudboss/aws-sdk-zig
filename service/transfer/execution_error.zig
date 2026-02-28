const ExecutionErrorType = @import("execution_error_type.zig").ExecutionErrorType;

/// Specifies the error message and type, for an error that occurs during the
/// execution of the workflow.
pub const ExecutionError = struct {
    /// Specifies the descriptive message that corresponds to the `ErrorType`.
    message: []const u8,

    /// Specifies the error type.
    ///
    /// * `ALREADY_EXISTS`: occurs for a copy step, if the overwrite option is not
    ///   selected and a file with the same name already exists in the target
    ///   location.
    /// * `BAD_REQUEST`: a general bad request: for example, a step that attempts to
    ///   tag an EFS file returns `BAD_REQUEST`, as only S3 files can be tagged.
    /// * `CUSTOM_STEP_FAILED`: occurs when the custom step provided a callback that
    ///   indicates failure.
    /// * `INTERNAL_SERVER_ERROR`: a catch-all error that can occur for a variety of
    ///   reasons.
    /// * `NOT_FOUND`: occurs when a requested entity, for example a source file for
    ///   a copy step, does not exist.
    /// * `PERMISSION_DENIED`: occurs if your policy does not contain the correct
    ///   permissions to complete one or more of the steps in the workflow.
    /// * `TIMEOUT`: occurs when the execution times out.
    ///
    /// You can set the `TimeoutSeconds` for a custom step, anywhere from 1 second
    /// to 1800 seconds (30 minutes).
    /// * `THROTTLED`: occurs if you exceed the new execution refill rate of one
    ///   workflow per second.
    @"type": ExecutionErrorType,

    pub const json_field_names = .{
        .message = "Message",
        .@"type" = "Type",
    };
};
