/// Provides information that defines a SAP ASE endpoint.
pub const SybaseSettings = struct {
    /// Database name for the endpoint.
    database_name: ?[]const u8,

    /// Endpoint connection password.
    password: ?[]const u8,

    /// Endpoint TCP port. The default is 5000.
    port: ?i32,

    /// The full Amazon Resource Name (ARN) of the IAM role that specifies DMS as
    /// the trusted
    /// entity and grants the required permissions to access the value in
    /// `SecretsManagerSecret`. The role must allow the `iam:PassRole`
    /// action. `SecretsManagerSecret` has the value of the Amazon Web Services
    /// Secrets Manager secret that
    /// allows access to the SAP ASE endpoint.
    ///
    /// You can specify one of two sets of values for these permissions. You can
    /// specify the
    /// values for this setting and `SecretsManagerSecretId`. Or you can specify
    /// clear-text values for `UserName`, `Password`,
    /// `ServerName`, and `Port`. You can't specify both. For more
    /// information on creating this `SecretsManagerSecret` and the
    /// `SecretsManagerAccessRoleArn` and `SecretsManagerSecretId`
    /// required to access it, see [Using secrets to access Database Migration
    /// Service
    /// resources](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Security.html#security-iam-secretsmanager) in the
    /// *Database Migration Service User Guide*.
    secrets_manager_access_role_arn: ?[]const u8,

    /// The full ARN, partial ARN, or friendly name of the `SecretsManagerSecret`
    /// that contains the SAP SAE endpoint connection details.
    secrets_manager_secret_id: ?[]const u8,

    /// Fully qualified domain name of the endpoint.
    server_name: ?[]const u8,

    /// Endpoint connection user name.
    username: ?[]const u8,

    pub const json_field_names = .{
        .database_name = "DatabaseName",
        .password = "Password",
        .port = "Port",
        .secrets_manager_access_role_arn = "SecretsManagerAccessRoleArn",
        .secrets_manager_secret_id = "SecretsManagerSecretId",
        .server_name = "ServerName",
        .username = "Username",
    };
};
