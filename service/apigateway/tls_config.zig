/// Specifies the TLS configuration for an integration.
pub const TlsConfig = struct {
    /// Specifies whether or not API Gateway skips verification that the certificate
    /// for an integration endpoint is
    /// issued by a supported certificate authority. This isn’t recommended, but it
    /// enables you to
    /// use certificates that are signed by private certificate authorities, or
    /// certificates
    /// that are self-signed. If enabled, API Gateway still performs basic
    /// certificate
    /// validation, which includes checking the certificate's expiration date,
    /// hostname, and
    /// presence of a root certificate authority. Supported only for `HTTP` and
    /// `HTTP_PROXY` integrations.
    ///
    /// Enabling `insecureSkipVerification` isn't recommended, especially for
    /// integrations with public
    /// HTTPS endpoints. If you enable `insecureSkipVerification`, you increase the
    /// risk of man-in-the-middle attacks.
    insecure_skip_verification: bool = false,

    pub const json_field_names = .{
        .insecure_skip_verification = "insecureSkipVerification",
    };
};
