/// Specifies whether messages that use the configuration set are required to
/// use
/// Transport Layer Security (TLS). If the value is `Require`, messages are only
/// delivered if a TLS connection can be established. If the value is
/// `Optional`,
/// messages can be delivered in plain text if a TLS connection can't be
/// established.
pub const TlsPolicy = enum {
    require,
    optional,

    pub const json_field_names = .{
        .require = "REQUIRE",
        .optional = "OPTIONAL",
    };
};
