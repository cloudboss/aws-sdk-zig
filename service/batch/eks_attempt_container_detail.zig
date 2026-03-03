/// An object that represents the details for an attempt for a job attempt that
/// an Amazon EKS
/// container runs.
pub const EksAttemptContainerDetail = struct {
    /// The ID for the container.
    container_id: ?[]const u8 = null,

    /// The exit code returned for the job attempt. A non-zero exit code is
    /// considered
    /// failed.
    exit_code: ?i32 = null,

    /// The name of a container.
    name: ?[]const u8 = null,

    /// A short (255 max characters) human-readable string to provide additional
    /// details for a
    /// running or stopped container.
    reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .container_id = "containerID",
        .exit_code = "exitCode",
        .name = "name",
        .reason = "reason",
    };
};
