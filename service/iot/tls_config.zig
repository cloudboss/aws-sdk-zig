/// An object that specifies the TLS configuration for a domain.
pub const TlsConfig = struct {
    /// The security policy for a domain configuration. For more information, see
    /// [Security
    /// policies
    /// ](https://docs.aws.amazon.com/iot/latest/developerguide/transport-security.html#tls-policy-table) in the *Amazon Web Services IoT Core developer
    /// guide*.
    security_policy: ?[]const u8,

    pub const json_field_names = .{
        .security_policy = "securityPolicy",
    };
};
