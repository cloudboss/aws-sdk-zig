/// Provides a summary of SSL/TLS certificate metadata.
pub const LoadBalancerTlsCertificateSummary = struct {
    /// When `true`, the SSL/TLS certificate is attached to the Lightsail load
    /// balancer.
    is_attached: ?bool = null,

    /// The name of the SSL/TLS certificate.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .is_attached = "isAttached",
        .name = "name",
    };
};
