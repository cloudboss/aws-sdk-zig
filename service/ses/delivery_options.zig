const TlsPolicy = @import("tls_policy.zig").TlsPolicy;

/// Specifies whether messages that use the configuration set are required to
/// use
/// Transport Layer Security (TLS).
pub const DeliveryOptions = struct {
    /// Specifies whether messages that use the configuration set are required to
    /// use
    /// Transport Layer Security (TLS). If the value is `Require`, messages are only
    /// delivered if a TLS connection can be established. If the value is
    /// `Optional`,
    /// messages can be delivered in plain text if a TLS connection can't be
    /// established.
    tls_policy: ?TlsPolicy,
};
