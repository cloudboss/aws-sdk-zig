const TlsPolicy = @import("tls_policy.zig").TlsPolicy;

/// Used to associate a configuration set with a dedicated IP pool.
pub const DeliveryOptions = struct {
    /// The name of the dedicated IP pool that you want to associate with the
    /// configuration
    /// set.
    sending_pool_name: ?[]const u8,

    /// Specifies whether messages that use the configuration set are required to
    /// use
    /// Transport Layer Security (TLS). If the value is `Require`, messages are only
    /// delivered if a TLS connection can be established. If the value is
    /// `Optional`,
    /// messages can be delivered in plain text if a TLS connection can't be
    /// established.
    tls_policy: ?TlsPolicy,

    pub const json_field_names = .{
        .sending_pool_name = "SendingPoolName",
        .tls_policy = "TlsPolicy",
    };
};
