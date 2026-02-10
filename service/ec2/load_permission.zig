const PermissionGroup = @import("permission_group.zig").PermissionGroup;

/// Describes a load permission.
pub const LoadPermission = struct {
    /// The name of the group.
    group: ?PermissionGroup,

    /// The Amazon Web Services account ID.
    user_id: ?[]const u8,
};
