const DmsSslModeValue = @import("dms_ssl_mode_value.zig").DmsSslModeValue;

/// Provides information that defines a MariaDB data provider.
pub const MariaDbDataProviderSettings = struct {
    /// The Amazon Resource Name (ARN) of the certificate used for SSL connection.
    certificate_arn: ?[]const u8 = null,

    /// The port value for the MariaDB data provider
    port: ?i32 = null,

    /// The ARN for the role the application uses to access its Amazon S3 bucket.
    s3_access_role_arn: ?[]const u8 = null,

    /// The path for the Amazon S3 bucket that the application uses for accessing
    /// the user-defined schema.
    s3_path: ?[]const u8 = null,

    /// The name of the MariaDB server.
    server_name: ?[]const u8 = null,

    /// The SSL mode used to connect to the MariaDB data provider.
    /// The default value is `none`.
    ssl_mode: ?DmsSslModeValue = null,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .port = "Port",
        .s3_access_role_arn = "S3AccessRoleArn",
        .s3_path = "S3Path",
        .server_name = "ServerName",
        .ssl_mode = "SslMode",
    };
};
