const LogsLocation = @import("logs_location.zig").LogsLocation;
const CommandType = @import("command_type.zig").CommandType;

/// Contains command execution information.
pub const CommandExecution = struct {
    /// The command that needs to be executed.
    command: ?[]const u8,

    /// When the command execution process ended, expressed in Unix time format.
    end_time: ?i64,

    /// The exit code to return upon completion.
    exit_code: ?[]const u8,

    /// The ID of the command execution.
    id: ?[]const u8,

    logs: ?LogsLocation,

    /// A `sandboxArn`.
    sandbox_arn: ?[]const u8,

    /// A `sandboxId`.
    sandbox_id: ?[]const u8,

    /// The text written by the command to stderr.
    standard_err_content: ?[]const u8,

    /// The text written by the command to stdout.
    standard_output_content: ?[]const u8,

    /// When the command execution process started, expressed in Unix time format.
    start_time: ?i64,

    /// The status of the command execution.
    status: ?[]const u8,

    /// When the command execution process was initially submitted, expressed in
    /// Unix time format.
    submit_time: ?i64,

    /// The command type.
    type: ?CommandType,

    pub const json_field_names = .{
        .command = "command",
        .end_time = "endTime",
        .exit_code = "exitCode",
        .id = "id",
        .logs = "logs",
        .sandbox_arn = "sandboxArn",
        .sandbox_id = "sandboxId",
        .standard_err_content = "standardErrContent",
        .standard_output_content = "standardOutputContent",
        .start_time = "startTime",
        .status = "status",
        .submit_time = "submitTime",
        .type = "type",
    };
};
