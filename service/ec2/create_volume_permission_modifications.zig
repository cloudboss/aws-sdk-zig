const CreateVolumePermission = @import("create_volume_permission.zig").CreateVolumePermission;

/// Describes modifications to the list of create volume permissions for a
/// volume.
pub const CreateVolumePermissionModifications = struct {
    /// Adds the specified Amazon Web Services account ID or group to the list.
    add: ?[]const CreateVolumePermission = null,

    /// Removes the specified Amazon Web Services account ID or group from the list.
    remove: ?[]const CreateVolumePermission = null,
};
