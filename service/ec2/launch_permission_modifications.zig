const LaunchPermission = @import("launch_permission.zig").LaunchPermission;

/// Describes a launch permission modification.
pub const LaunchPermissionModifications = struct {
    /// The Amazon Web Services account ID, organization ARN, or OU ARN to add to
    /// the list of
    /// launch permissions for the AMI.
    add: ?[]const LaunchPermission,

    /// The Amazon Web Services account ID, organization ARN, or OU ARN to remove
    /// from the list of
    /// launch permissions for the AMI.
    remove: ?[]const LaunchPermission,
};
