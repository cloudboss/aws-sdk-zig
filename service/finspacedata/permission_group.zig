const ApplicationPermission = @import("application_permission.zig").ApplicationPermission;
const PermissionGroupMembershipStatus = @import("permission_group_membership_status.zig").PermissionGroupMembershipStatus;

/// The structure for a permission group.
pub const PermissionGroup = struct {
    /// Indicates the permissions that are granted to a specific group for accessing
    /// the FinSpace application.
    ///
    /// When assigning application permissions, be aware that the permission
    /// `ManageUsersAndGroups` allows users to grant themselves or others access to
    /// any functionality in their FinSpace environment's application. It should
    /// only be granted to trusted users.
    ///
    /// * `CreateDataset` – Group members can create new datasets.
    ///
    /// * `ManageClusters` – Group members can manage Apache Spark clusters from
    ///   FinSpace notebooks.
    ///
    /// * `ManageUsersAndGroups` – Group members can manage users and permission
    ///   groups. This is a privileged permission that allows users to grant
    ///   themselves or others access to any functionality in the application. It
    ///   should only be granted to trusted users.
    ///
    /// * `ManageAttributeSets` – Group members can manage attribute sets.
    ///
    /// * `ViewAuditData` – Group members can view audit data.
    ///
    /// * `AccessNotebooks` – Group members will have access to FinSpace notebooks.
    ///
    /// * `GetTemporaryCredentials` – Group members can get temporary API
    ///   credentials.
    application_permissions: ?[]const ApplicationPermission = null,

    /// The timestamp at which the group was created in FinSpace. The value is
    /// determined as epoch time in milliseconds.
    create_time: i64 = 0,

    /// A brief description for the permission group.
    description: ?[]const u8 = null,

    /// Describes the last time the permission group was updated. The value is
    /// determined as epoch time in milliseconds.
    last_modified_time: i64 = 0,

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
    membership_status: ?PermissionGroupMembershipStatus = null,

    /// The name of the permission group.
    name: ?[]const u8 = null,

    /// The unique identifier for the permission group.
    permission_group_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_permissions = "applicationPermissions",
        .create_time = "createTime",
        .description = "description",
        .last_modified_time = "lastModifiedTime",
        .membership_status = "membershipStatus",
        .name = "name",
        .permission_group_id = "permissionGroupId",
    };
};
