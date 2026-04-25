const DmsSslModeValue = @import("dms_ssl_mode_value.zig").DmsSslModeValue;

/// Provides information about an IBM DB2 LUW data provider.
pub const IbmDb2LuwDataProviderSettings = struct {
    /// The Amazon Resource Name (ARN) of the certificate used for SSL connection.
    certificate_arn: ?[]const u8 = null,

    /// The database name on the DB2 LUW data provider.
    database_name: ?[]const u8 = null,

    /// The encryption algorithm used for securing the connection to the IBM DB2 LUW
    /// database server.
    /// You can provide an integer value corresponding to a specific encryption
    /// algorithm,
    /// or leave this parameter empty to use the default behavior.
    encryption_algorithm: ?i32 = null,

    /// The port value for the DB2 LUW data provider.
    port: ?i32 = null,

    /// The ARN for the role the application uses to access its Amazon S3 bucket.
    s3_access_role_arn: ?[]const u8 = null,

    /// The path for the Amazon S3 bucket that the application uses for accessing
    /// the user-defined schema.
    s3_path: ?[]const u8 = null,

    /// The security mechanism used for authenticating the connection to the IBM DB2
    /// LUW database server.
    /// You can provide an integer value corresponding to a specific security
    /// mechanism,
    /// or leave this parameter empty to use the default behavior.
    security_mechanism: ?i32 = null,

    /// The name of the DB2 LUW server.
    server_name: ?[]const u8 = null,

    /// The SSL mode used to connect to the DB2 LUW data provider.
    /// The default value is `none`. Valid Values: `none` and `verify-ca`.
    ssl_mode: ?DmsSslModeValue = null,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .database_name = "DatabaseName",
        .encryption_algorithm = "EncryptionAlgorithm",
        .port = "Port",
        .s3_access_role_arn = "S3AccessRoleArn",
        .s3_path = "S3Path",
        .security_mechanism = "SecurityMechanism",
        .server_name = "ServerName",
        .ssl_mode = "SslMode",
    };
};
