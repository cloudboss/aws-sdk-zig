const Permission = @import("permission.zig").Permission;

/// The owner setting for downloaded machine learning resources.
pub const ResourceDownloadOwnerSetting = struct {
    /// The group owner of the resource. This is the name of an existing Linux OS
    /// group on the system or a GID. The group's permissions are added to the
    /// Lambda process.
    group_owner: []const u8,

    /// The permissions that the group owner has to the resource. Valid values are
    /// ''rw'' (read/write) or ''ro'' (read-only).
    group_permission: Permission,

    pub const json_field_names = .{
        .group_owner = "GroupOwner",
        .group_permission = "GroupPermission",
    };
};
