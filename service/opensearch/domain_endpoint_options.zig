const TLSSecurityPolicy = @import("tls_security_policy.zig").TLSSecurityPolicy;

/// Options to configure a custom endpoint for an OpenSearch Service domain.
pub const DomainEndpointOptions = struct {
    /// The fully qualified URL for the custom endpoint.
    custom_endpoint: ?[]const u8,

    /// The ARN for your security certificate, managed in Amazon Web Services
    /// Certificate
    /// Manager (ACM).
    custom_endpoint_certificate_arn: ?[]const u8,

    /// Whether to enable a custom endpoint for the domain.
    custom_endpoint_enabled: ?bool,

    /// True to require that all traffic to the domain arrive over HTTPS.
    enforce_https: ?bool,

    /// Specify the TLS security policy to apply to the HTTPS endpoint of the
    /// domain. The
    /// policy can be one of the following values:
    ///
    /// * **Policy-Min-TLS-1-0-2019-07:** TLS security
    /// policy that supports TLS version 1.0 to TLS version 1.2
    ///
    /// * **Policy-Min-TLS-1-2-2019-07:** TLS security
    /// policy that supports only TLS version 1.2
    ///
    /// * **Policy-Min-TLS-1-2-PFS-2023-10:** TLS security
    /// policy that supports TLS version 1.2 to TLS version 1.3 with perfect forward
    /// secrecy cipher suites
    tls_security_policy: ?TLSSecurityPolicy,

    pub const json_field_names = .{
        .custom_endpoint = "CustomEndpoint",
        .custom_endpoint_certificate_arn = "CustomEndpointCertificateArn",
        .custom_endpoint_enabled = "CustomEndpointEnabled",
        .enforce_https = "EnforceHTTPS",
        .tls_security_policy = "TLSSecurityPolicy",
    };
};
