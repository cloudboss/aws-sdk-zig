const CertificateType = @import("certificate_type.zig").CertificateType;

/// Describes the current SSL/TLS certificate that is in use for the domain. If
/// you are
/// using `CreateDomainAssociation` to create a new domain association,
/// `Certificate` describes the new certificate that you are creating.
pub const Certificate = struct {
    /// The DNS record for certificate verification.
    certificate_verification_dns_record: ?[]const u8 = null,

    /// The Amazon resource name (ARN) for a custom certificate that you have
    /// already added to
    /// Certificate Manager in your Amazon Web Services account.
    ///
    /// This field is required only when the certificate type is `CUSTOM`.
    custom_certificate_arn: ?[]const u8 = null,

    /// The type of SSL/TLS certificate that you want to use.
    ///
    /// Specify `AMPLIFY_MANAGED` to use the default certificate that Amplify
    /// provisions for you.
    ///
    /// Specify `CUSTOM` to use your own certificate that you have already added to
    /// Certificate Manager in your Amazon Web Services account. Make sure you
    /// request (or
    /// import) the certificate in the US East (N. Virginia) Region (us-east-1). For
    /// more
    /// information about using ACM, see [Importing certificates into
    /// Certificate
    /// Manager](https://docs.aws.amazon.com/acm/latest/userguide/import-certificate.html) in the *ACM User
    /// guide*.
    @"type": CertificateType,

    pub const json_field_names = .{
        .certificate_verification_dns_record = "certificateVerificationDNSRecord",
        .custom_certificate_arn = "customCertificateArn",
        .@"type" = "type",
    };
};
