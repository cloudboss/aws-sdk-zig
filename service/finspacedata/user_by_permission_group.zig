const ApiAccess = @import("api_access.zig").ApiAccess;
const PermissionGroupMembershipStatus = @import("permission_group_membership_status.zig").PermissionGroupMembershipStatus;
const UserStatus = @import("user_status.zig").UserStatus;
const UserType = @import("user_type.zig").UserType;

/// The structure of a user associated with a permission group.
pub const UserByPermissionGroup = struct {
    /// Indicates whether the user can access FinSpace API operations.
    ///
    /// * `ENABLED` – The user has permissions to use the API operations.
    ///
    /// * `DISABLED` – The user does not have permissions to use any API operations.
    api_access: ?ApiAccess,

    /// The IAM ARN identifier that is attached to FinSpace API calls.
    api_access_principal_arn: ?[]const u8,

    /// The email address of the user. The email address serves as a unique
    /// identifier for each user and cannot be changed after it's created.
    email_address: ?[]const u8,

    /// The first name of the user.
    first_name: ?[]const u8,

    /// The last name of the user.
    last_name: ?[]const u8,

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

    /// The current status of the user.
    ///
    /// * `CREATING` – The user creation is in progress.
    ///
    /// * `ENABLED` – The user is created and is currently active.
    ///
    /// * `DISABLED` – The user is currently inactive.
    status: ?UserStatus,

    /// Indicates the type of user.
    ///
    /// * `SUPER_USER` – A user with permission to all the functionality and data in
    ///   FinSpace.
    ///
    /// * `APP_USER` – A user with specific permissions in FinSpace. The users are
    ///   assigned permissions by adding them to a permission group.
    type: ?UserType,

    /// The unique identifier for the user.
    user_id: ?[]const u8,

    pub const json_field_names = .{
        .api_access = "apiAccess",
        .api_access_principal_arn = "apiAccessPrincipalArn",
        .email_address = "emailAddress",
        .first_name = "firstName",
        .last_name = "lastName",
        .membership_status = "membershipStatus",
        .status = "status",
        .type = "type",
        .user_id = "userId",
    };
};
