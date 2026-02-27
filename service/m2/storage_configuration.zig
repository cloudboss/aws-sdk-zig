const EfsStorageConfiguration = @import("efs_storage_configuration.zig").EfsStorageConfiguration;
const FsxStorageConfiguration = @import("fsx_storage_configuration.zig").FsxStorageConfiguration;

/// Defines the storage configuration for a runtime environment.
pub const StorageConfiguration = union(enum) {
    /// Defines the storage configuration for an Amazon EFS file system.
    efs: ?EfsStorageConfiguration,
    /// Defines the storage configuration for an Amazon FSx file system.
    fsx: ?FsxStorageConfiguration,

    pub const json_field_names = .{
        .efs = "efs",
        .fsx = "fsx",
    };
};
