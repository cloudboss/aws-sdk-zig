const TLSSecurityPolicy = @import("tls_security_policy.zig").TLSSecurityPolicy;

/// The domain's endpoint options.
pub const DomainEndpointOptions = struct {
    /// Whether the domain is HTTPS only enabled.
    enforce_https: ?bool = null,

    /// The minimum required TLS version
    tls_security_policy: ?TLSSecurityPolicy = null,
};
