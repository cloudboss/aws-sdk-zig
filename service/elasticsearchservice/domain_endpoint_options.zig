const TLSSecurityPolicy = @import("tls_security_policy.zig").TLSSecurityPolicy;

/// Options to configure endpoint for the Elasticsearch domain.
pub const DomainEndpointOptions = struct {
    /// Specify the fully qualified domain for your custom endpoint.
    custom_endpoint: ?[]const u8 = null,

    /// Specify ACM certificate ARN for your custom endpoint.
    custom_endpoint_certificate_arn: ?[]const u8 = null,

    /// Specify if custom endpoint should be enabled for the Elasticsearch domain.
    custom_endpoint_enabled: ?bool = null,

    /// Specify if only HTTPS endpoint should be enabled for the Elasticsearch
    /// domain.
    enforce_https: ?bool = null,

    /// Specify the TLS security policy that needs to be applied to the HTTPS
    /// endpoint of Elasticsearch domain.
    ///
    /// It can be one of the following values:
    ///
    /// * **Policy-Min-TLS-1-0-2019-07: ** TLS security policy that supports TLS
    ///   version 1.0 to TLS version 1.2
    ///
    /// * **Policy-Min-TLS-1-2-2019-07: ** TLS security policy that supports only
    ///   TLS version 1.2
    ///
    /// * **Policy-Min-TLS-1-2-PFS-2023-10: ** TLS security policy that supports TLS
    ///   version 1.2 to TLS version 1.3 with perfect forward secrecy cipher suites
    ///
    /// * **Policy-Min-TLS-1-2-RFC9151-FIPS-2024-08: ** TLS security policy that
    ///   supports TLS version 1.3 with FIPS
    tls_security_policy: ?TLSSecurityPolicy = null,

    pub const json_field_names = .{
        .custom_endpoint = "CustomEndpoint",
        .custom_endpoint_certificate_arn = "CustomEndpointCertificateArn",
        .custom_endpoint_enabled = "CustomEndpointEnabled",
        .enforce_https = "EnforceHTTPS",
        .tls_security_policy = "TLSSecurityPolicy",
    };
};
