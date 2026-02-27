/// Provides information about the TLS/SSL configuration that the CloudFront
/// distribution uses to communicate with viewers.
pub const AwsCloudFrontDistributionViewerCertificate = struct {
    /// The ARN of the ACM certificate. Used if the certificate is stored in ACM. If
    /// you provide an ACM certificate ARN, you must also provide
    /// `MinimumCertificateVersion` and `SslSupportMethod`.
    acm_certificate_arn: ?[]const u8,

    /// The identifier of the certificate. Note that in CloudFront, this attribute
    /// is deprecated.
    certificate: ?[]const u8,

    /// The source of the certificate identified by `Certificate`. Note that in
    /// CloudFront, this attribute is deprecated.
    certificate_source: ?[]const u8,

    /// Whether the distribution uses the CloudFront domain name. If set to `false`,
    /// then you provide either `AcmCertificateArn` or `IamCertificateId`.
    cloud_front_default_certificate: ?bool,

    /// The identifier of the IAM certificate. Used if the certificate is stored in
    /// IAM. If you provide `IamCertificateId`, then you also must provide
    /// `MinimumProtocolVersion` and `SslSupportMethod`.
    iam_certificate_id: ?[]const u8,

    /// The security policy that CloudFront uses for HTTPS connections with viewers.
    /// If `SslSupportMethod` is `sni-only`, then `MinimumProtocolVersion` must be
    /// `TLSv1` or higher.
    minimum_protocol_version: ?[]const u8,

    /// The viewers that the distribution accepts HTTPS connections from.
    ssl_support_method: ?[]const u8,

    pub const json_field_names = .{
        .acm_certificate_arn = "AcmCertificateArn",
        .certificate = "Certificate",
        .certificate_source = "CertificateSource",
        .cloud_front_default_certificate = "CloudFrontDefaultCertificate",
        .iam_certificate_id = "IamCertificateId",
        .minimum_protocol_version = "MinimumProtocolVersion",
        .ssl_support_method = "SslSupportMethod",
    };
};
