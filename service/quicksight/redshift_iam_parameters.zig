/// A structure that grants Quick Sight access to your cluster and make a call
/// to the `redshift:GetClusterCredentials` API. For more information on the
/// `redshift:GetClusterCredentials` API, see [
/// `GetClusterCredentials`
/// ](https://docs.aws.amazon.com/redshift/latest/APIReference/API_GetClusterCredentials.html).
pub const RedshiftIAMParameters = struct {
    /// Automatically creates a database user. If your database doesn't have a
    /// `DatabaseUser`, set this parameter to `True`. If there is no `DatabaseUser`,
    /// Quick Sight can't connect to your cluster. The `RoleArn` that you use for
    /// this operation must grant access to `redshift:CreateClusterUser` to
    /// successfully create the user.
    auto_create_database_user: bool = false,

    /// A list of groups whose permissions will be granted to Quick Sight to access
    /// the cluster. These permissions are combined with the permissions granted to
    /// Quick Sight by the `DatabaseUser`. If you choose to include this parameter,
    /// the `RoleArn` must grant access to `redshift:JoinGroup`.
    database_groups: ?[]const []const u8 = null,

    /// The user whose permissions and group memberships will be used by Quick Sight
    /// to access the cluster. If this user already exists in your database, Amazon
    /// Quick Sight is granted the same permissions that the user has. If the user
    /// doesn't exist, set the value of `AutoCreateDatabaseUser` to `True` to create
    /// a new user with PUBLIC permissions.
    database_user: ?[]const u8 = null,

    /// Use the `RoleArn` structure to allow Quick Sight to call
    /// `redshift:GetClusterCredentials` on your cluster. The calling principal must
    /// have `iam:PassRole` access to pass the role to Quick Sight. The role's trust
    /// policy must allow the Quick Sight service principal to assume the role.
    role_arn: []const u8,

    pub const json_field_names = .{
        .auto_create_database_user = "AutoCreateDatabaseUser",
        .database_groups = "DatabaseGroups",
        .database_user = "DatabaseUser",
        .role_arn = "RoleArn",
    };
};
