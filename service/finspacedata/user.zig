const ApiAccess = @import("api_access.zig").ApiAccess;
const UserStatus = @import("user_status.zig").UserStatus;
const UserType = @import("user_type.zig").UserType;

/// The details of the user.
pub const User = struct {
    /// Indicates whether the user can use the `GetProgrammaticAccessCredentials`
    /// API to obtain credentials that can then be used to access other FinSpace
    /// Data API operations.
    ///
    /// * `ENABLED` – The user has permissions to use the APIs.
    ///
    /// * `DISABLED` – The user does not have permissions to use any APIs.
    api_access: ?ApiAccess,

    /// The ARN identifier of an AWS user or role that is allowed to call the
    /// `GetProgrammaticAccessCredentials` API to obtain a credentials token for a
    /// specific FinSpace user. This must be an IAM role within your FinSpace
    /// account.
    api_access_principal_arn: ?[]const u8,

    /// The timestamp at which the user was created in FinSpace. The value is
    /// determined as epoch time in milliseconds.
    create_time: i64 = 0,

    /// The email address of the user. The email address serves as a uniquer
    /// identifier for each user and cannot be changed after it's created.
    email_address: ?[]const u8,

    /// The first name of the user.
    first_name: ?[]const u8,

    /// Describes the last time the user was deactivated. The value is determined as
    /// epoch time in milliseconds.
    last_disabled_time: i64 = 0,

    /// Describes the last time the user was activated. The value is determined as
    /// epoch time in milliseconds.
    last_enabled_time: i64 = 0,

    /// Describes the last time that the user logged into their account. The value
    /// is determined as epoch time in milliseconds.
    last_login_time: i64 = 0,

    /// Describes the last time the user was updated. The value is determined as
    /// epoch time in milliseconds.
    last_modified_time: i64 = 0,

    /// The last name of the user.
    last_name: ?[]const u8,

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
    @"type": ?UserType,

    /// The unique identifier for the user.
    user_id: ?[]const u8,

    pub const json_field_names = .{
        .api_access = "apiAccess",
        .api_access_principal_arn = "apiAccessPrincipalArn",
        .create_time = "createTime",
        .email_address = "emailAddress",
        .first_name = "firstName",
        .last_disabled_time = "lastDisabledTime",
        .last_enabled_time = "lastEnabledTime",
        .last_login_time = "lastLoginTime",
        .last_modified_time = "lastModifiedTime",
        .last_name = "lastName",
        .status = "status",
        .@"type" = "type",
        .user_id = "userId",
    };
};
