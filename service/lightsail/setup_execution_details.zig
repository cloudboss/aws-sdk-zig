const SetupStatus = @import("setup_status.zig").SetupStatus;

/// Returns details about the commands that were run.
pub const SetupExecutionDetails = struct {
    /// The command that was executed.
    command: ?[]const u8 = null,

    /// The timestamp for when the request was run.
    date_time: ?i64 = null,

    /// The name of the target resource.
    name: ?[]const u8 = null,

    /// The text written by the command to stderr.
    standard_error: ?[]const u8 = null,

    /// The text written by the command to stdout.
    standard_output: ?[]const u8 = null,

    /// The status of the `SetupInstanceHttps` request.
    status: ?SetupStatus = null,

    /// The current version of the script..
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .command = "command",
        .date_time = "dateTime",
        .name = "name",
        .standard_error = "standardError",
        .standard_output = "standardOutput",
        .status = "status",
        .version = "version",
    };
};
