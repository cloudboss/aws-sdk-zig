const AuthType = @import("auth_type.zig").AuthType;
const ServerType = @import("server_type.zig").ServerType;

/// Information about the credentials for a GitHub, GitHub Enterprise, GitLab,
/// GitLab Self Managed, or Bitbucket
/// repository.
pub const SourceCredentialsInfo = struct {
    /// The Amazon Resource Name (ARN) of the token.
    arn: ?[]const u8,

    /// The type of authentication used by the credentials. Valid options are OAUTH,
    /// BASIC_AUTH, PERSONAL_ACCESS_TOKEN, CODECONNECTIONS, or SECRETS_MANAGER.
    auth_type: ?AuthType,

    /// The connection ARN if your authType is CODECONNECTIONS or SECRETS_MANAGER.
    resource: ?[]const u8,

    /// The type of source provider. The valid options are GITHUB,
    /// GITHUB_ENTERPRISE, GITLAB, GITLAB_SELF_MANAGED, or
    /// BITBUCKET.
    server_type: ?ServerType,

    pub const json_field_names = .{
        .arn = "arn",
        .auth_type = "authType",
        .resource = "resource",
        .server_type = "serverType",
    };
};
