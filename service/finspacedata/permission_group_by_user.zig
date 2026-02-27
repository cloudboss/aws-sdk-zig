const PermissionGroupMembershipStatus = @import("permission_group_membership_status.zig").PermissionGroupMembershipStatus;

/// The structure of a permission group associated with a user.
pub const PermissionGroupByUser = struct {
    /// Indicates the status of the user within a permission group.
    ///
    /// * `ADDITION_IN_PROGRESS` – The user is currently being added to the
    ///   permission group.
    ///
    /// * `ADDITION_SUCCESS` – The user is successfully added to the permission
    ///   group.
    ///
    /// * `REMOVAL_IN_PROGRESS` – The user is currently being removed from the
    ///   permission group.
    membership_status: ?PermissionGroupMembershipStatus,

    /// The name of the permission group.
    name: ?[]const u8,

    /// The unique identifier for the permission group.
    permission_group_id: ?[]const u8,

    pub const json_field_names = .{
        .membership_status = "membershipStatus",
        .name = "name",
        .permission_group_id = "permissionGroupId",
    };
};
