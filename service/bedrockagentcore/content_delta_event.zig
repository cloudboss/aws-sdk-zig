/// An event that contains incremental output from a command execution. This
/// event streams standard output and standard error content as it becomes
/// available during command execution.
pub const ContentDeltaEvent = struct {
    /// The standard error content from the command execution. This field contains
    /// the incremental output written to stderr by the executing command.
    stderr: ?[]const u8 = null,

    /// The standard output content from the command execution. This field contains
    /// the incremental output written to stdout by the executing command.
    stdout: ?[]const u8 = null,

    pub const json_field_names = .{
        .stderr = "stderr",
        .stdout = "stdout",
    };
};
