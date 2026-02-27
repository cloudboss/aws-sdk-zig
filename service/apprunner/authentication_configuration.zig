/// Describes resources needed to authenticate access to some source
/// repositories. The specific resource depends on the repository provider.
pub const AuthenticationConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the IAM role that grants the App Runner
    /// service access to a source repository. It's required for ECR image
    /// repositories
    /// (but not for ECR Public repositories).
    access_role_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the App Runner connection that enables the
    /// App Runner service to connect to a source repository. It's required for
    /// GitHub code
    /// repositories.
    connection_arn: ?[]const u8,

    pub const json_field_names = .{
        .access_role_arn = "AccessRoleArn",
        .connection_arn = "ConnectionArn",
    };
};
