const PermissionGroup = @import("permission_group.zig").PermissionGroup;

/// Describes the user or group to be added or removed from the list of create
/// volume
/// permissions for a volume.
pub const CreateVolumePermission = struct {
    /// The group to be added or removed. The possible value is `all`.
    group: ?PermissionGroup,

    /// The ID of the Amazon Web Services account to be added or removed.
    user_id: ?[]const u8,
};
