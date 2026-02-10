const PermissionGroup = @import("permission_group.zig").PermissionGroup;

/// Describes a launch permission.
pub const LaunchPermission = struct {
    /// The name of the group.
    group: ?PermissionGroup,

    /// The Amazon Resource Name (ARN) of an organizational unit (OU).
    organizational_unit_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of an organization.
    organization_arn: ?[]const u8,

    /// The Amazon Web Services account ID.
    ///
    /// Constraints: Up to 10 000 account IDs can be specified in a single request.
    user_id: ?[]const u8,
};
