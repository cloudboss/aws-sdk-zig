/// Information about additional options for the domain endpoint.
pub const AwsOpenSearchServiceDomainDomainEndpointOptionsDetails = struct {
    /// The fully qualified URL for the custom endpoint.
    custom_endpoint: ?[]const u8,

    /// The ARN for the security certificate. The certificate is managed in ACM.
    custom_endpoint_certificate_arn: ?[]const u8,

    /// Whether to enable a custom endpoint for the domain.
    custom_endpoint_enabled: ?bool,

    /// Whether to require that all traffic to the domain arrive over HTTPS.
    enforce_https: ?bool,

    /// The TLS security policy to apply to the HTTPS endpoint of the OpenSearch
    /// domain.
    tls_security_policy: ?[]const u8,

    pub const json_field_names = .{
        .custom_endpoint = "CustomEndpoint",
        .custom_endpoint_certificate_arn = "CustomEndpointCertificateArn",
        .custom_endpoint_enabled = "CustomEndpointEnabled",
        .enforce_https = "EnforceHTTPS",
        .tls_security_policy = "TLSSecurityPolicy",
    };
};
