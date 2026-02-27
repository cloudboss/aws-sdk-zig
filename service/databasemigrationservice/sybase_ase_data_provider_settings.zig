const DmsSslModeValue = @import("dms_ssl_mode_value.zig").DmsSslModeValue;

/// Provides information that defines an SAP ASE data provider.
pub const SybaseAseDataProviderSettings = struct {
    /// The Amazon Resource Name (ARN) of the certificate used for SSL connection.
    certificate_arn: ?[]const u8,

    /// The database name on the SAP ASE data provider.
    database_name: ?[]const u8,

    /// Specifies whether to encrypt the password when connecting to the Sybase ASE
    /// database. When set to true, the connection password is encrypted during
    /// transmission. Default is true.
    encrypt_password: ?bool,

    /// The port value for the SAP ASE data provider.
    port: ?i32,

    /// The name of the SAP ASE server.
    server_name: ?[]const u8,

    /// The SSL mode used to connect to the SAP ASE data provider.
    /// The default value is `none`.
    ssl_mode: ?DmsSslModeValue,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .database_name = "DatabaseName",
        .encrypt_password = "EncryptPassword",
        .port = "Port",
        .server_name = "ServerName",
        .ssl_mode = "SslMode",
    };
};
