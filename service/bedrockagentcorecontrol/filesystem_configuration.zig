const SessionStorageConfiguration = @import("session_storage_configuration.zig").SessionStorageConfiguration;

/// Configuration for a filesystem that can be mounted into the AgentCore
/// Runtime.
pub const FilesystemConfiguration = union(enum) {
    /// Configuration for session storage. Session storage provides persistent
    /// storage that is preserved across AgentCore Runtime session invocations.
    session_storage: ?SessionStorageConfiguration,

    pub const json_field_names = .{
        .session_storage = "sessionStorage",
    };
};
