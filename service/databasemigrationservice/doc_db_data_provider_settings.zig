const DmsSslModeValue = @import("dms_ssl_mode_value.zig").DmsSslModeValue;

/// Provides information that defines a DocumentDB data provider.
pub const DocDbDataProviderSettings = struct {
    /// The Amazon Resource Name (ARN) of the certificate used for SSL connection.
    certificate_arn: ?[]const u8 = null,

    /// The database name on the DocumentDB data provider.
    database_name: ?[]const u8 = null,

    /// The port value for the DocumentDB data provider.
    port: ?i32 = null,

    /// The name of the source DocumentDB server.
    server_name: ?[]const u8 = null,

    /// The SSL mode used to connect to the DocumentDB data provider.
    /// The default value is `none`.
    ssl_mode: ?DmsSslModeValue = null,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .database_name = "DatabaseName",
        .port = "Port",
        .server_name = "ServerName",
        .ssl_mode = "SslMode",
    };
};
