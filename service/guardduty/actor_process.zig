/// Contains information about a process involved in a GuardDuty finding,
/// including process identification, execution details, and file information.
pub const ActorProcess = struct {
    /// The name of the process as it appears in the system.
    name: []const u8,

    /// The full file path to the process executable on the system.
    path: []const u8,

    /// The SHA256 hash of the process executable file, which can be used for
    /// identification and verification purposes.
    sha_256: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .path = "Path",
        .sha_256 = "Sha256",
    };
};
