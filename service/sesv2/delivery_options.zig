const TlsPolicy = @import("tls_policy.zig").TlsPolicy;

/// Used to associate a configuration set with a dedicated IP pool.
pub const DeliveryOptions = struct {
    /// The maximum amount of time, in seconds, that Amazon SES API v2 will attempt
    /// delivery of email.
    /// If specified, the value must greater than or equal to 300 seconds (5
    /// minutes)
    /// and less than or equal to 50400 seconds (840 minutes).
    max_delivery_seconds: ?i64 = null,

    /// The name of the dedicated IP pool to associate with the configuration set.
    sending_pool_name: ?[]const u8 = null,

    /// Specifies whether messages that use the configuration set are required to
    /// use
    /// Transport Layer Security (TLS). If the value is `Require`, messages are only
    /// delivered if a TLS connection can be established. If the value is
    /// `Optional`,
    /// messages can be delivered in plain text if a TLS connection can't be
    /// established.
    tls_policy: ?TlsPolicy = null,

    pub const json_field_names = .{
        .max_delivery_seconds = "MaxDeliverySeconds",
        .sending_pool_name = "SendingPoolName",
        .tls_policy = "TlsPolicy",
    };
};
