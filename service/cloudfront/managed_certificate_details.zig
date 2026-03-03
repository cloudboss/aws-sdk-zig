const ManagedCertificateStatus = @import("managed_certificate_status.zig").ManagedCertificateStatus;
const ValidationTokenDetail = @import("validation_token_detail.zig").ValidationTokenDetail;
const ValidationTokenHost = @import("validation_token_host.zig").ValidationTokenHost;

/// Contains details about the CloudFront managed ACM certificate.
pub const ManagedCertificateDetails = struct {
    /// The ARN of the CloudFront managed ACM certificate.
    certificate_arn: ?[]const u8 = null,

    /// The status of the CloudFront managed ACM certificate.
    ///
    /// Your distribution tenant will be updated with the latest certificate status.
    /// When calling the
    /// [UpdateDistributionTenant](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_UpdateDistributionTenant.html) operation, use the latest value for the `ETag`.
    certificate_status: ?ManagedCertificateStatus = null,

    /// Contains details about the validation token of the specified CloudFront
    /// managed ACM certificate.
    validation_token_details: ?[]const ValidationTokenDetail = null,

    /// Contains details about the validation token host of the specified CloudFront
    /// managed ACM certificate.
    ///
    /// * For `cloudfront`, CloudFront will automatically serve the validation
    ///   token. Choose this mode if you can point the domain's DNS to CloudFront
    ///   immediately.
    /// * For `self-hosted`, you serve the validation token from your existing
    ///   infrastructure. Choose this mode when you need to maintain current traffic
    ///   flow while your certificate is being issued. You can place the validation
    ///   token at the well-known path on your existing web server, wait for ACM to
    ///   validate and issue the certificate, and then update your DNS to point to
    ///   CloudFront.
    ///
    /// This setting only affects the initial certificate request. Once the DNS
    /// points to CloudFront, all future certificate renewals are automatically
    /// handled through CloudFront.
    validation_token_host: ?ValidationTokenHost = null,
};
