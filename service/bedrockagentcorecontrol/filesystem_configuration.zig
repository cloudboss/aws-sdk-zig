const EfsAccessPointConfiguration = @import("efs_access_point_configuration.zig").EfsAccessPointConfiguration;
const S3FilesAccessPointConfiguration = @import("s3_files_access_point_configuration.zig").S3FilesAccessPointConfiguration;
const SessionStorageConfiguration = @import("session_storage_configuration.zig").SessionStorageConfiguration;

/// Configuration for a filesystem that can be mounted into the AgentCore
/// Runtime.
pub const FilesystemConfiguration = union(enum) {
    /// Configuration for an Amazon EFS access point to mount into the AgentCore
    /// Runtime.
    efs_access_point: ?EfsAccessPointConfiguration,
    /// Configuration for an Amazon S3 Files access point to mount into the
    /// AgentCore Runtime.
    s_3_files_access_point: ?S3FilesAccessPointConfiguration,
    /// Configuration for session storage. Session storage provides persistent
    /// storage that is preserved across AgentCore Runtime session invocations.
    session_storage: ?SessionStorageConfiguration,

    pub const json_field_names = .{
        .efs_access_point = "efsAccessPoint",
        .s_3_files_access_point = "s3FilesAccessPoint",
        .session_storage = "sessionStorage",
    };
};
