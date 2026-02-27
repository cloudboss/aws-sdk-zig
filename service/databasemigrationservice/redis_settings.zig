const RedisAuthTypeValue = @import("redis_auth_type_value.zig").RedisAuthTypeValue;
const SslSecurityProtocolValue = @import("ssl_security_protocol_value.zig").SslSecurityProtocolValue;

/// Provides information that defines a Redis target endpoint.
pub const RedisSettings = struct {
    /// The password provided with the `auth-role` and `auth-token`
    /// options of the `AuthType` setting for a Redis target endpoint.
    auth_password: ?[]const u8,

    /// The type of authentication to perform when connecting to a Redis target.
    /// Options include
    /// `none`, `auth-token`, and `auth-role`. The
    /// `auth-token` option requires an `AuthPassword` value to be
    /// provided. The `auth-role` option requires `AuthUserName` and
    /// `AuthPassword` values to be provided.
    auth_type: ?RedisAuthTypeValue,

    /// The user name provided with the `auth-role` option of the
    /// `AuthType` setting for a Redis target endpoint.
    auth_user_name: ?[]const u8,

    /// Transmission Control Protocol (TCP) port for the endpoint.
    port: i32 = 0,

    /// Fully qualified domain name of the endpoint.
    server_name: []const u8,

    /// The Amazon Resource Name (ARN) for the certificate authority (CA) that DMS
    /// uses to
    /// connect to your Redis target endpoint.
    ssl_ca_certificate_arn: ?[]const u8,

    /// The connection to a Redis target endpoint using Transport Layer Security
    /// (TLS). Valid
    /// values include `plaintext` and `ssl-encryption`. The default is
    /// `ssl-encryption`. The `ssl-encryption` option makes an encrypted
    /// connection. Optionally, you can identify an Amazon Resource Name (ARN) for
    /// an SSL
    /// certificate authority (CA) using the `SslCaCertificateArn `setting. If an
    /// ARN
    /// isn't given for a CA, DMS uses the Amazon root CA.
    ///
    /// The `plaintext` option doesn't provide Transport Layer Security (TLS)
    /// encryption for traffic between endpoint and database.
    ssl_security_protocol: ?SslSecurityProtocolValue,

    pub const json_field_names = .{
        .auth_password = "AuthPassword",
        .auth_type = "AuthType",
        .auth_user_name = "AuthUserName",
        .port = "Port",
        .server_name = "ServerName",
        .ssl_ca_certificate_arn = "SslCaCertificateArn",
        .ssl_security_protocol = "SslSecurityProtocol",
    };
};
