const DmsSslModeValue = @import("dms_ssl_mode_value.zig").DmsSslModeValue;

/// Provides information about an IBM DB2 for z/OS data provider.
pub const IbmDb2zOsDataProviderSettings = struct {
    /// The Amazon Resource Name (ARN) of the certificate used for SSL connection.
    certificate_arn: ?[]const u8,

    /// The database name on the DB2 for z/OS data provider.
    database_name: ?[]const u8,

    /// The port value for the DB2 for z/OS data provider.
    port: ?i32,

    /// The ARN for the role the application uses to access its Amazon S3 bucket.
    s3_access_role_arn: ?[]const u8,

    /// The path for the Amazon S3 bucket that the application uses for accessing
    /// the user-defined schema.
    s3_path: ?[]const u8,

    /// The name of the DB2 for z/OS server.
    server_name: ?[]const u8,

    /// The SSL mode used to connect to the DB2 for z/OS data provider.
    /// The default value is `none`. Valid Values: `none` and `verify-ca`.
    ssl_mode: ?DmsSslModeValue,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .database_name = "DatabaseName",
        .port = "Port",
        .s3_access_role_arn = "S3AccessRoleArn",
        .s3_path = "S3Path",
        .server_name = "ServerName",
        .ssl_mode = "SslMode",
    };
};
