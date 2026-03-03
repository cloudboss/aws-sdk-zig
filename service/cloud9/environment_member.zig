const Permissions = @import("permissions.zig").Permissions;

/// Information about an environment member for an Cloud9 development
/// environment.
pub const EnvironmentMember = struct {
    /// The ID of the environment for the environment member.
    environment_id: []const u8,

    /// The time, expressed in epoch time format, when the environment member last
    /// opened the
    /// environment.
    last_access: ?i64 = null,

    /// The type of environment member permissions associated with this environment
    /// member.
    /// Available values include:
    ///
    /// * `owner`: Owns the environment.
    ///
    /// * `read-only`: Has read-only access to the environment.
    ///
    /// * `read-write`: Has read-write access to the environment.
    permissions: Permissions,

    /// The Amazon Resource Name (ARN) of the environment member.
    user_arn: []const u8,

    /// The user ID in Identity and Access Management (IAM) of the environment
    /// member.
    user_id: []const u8,

    pub const json_field_names = .{
        .environment_id = "environmentId",
        .last_access = "lastAccess",
        .permissions = "permissions",
        .user_arn = "userArn",
        .user_id = "userId",
    };
};
