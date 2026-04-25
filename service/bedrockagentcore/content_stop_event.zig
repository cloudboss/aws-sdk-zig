const CommandExecutionStatus = @import("command_execution_status.zig").CommandExecutionStatus;

/// An event that signals the completion of a command execution. This event
/// contains the final status and exit code of the executed command.
pub const ContentStopEvent = struct {
    /// The exit code returned by the executed command. An exit code of 0 indicates
    /// successful execution, -1 indicates a platform error, and values greater than
    /// 0 indicate command-specific errors.
    exit_code: i32,

    /// The final status of the command execution. Valid values are `COMPLETED` for
    /// successful completion or `TIMED_OUT` if the command exceeded the specified
    /// timeout.
    status: CommandExecutionStatus,

    pub const json_field_names = .{
        .exit_code = "exitCode",
        .status = "status",
    };
};
