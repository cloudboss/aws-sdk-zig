/// An object that represents summary details of a container within a job.
pub const ContainerSummary = struct {
    /// The exit code to return upon completion.
    exit_code: ?i32,

    /// A short (255 max characters) human-readable string to provide additional
    /// details for a
    /// running or stopped container.
    reason: ?[]const u8,

    pub const json_field_names = .{
        .exit_code = "exitCode",
        .reason = "reason",
    };
};
