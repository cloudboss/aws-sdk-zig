const LifecycleErrorCode = @import("lifecycle_error_code.zig").LifecycleErrorCode;

/// Diagnostic information about executable scripts that are part of a
/// deployment.
pub const Diagnostics = struct {
    /// The associated error code:
    ///
    /// * Success: The specified script ran.
    ///
    /// * ScriptMissing: The specified script was not found in the specified
    /// location.
    ///
    /// * ScriptNotExecutable: The specified script is not a recognized executable
    ///   file
    /// type.
    ///
    /// * ScriptTimedOut: The specified script did not finish running in the
    ///   specified
    /// time period.
    ///
    /// * ScriptFailed: The specified script failed to run as expected.
    ///
    /// * UnknownError: The specified script did not run for an unknown reason.
    error_code: ?LifecycleErrorCode,

    /// The last portion of the diagnostic log.
    ///
    /// If available, CodeDeploy returns up to the last 4 KB of the diagnostic
    /// log.
    log_tail: ?[]const u8,

    /// The message associated with the error.
    message: ?[]const u8,

    /// The name of the script.
    script_name: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .log_tail = "logTail",
        .message = "message",
        .script_name = "scriptName",
    };
};
