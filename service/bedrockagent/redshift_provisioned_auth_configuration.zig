const RedshiftProvisionedAuthType = @import("redshift_provisioned_auth_type.zig").RedshiftProvisionedAuthType;

/// Contains configurations for authentication to an Amazon Redshift provisioned
/// data warehouse. Specify the type of authentication to use in the `type`
/// field and include the corresponding field. If you specify IAM
/// authentication, you don't need to include another field.
pub const RedshiftProvisionedAuthConfiguration = struct {
    /// The database username for authentication to an Amazon Redshift provisioned
    /// data warehouse.
    database_user: ?[]const u8,

    /// The type of authentication to use.
    type: RedshiftProvisionedAuthType,

    /// The ARN of an Secrets Manager secret for authentication.
    username_password_secret_arn: ?[]const u8,

    pub const json_field_names = .{
        .database_user = "databaseUser",
        .type = "type",
        .username_password_secret_arn = "usernamePasswordSecretArn",
    };
};
