const DmsSslModeValue = @import("dms_ssl_mode_value.zig").DmsSslModeValue;

/// Provides information that defines an Oracle data provider.
pub const OracleDataProviderSettings = struct {
    /// The address of your Oracle Automatic Storage Management (ASM) server. You
    /// can set
    /// this value from the `asm_server` value. You set `asm_server` as part
    /// of the extra connection attribute string to access an Oracle server with
    /// Binary Reader that
    /// uses ASM. For more information, see [Configuration for change data capture
    /// (CDC) on an Oracle source
    /// database](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.Oracle.html#dms/latest/userguide/CHAP_Source.Oracle.html#CHAP_Source.Oracle.CDC.Configuration).
    asm_server: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the certificate used for SSL connection.
    certificate_arn: ?[]const u8 = null,

    /// The database name on the Oracle data provider.
    database_name: ?[]const u8 = null,

    /// The port value for the Oracle data provider.
    port: ?i32 = null,

    /// The ARN for the role the application uses to access its Amazon S3 bucket.
    s3_access_role_arn: ?[]const u8 = null,

    /// The path for the Amazon S3 bucket that the application uses for accessing
    /// the user-defined schema.
    s3_path: ?[]const u8 = null,

    /// The ARN of the IAM role that provides access to the secret in Secrets
    /// Manager
    /// that contains the Oracle ASM connection details.
    secrets_manager_oracle_asm_access_role_arn: ?[]const u8 = null,

    /// The identifier of the secret in Secrets Manager that contains the Oracle ASM
    /// connection details.
    ///
    /// Required only if your data provider uses the Oracle ASM server.
    secrets_manager_oracle_asm_secret_id: ?[]const u8 = null,

    /// The ARN of the IAM role that provides access to the secret in Secrets
    /// Manager
    /// that contains the TDE password.
    secrets_manager_security_db_encryption_access_role_arn: ?[]const u8 = null,

    /// The identifier of the secret in Secrets Manager that contains the
    /// transparent data encryption (TDE)
    /// password. DMS requires this password to access Oracle redo logs encrypted by
    /// TDE
    /// using Binary Reader.
    secrets_manager_security_db_encryption_secret_id: ?[]const u8 = null,

    /// The name of the Oracle server.
    server_name: ?[]const u8 = null,

    /// The SSL mode used to connect to the Oracle data provider.
    /// The default value is `none`.
    ssl_mode: ?DmsSslModeValue = null,

    pub const json_field_names = .{
        .asm_server = "AsmServer",
        .certificate_arn = "CertificateArn",
        .database_name = "DatabaseName",
        .port = "Port",
        .s3_access_role_arn = "S3AccessRoleArn",
        .s3_path = "S3Path",
        .secrets_manager_oracle_asm_access_role_arn = "SecretsManagerOracleAsmAccessRoleArn",
        .secrets_manager_oracle_asm_secret_id = "SecretsManagerOracleAsmSecretId",
        .secrets_manager_security_db_encryption_access_role_arn = "SecretsManagerSecurityDbEncryptionAccessRoleArn",
        .secrets_manager_security_db_encryption_secret_id = "SecretsManagerSecurityDbEncryptionSecretId",
        .server_name = "ServerName",
        .ssl_mode = "SslMode",
    };
};
