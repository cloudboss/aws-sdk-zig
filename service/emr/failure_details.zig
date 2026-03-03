/// The details of the step failure. The service attempts to detect the root
/// cause for many
/// common failures.
pub const FailureDetails = struct {
    /// The path to the log file where the step failure root cause was originally
    /// recorded.
    log_file: ?[]const u8 = null,

    /// The descriptive message including the error the Amazon EMR service has
    /// identified as the cause of step failure. This is text from an error log that
    /// describes the
    /// root cause of the failure.
    message: ?[]const u8 = null,

    /// The reason for the step failure. In the case where the service cannot
    /// successfully
    /// determine the root cause of the failure, it returns "Unknown Error" as a
    /// reason.
    reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .log_file = "LogFile",
        .message = "Message",
        .reason = "Reason",
    };
};
