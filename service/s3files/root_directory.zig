const CreationPermissions = @import("creation_permissions.zig").CreationPermissions;

/// Specifies the root directory path and optional creation permissions for
/// newly created directories.
pub const RootDirectory = struct {
    /// The permissions to set on newly created directories.
    creation_permissions: ?CreationPermissions = null,

    /// The path to use as the root directory for the access point.
    path: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_permissions = "creationPermissions",
        .path = "path",
    };
};
