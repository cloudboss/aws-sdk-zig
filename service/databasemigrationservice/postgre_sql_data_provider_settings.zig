const DmsSslModeValue = @import("dms_ssl_mode_value.zig").DmsSslModeValue;

/// Provides information that defines a PostgreSQL data provider.
pub const PostgreSqlDataProviderSettings = struct {
    /// The Amazon Resource Name (ARN) of the certificate used for SSL connection.
    certificate_arn: ?[]const u8,

    /// The database name on the PostgreSQL data provider.
    database_name: ?[]const u8,

    /// The port value for the PostgreSQL data provider.
    port: ?i32,

    /// The ARN for the role the application uses to access its Amazon S3 bucket.
    s3_access_role_arn: ?[]const u8,

    /// The path for the Amazon S3 bucket that the application uses for accessing
    /// the user-defined schema.
    s3_path: ?[]const u8,

    /// The name of the PostgreSQL server.
    server_name: ?[]const u8,

    /// The SSL mode used to connect to the PostgreSQL data provider.
    /// The default value is `none`.
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
