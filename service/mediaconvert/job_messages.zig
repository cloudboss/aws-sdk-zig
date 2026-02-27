/// Provides messages from the service about jobs that you have already
/// successfully submitted.
pub const JobMessages = struct {
    /// List of messages that are informational only and don't indicate a problem
    /// with your job.
    info: ?[]const []const u8,

    /// List of messages that warn about conditions that might cause your job not to
    /// run or to fail.
    warning: ?[]const []const u8,

    pub const json_field_names = .{
        .info = "Info",
        .warning = "Warning",
    };
};
