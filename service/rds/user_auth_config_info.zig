const AuthScheme = @import("auth_scheme.zig").AuthScheme;
const ClientPasswordAuthType = @import("client_password_auth_type.zig").ClientPasswordAuthType;
const IAMAuthMode = @import("iam_auth_mode.zig").IAMAuthMode;

/// Returns the details of authentication used by a proxy to log in as a
/// specific database user.
pub const UserAuthConfigInfo = struct {
    /// The type of authentication that the proxy uses for connections from the
    /// proxy to the underlying database.
    auth_scheme: ?AuthScheme = null,

    /// The type of authentication the proxy uses for connections from clients.
    client_password_auth_type: ?ClientPasswordAuthType = null,

    /// A user-specified description about the authentication used by a proxy to log
    /// in as a specific database user.
    description: ?[]const u8 = null,

    /// Whether to require or disallow Amazon Web Services Identity and Access
    /// Management (IAM) authentication for connections to the proxy.
    iam_auth: ?IAMAuthMode = null,

    /// The Amazon Resource Name (ARN) representing the secret that the proxy uses
    /// to authenticate to the RDS DB instance or Aurora DB cluster. These secrets
    /// are stored within Amazon Secrets Manager.
    secret_arn: ?[]const u8 = null,

    /// The name of the database user to which the proxy connects.
    user_name: ?[]const u8 = null,
};
