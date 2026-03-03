const LambdaFilesystemPermission = @import("lambda_filesystem_permission.zig").LambdaFilesystemPermission;

/// Contains information about a device that Linux processes in a container can
/// access.
pub const LambdaDeviceMount = struct {
    /// Whether or not to add the component's system user as an owner of the device.
    ///
    /// Default: `false`
    add_group_owner: ?bool = null,

    /// The mount path for the device in the file system.
    path: []const u8,

    /// The permission to access the device: read/only (`ro`) or read/write
    /// (`rw`).
    ///
    /// Default: `ro`
    permission: ?LambdaFilesystemPermission = null,

    pub const json_field_names = .{
        .add_group_owner = "addGroupOwner",
        .path = "path",
        .permission = "permission",
    };
};
