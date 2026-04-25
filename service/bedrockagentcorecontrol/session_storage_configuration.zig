/// Configuration for a session storage filesystem mounted into the AgentCore
/// Runtime. Session storage provides persistent storage that is preserved
/// across AgentCore Runtime session invocations.
pub const SessionStorageConfiguration = struct {
    /// The mount path for the session storage filesystem inside the AgentCore
    /// Runtime. The path must be under `/mnt` with exactly one subdirectory level
    /// (for example, `/mnt/data`).
    mount_path: []const u8,

    pub const json_field_names = .{
        .mount_path = "mountPath",
    };
};
