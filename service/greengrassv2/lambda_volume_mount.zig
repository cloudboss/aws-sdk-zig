const LambdaFilesystemPermission = @import("lambda_filesystem_permission.zig").LambdaFilesystemPermission;

/// Contains information about a volume that Linux processes in a container can
/// access. When
/// you define a volume, the IoT Greengrass Core software mounts the source
/// files to the destination inside the
/// container.
pub const LambdaVolumeMount = struct {
    /// Whether or not to add the IoT Greengrass user group as an owner of the
    /// volume.
    ///
    /// Default: `false`
    add_group_owner: ?bool,

    /// The path to the logical volume in the file system.
    destination_path: []const u8,

    /// The permission to access the volume: read/only (`ro`) or read/write
    /// (`rw`).
    ///
    /// Default: `ro`
    permission: ?LambdaFilesystemPermission,

    /// The path to the physical volume in the file system.
    source_path: []const u8,

    pub const json_field_names = .{
        .add_group_owner = "addGroupOwner",
        .destination_path = "destinationPath",
        .permission = "permission",
        .source_path = "sourcePath",
    };
};
