const IngressPointPasswordConfiguration = @import("ingress_point_password_configuration.zig").IngressPointPasswordConfiguration;
const TlsAuthConfiguration = @import("tls_auth_configuration.zig").TlsAuthConfiguration;

/// The authentication configuration for the ingress endpoint resource.
pub const IngressPointAuthConfiguration = struct {
    /// The ingress endpoint password configuration for the ingress endpoint
    /// resource.
    ingress_point_password_configuration: ?IngressPointPasswordConfiguration = null,

    /// The ingress endpoint SecretsManager::Secret ARN configuration for the
    /// ingress endpoint resource.
    secret_arn: ?[]const u8 = null,

    /// The mutual TLS authentication configuration for the ingress endpoint
    /// resource.
    tls_auth_configuration: ?TlsAuthConfiguration = null,

    pub const json_field_names = .{
        .ingress_point_password_configuration = "IngressPointPasswordConfiguration",
        .secret_arn = "SecretArn",
        .tls_auth_configuration = "TlsAuthConfiguration",
    };
};
