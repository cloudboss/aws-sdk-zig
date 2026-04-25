const ImpersonatedUser = @import("impersonated_user.zig").ImpersonatedUser;

/// Details about the Kubernetes user involved in a Kubernetes finding.
pub const KubernetesUserDetails = struct {
    /// The groups that include the user who called the Kubernetes API.
    groups: ?[]const []const u8 = null,

    /// Information about the impersonated user.
    impersonated_user: ?ImpersonatedUser = null,

    /// Entity that assumes the IAM role when Kubernetes RBAC permissions are
    /// assigned to that role.
    session_name: ?[]const []const u8 = null,

    /// The user ID of the user who called the Kubernetes API.
    uid: ?[]const u8 = null,

    /// The username of the user who called the Kubernetes API.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .groups = "Groups",
        .impersonated_user = "ImpersonatedUser",
        .session_name = "SessionName",
        .uid = "Uid",
        .username = "Username",
    };
};
