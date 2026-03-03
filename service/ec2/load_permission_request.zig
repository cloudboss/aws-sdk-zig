const PermissionGroup = @import("permission_group.zig").PermissionGroup;

/// Describes a load permission.
pub const LoadPermissionRequest = struct {
    /// The name of the group.
    group: ?PermissionGroup = null,

    /// The Amazon Web Services account ID.
    user_id: ?[]const u8 = null,
};
