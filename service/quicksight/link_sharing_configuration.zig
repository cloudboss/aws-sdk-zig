const ResourcePermission = @import("resource_permission.zig").ResourcePermission;

/// A structure that contains the configuration of a shareable link to the
/// dashboard.
pub const LinkSharingConfiguration = struct {
    /// A structure that contains the permissions of a shareable link.
    permissions: ?[]const ResourcePermission,

    pub const json_field_names = .{
        .permissions = "Permissions",
    };
};
