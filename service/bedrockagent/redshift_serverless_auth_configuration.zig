const RedshiftServerlessAuthType = @import("redshift_serverless_auth_type.zig").RedshiftServerlessAuthType;

/// Specifies configurations for authentication to a Redshift Serverless.
/// Specify the type of authentication to use in the `type` field and include
/// the corresponding field. If you specify IAM authentication, you don't need
/// to include another field.
pub const RedshiftServerlessAuthConfiguration = struct {
    /// The type of authentication to use.
    type: RedshiftServerlessAuthType,

    /// The ARN of an Secrets Manager secret for authentication.
    username_password_secret_arn: ?[]const u8,

    pub const json_field_names = .{
        .type = "type",
        .username_password_secret_arn = "usernamePasswordSecretArn",
    };
};
