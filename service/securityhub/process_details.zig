/// The details of process-related information about a finding.
pub const ProcessDetails = struct {
    /// Indicates when the process was launched.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    launched_at: ?[]const u8 = null,

    /// The name of the process.
    ///
    /// Length Constraints: Minimum of 1. Maximum of 64.
    name: ?[]const u8 = null,

    /// The parent process ID. This field accepts positive integers between `O` and
    /// `2147483647`.
    parent_pid: ?i32 = null,

    /// The path to the process executable.
    ///
    /// Length Constraints: Minimum of 1. Maximum of 512.
    path: ?[]const u8 = null,

    /// The process ID.
    pid: ?i32 = null,

    /// Indicates when the process was terminated.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    terminated_at: ?[]const u8 = null,

    pub const json_field_names = .{
        .launched_at = "LaunchedAt",
        .name = "Name",
        .parent_pid = "ParentPid",
        .path = "Path",
        .pid = "Pid",
        .terminated_at = "TerminatedAt",
    };
};
