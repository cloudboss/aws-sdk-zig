const TlsAuthConfiguration = @import("tls_auth_configuration.zig").TlsAuthConfiguration;

/// The configuration of the ingress endpoint resource.
pub const IngressPointConfiguration = union(enum) {
    /// The SecretsManager::Secret ARN of the ingress endpoint resource.
    secret_arn: ?[]const u8,
    /// The password of the ingress endpoint resource.
    smtp_password: ?[]const u8,
    /// The mutual TLS authentication configuration of the ingress endpoint
    /// resource.
    tls_auth_configuration: ?TlsAuthConfiguration,

    pub const json_field_names = .{
        .secret_arn = "SecretArn",
        .smtp_password = "SmtpPassword",
        .tls_auth_configuration = "TlsAuthConfiguration",
    };
};
