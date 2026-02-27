/// Describes the TLS security policies that are available for Lightsail load
/// balancers.
///
/// For more information about load balancer TLS security policies, see
/// [Configuring TLS security policies on your Amazon Lightsail load
/// balancers](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-configure-load-balancer-tls-security-policy) in the *Amazon Lightsail Developer
/// Guide*.
pub const LoadBalancerTlsPolicy = struct {
    /// The ciphers used by the TLS security policy.
    ///
    /// The ciphers are listed in order of preference.
    ciphers: ?[]const []const u8,

    /// The description of the TLS security policy.
    description: ?[]const u8,

    /// A Boolean value that indicates whether the TLS security policy is the
    /// default.
    is_default: ?bool,

    /// The name of the TLS security policy.
    name: ?[]const u8,

    /// The protocols used in a given TLS security policy.
    protocols: ?[]const []const u8,

    pub const json_field_names = .{
        .ciphers = "ciphers",
        .description = "description",
        .is_default = "isDefault",
        .name = "name",
        .protocols = "protocols",
    };
};
