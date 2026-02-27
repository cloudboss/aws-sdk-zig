const IngressPointPasswordConfiguration = @import("ingress_point_password_configuration.zig").IngressPointPasswordConfiguration;

/// The authentication configuration for the ingress endpoint resource.
pub const IngressPointAuthConfiguration = struct {
    /// The ingress endpoint password configuration for the ingress endpoint
    /// resource.
    ingress_point_password_configuration: ?IngressPointPasswordConfiguration,

    /// The ingress endpoint SecretsManager::Secret ARN configuration for the
    /// ingress endpoint resource.
    secret_arn: ?[]const u8,

    pub const json_field_names = .{
        .ingress_point_password_configuration = "IngressPointPasswordConfiguration",
        .secret_arn = "SecretArn",
    };
};
