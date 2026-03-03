const DomainValidation = @import("domain_validation.zig").DomainValidation;
const ExtendedKeyUsage = @import("extended_key_usage.zig").ExtendedKeyUsage;
const FailureReason = @import("failure_reason.zig").FailureReason;
const KeyAlgorithm = @import("key_algorithm.zig").KeyAlgorithm;
const KeyUsage = @import("key_usage.zig").KeyUsage;
const CertificateManagedBy = @import("certificate_managed_by.zig").CertificateManagedBy;
const CertificateOptions = @import("certificate_options.zig").CertificateOptions;
const RenewalEligibility = @import("renewal_eligibility.zig").RenewalEligibility;
const RenewalSummary = @import("renewal_summary.zig").RenewalSummary;
const RevocationReason = @import("revocation_reason.zig").RevocationReason;
const CertificateStatus = @import("certificate_status.zig").CertificateStatus;
const CertificateType = @import("certificate_type.zig").CertificateType;

/// Contains metadata about an ACM certificate. This structure is returned in
/// the response to a DescribeCertificate request.
pub const CertificateDetail = struct {
    /// The Amazon Resource Name (ARN) of the certificate. For more information
    /// about ARNs, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services General Reference*.
    certificate_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the private certificate authority (CA)
    /// that issued the certificate. This has the following format:
    ///
    /// `arn:aws:acm-pca:region:account:certificate-authority/12345678-1234-1234-1234-123456789012`
    certificate_authority_arn: ?[]const u8 = null,

    /// The time at which the certificate was requested.
    created_at: ?i64 = null,

    /// The fully qualified domain name for the certificate, such as www.example.com
    /// or example.com.
    domain_name: ?[]const u8 = null,

    /// Contains information about the initial validation of each domain name that
    /// occurs as a result of the RequestCertificate request. This field exists only
    /// when the certificate type is `AMAZON_ISSUED`.
    domain_validation_options: ?[]const DomainValidation = null,

    /// Contains a list of Extended Key Usage X.509 v3 extension objects. Each
    /// object specifies a purpose for which the certificate public key can be used
    /// and consists of a name and an object identifier (OID).
    extended_key_usages: ?[]const ExtendedKeyUsage = null,

    /// The reason the certificate request failed. This value exists only when the
    /// certificate status is `FAILED`. For more information, see [Certificate
    /// Request
    /// Failed](https://docs.aws.amazon.com/acm/latest/userguide/troubleshooting.html#troubleshooting-failed) in the *Certificate Manager User Guide*.
    failure_reason: ?FailureReason = null,

    /// The date and time when the certificate was imported. This value exists only
    /// when the certificate type is `IMPORTED`.
    imported_at: ?i64 = null,

    /// A list of ARNs for the Amazon Web Services resources that are using the
    /// certificate. A certificate can be used by multiple Amazon Web Services
    /// resources.
    in_use_by: ?[]const []const u8 = null,

    /// The time at which the certificate was issued. This value exists only when
    /// the certificate type is `AMAZON_ISSUED`.
    issued_at: ?i64 = null,

    /// The name of the certificate authority that issued and signed the
    /// certificate.
    issuer: ?[]const u8 = null,

    /// The algorithm that was used to generate the public-private key pair.
    key_algorithm: ?KeyAlgorithm = null,

    /// A list of Key Usage X.509 v3 extension objects. Each object is a string
    /// value that identifies the purpose of the public key contained in the
    /// certificate. Possible extension values include DIGITAL_SIGNATURE,
    /// KEY_ENCHIPHERMENT, NON_REPUDIATION, and more.
    key_usages: ?[]const KeyUsage = null,

    /// Identifies the Amazon Web Services service that manages the certificate
    /// issued by ACM.
    managed_by: ?CertificateManagedBy = null,

    /// The time after which the certificate is not valid.
    not_after: ?i64 = null,

    /// The time before which the certificate is not valid.
    not_before: ?i64 = null,

    /// Value that specifies whether to add the certificate to a transparency log.
    /// Certificate transparency makes it possible to detect SSL certificates that
    /// have been mistakenly or maliciously issued. A browser might respond to
    /// certificate that has not been logged by showing an error message. The logs
    /// are cryptographically secure.
    options: ?CertificateOptions = null,

    /// Specifies whether the certificate is eligible for renewal. At this time,
    /// only exported private certificates can be renewed with the RenewCertificate
    /// command.
    renewal_eligibility: ?RenewalEligibility = null,

    /// Contains information about the status of ACM's [managed
    /// renewal](https://docs.aws.amazon.com/acm/latest/userguide/acm-renewal.html)
    /// for the certificate. This field exists only when the certificate type is
    /// `AMAZON_ISSUED`.
    renewal_summary: ?RenewalSummary = null,

    /// The reason the certificate was revoked. This value exists only when the
    /// certificate status is `REVOKED`.
    revocation_reason: ?RevocationReason = null,

    /// The time at which the certificate was revoked. This value exists only when
    /// the certificate status is `REVOKED`.
    revoked_at: ?i64 = null,

    /// The serial number of the certificate.
    serial: ?[]const u8 = null,

    /// The algorithm that was used to sign the certificate.
    signature_algorithm: ?[]const u8 = null,

    /// The status of the certificate.
    ///
    /// A certificate enters status PENDING_VALIDATION upon being requested, unless
    /// it fails for any of the reasons given in the troubleshooting topic
    /// [Certificate request
    /// fails](https://docs.aws.amazon.com/acm/latest/userguide/troubleshooting-failed.html). ACM makes repeated attempts to validate a certificate for 72 hours and then times out. If a certificate shows status FAILED or VALIDATION_TIMED_OUT, delete the request, correct the issue with [DNS validation](https://docs.aws.amazon.com/acm/latest/userguide/dns-validation.html) or [Email validation](https://docs.aws.amazon.com/acm/latest/userguide/email-validation.html), and try again. If validation succeeds, the certificate enters status ISSUED.
    status: ?CertificateStatus = null,

    /// The name of the entity that is associated with the public key contained in
    /// the certificate.
    subject: ?[]const u8 = null,

    /// One or more domain names (subject alternative names) included in the
    /// certificate. This list contains the domain names that are bound to the
    /// public key that is contained in the certificate. The subject alternative
    /// names include the canonical domain name (CN) of the certificate and
    /// additional domain names that can be used to connect to the website.
    subject_alternative_names: ?[]const []const u8 = null,

    /// The source of the certificate. For certificates provided by ACM, this value
    /// is `AMAZON_ISSUED`. For certificates that you imported with
    /// ImportCertificate, this value is `IMPORTED`. ACM does not provide [managed
    /// renewal](https://docs.aws.amazon.com/acm/latest/userguide/acm-renewal.html)
    /// for imported certificates. For more information about the differences
    /// between certificates that you import and those that ACM provides, see
    /// [Importing
    /// Certificates](https://docs.aws.amazon.com/acm/latest/userguide/import-certificate.html) in the *Certificate Manager User Guide*.
    @"type": ?CertificateType = null,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .certificate_authority_arn = "CertificateAuthorityArn",
        .created_at = "CreatedAt",
        .domain_name = "DomainName",
        .domain_validation_options = "DomainValidationOptions",
        .extended_key_usages = "ExtendedKeyUsages",
        .failure_reason = "FailureReason",
        .imported_at = "ImportedAt",
        .in_use_by = "InUseBy",
        .issued_at = "IssuedAt",
        .issuer = "Issuer",
        .key_algorithm = "KeyAlgorithm",
        .key_usages = "KeyUsages",
        .managed_by = "ManagedBy",
        .not_after = "NotAfter",
        .not_before = "NotBefore",
        .options = "Options",
        .renewal_eligibility = "RenewalEligibility",
        .renewal_summary = "RenewalSummary",
        .revocation_reason = "RevocationReason",
        .revoked_at = "RevokedAt",
        .serial = "Serial",
        .signature_algorithm = "SignatureAlgorithm",
        .status = "Status",
        .subject = "Subject",
        .subject_alternative_names = "SubjectAlternativeNames",
        .@"type" = "Type",
    };
};
