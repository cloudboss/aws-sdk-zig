/// Additional options for the domain endpoint, such as whether to require HTTPS
/// for all
/// traffic.
pub const AwsElasticsearchDomainDomainEndpointOptions = struct {
    /// Whether to require that all traffic to the domain arrive over HTTPS.
    enforce_https: ?bool = null,

    /// The TLS security policy to apply to the HTTPS endpoint of the OpenSearch
    /// domain.
    ///
    /// Valid values:
    ///
    /// * `Policy-Min-TLS-1-0-2019-07`, which supports TLSv1.0 and higher
    ///
    /// * `Policy-Min-TLS-1-2-2019-07`, which only supports TLSv1.2
    tls_security_policy: ?[]const u8 = null,

    pub const json_field_names = .{
        .enforce_https = "EnforceHTTPS",
        .tls_security_policy = "TLSSecurityPolicy",
    };
};
