const OpenZFSClientConfiguration = @import("open_zfs_client_configuration.zig").OpenZFSClientConfiguration;

/// The Network File System (NFS) configurations for mounting an Amazon FSx for
/// OpenZFS file system.
pub const OpenZFSNfsExport = struct {
    /// A list of configuration objects that contain the client and options for
    /// mounting the
    /// OpenZFS file system.
    client_configurations: []const OpenZFSClientConfiguration,

    pub const json_field_names = .{
        .client_configurations = "ClientConfigurations",
    };
};
