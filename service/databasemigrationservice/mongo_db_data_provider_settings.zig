const AuthMechanismValue = @import("auth_mechanism_value.zig").AuthMechanismValue;
const AuthTypeValue = @import("auth_type_value.zig").AuthTypeValue;
const DmsSslModeValue = @import("dms_ssl_mode_value.zig").DmsSslModeValue;

/// Provides information that defines a MongoDB data provider.
pub const MongoDbDataProviderSettings = struct {
    /// The authentication method for connecting to the data provider. Valid values
    /// are DEFAULT, MONGODB_CR, or SCRAM_SHA_1.
    auth_mechanism: ?AuthMechanismValue = null,

    /// The MongoDB database name. This setting isn't used when `AuthType` is
    /// set to `"no"`.
    ///
    /// The default is `"admin"`.
    auth_source: ?[]const u8 = null,

    /// The authentication type for the database connection. Valid values are
    /// PASSWORD or NO.
    auth_type: ?AuthTypeValue = null,

    /// The Amazon Resource Name (ARN) of the certificate used for SSL connection.
    certificate_arn: ?[]const u8 = null,

    /// The database name on the MongoDB data provider.
    database_name: ?[]const u8 = null,

    /// The port value for the MongoDB data provider.
    port: ?i32 = null,

    /// The name of the MongoDB server.
    server_name: ?[]const u8 = null,

    /// The SSL mode used to connect to the MongoDB data provider.
    /// The default value is `none`.
    ssl_mode: ?DmsSslModeValue = null,

    pub const json_field_names = .{
        .auth_mechanism = "AuthMechanism",
        .auth_source = "AuthSource",
        .auth_type = "AuthType",
        .certificate_arn = "CertificateArn",
        .database_name = "DatabaseName",
        .port = "Port",
        .server_name = "ServerName",
        .ssl_mode = "SslMode",
    };
};
