const CertificateExport = @import("certificate_export.zig").CertificateExport;
const ExtendedKeyUsageName = @import("extended_key_usage_name.zig").ExtendedKeyUsageName;
const KeyAlgorithm = @import("key_algorithm.zig").KeyAlgorithm;
const KeyUsageName = @import("key_usage_name.zig").KeyUsageName;
const CertificateManagedBy = @import("certificate_managed_by.zig").CertificateManagedBy;
const RenewalEligibility = @import("renewal_eligibility.zig").RenewalEligibility;
const CertificateStatus = @import("certificate_status.zig").CertificateStatus;
const CertificateType = @import("certificate_type.zig").CertificateType;

/// This structure is returned in the response object of ListCertificates
/// action.
pub const CertificateSummary = struct {
    /// Amazon Resource Name (ARN) of the certificate. This is of the form:
    ///
    /// `arn:aws:acm:region:123456789012:certificate/12345678-1234-1234-1234-123456789012`
    ///
    /// For more information about ARNs, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
    certificate_arn: ?[]const u8,

    /// The time at which the certificate was requested.
    created_at: ?i64,

    /// Fully qualified domain name (FQDN), such as www.example.com or example.com,
    /// for the certificate.
    domain_name: ?[]const u8,

    /// Indicates whether the certificate has been exported. This value exists only
    /// when the certificate type is `PRIVATE`.
    exported: ?bool,

    /// Indicates if export is enabled for the certificate.
    export_option: ?CertificateExport,

    /// Contains a list of Extended Key Usage X.509 v3 extension objects. Each
    /// object specifies a purpose for which the certificate public key can be used
    /// and consists of a name and an object identifier (OID).
    extended_key_usages: ?[]const ExtendedKeyUsageName,

    /// When called by
    /// [ListCertificates](https://docs.aws.amazon.com/acm/latestAPIReference/API_ListCertificates.html), indicates whether the full list of subject alternative names has been included in the response. If false, the response includes all of the subject alternative names included in the certificate. If true, the response only includes the first 100 subject alternative names included in the certificate. To display the full list of subject alternative names, use [DescribeCertificate](https://docs.aws.amazon.com/acm/latestAPIReference/API_DescribeCertificate.html).
    has_additional_subject_alternative_names: ?bool,

    /// The date and time when the certificate was imported. This value exists only
    /// when the certificate type is `IMPORTED`.
    imported_at: ?i64,

    /// Indicates whether the certificate is currently in use by any Amazon Web
    /// Services resources.
    in_use: ?bool,

    /// The time at which the certificate was issued. This value exists only when
    /// the certificate type is `AMAZON_ISSUED`.
    issued_at: ?i64,

    /// The algorithm that was used to generate the public-private key pair.
    key_algorithm: ?KeyAlgorithm,

    /// A list of Key Usage X.509 v3 extension objects. Each object is a string
    /// value that identifies the purpose of the public key contained in the
    /// certificate. Possible extension values include DIGITAL_SIGNATURE,
    /// KEY_ENCHIPHERMENT, NON_REPUDIATION, and more.
    key_usages: ?[]const KeyUsageName,

    /// Identifies the Amazon Web Services service that manages the certificate
    /// issued by ACM.
    managed_by: ?CertificateManagedBy,

    /// The time after which the certificate is not valid.
    not_after: ?i64,

    /// The time before which the certificate is not valid.
    not_before: ?i64,

    /// Specifies whether the certificate is eligible for renewal. At this time,
    /// only exported private certificates can be renewed with the RenewCertificate
    /// command.
    renewal_eligibility: ?RenewalEligibility,

    /// The time at which the certificate was revoked. This value exists only when
    /// the certificate status is `REVOKED`.
    revoked_at: ?i64,

    /// The status of the certificate.
    ///
    /// A certificate enters status PENDING_VALIDATION upon being requested, unless
    /// it fails for any of the reasons given in the troubleshooting topic
    /// [Certificate request
    /// fails](https://docs.aws.amazon.com/acm/latest/userguide/troubleshooting-failed.html). ACM makes repeated attempts to validate a certificate for 72 hours and then times out. If a certificate shows status FAILED or VALIDATION_TIMED_OUT, delete the request, correct the issue with [DNS validation](https://docs.aws.amazon.com/acm/latest/userguide/dns-validation.html) or [Email validation](https://docs.aws.amazon.com/acm/latest/userguide/email-validation.html), and try again. If validation succeeds, the certificate enters status ISSUED.
    status: ?CertificateStatus,

    /// One or more domain names (subject alternative names) included in the
    /// certificate. This list contains the domain names that are bound to the
    /// public key that is contained in the certificate. The subject alternative
    /// names include the canonical domain name (CN) of the certificate and
    /// additional domain names that can be used to connect to the website.
    ///
    /// When called by
    /// [ListCertificates](https://docs.aws.amazon.com/acm/latestAPIReference/API_ListCertificates.html), this parameter will only return the first 100 subject alternative names included in the certificate. To display the full list of subject alternative names, use [DescribeCertificate](https://docs.aws.amazon.com/acm/latestAPIReference/API_DescribeCertificate.html).
    subject_alternative_name_summaries: ?[]const []const u8,

    /// The source of the certificate. For certificates provided by ACM, this value
    /// is `AMAZON_ISSUED`. For certificates that you imported with
    /// ImportCertificate, this value is `IMPORTED`. ACM does not provide [managed
    /// renewal](https://docs.aws.amazon.com/acm/latest/userguide/acm-renewal.html)
    /// for imported certificates. For more information about the differences
    /// between certificates that you import and those that ACM provides, see
    /// [Importing
    /// Certificates](https://docs.aws.amazon.com/acm/latest/userguide/import-certificate.html) in the *Certificate Manager User Guide*.
    @"type": ?CertificateType,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .created_at = "CreatedAt",
        .domain_name = "DomainName",
        .exported = "Exported",
        .export_option = "ExportOption",
        .extended_key_usages = "ExtendedKeyUsages",
        .has_additional_subject_alternative_names = "HasAdditionalSubjectAlternativeNames",
        .imported_at = "ImportedAt",
        .in_use = "InUse",
        .issued_at = "IssuedAt",
        .key_algorithm = "KeyAlgorithm",
        .key_usages = "KeyUsages",
        .managed_by = "ManagedBy",
        .not_after = "NotAfter",
        .not_before = "NotBefore",
        .renewal_eligibility = "RenewalEligibility",
        .revoked_at = "RevokedAt",
        .status = "Status",
        .subject_alternative_name_summaries = "SubjectAlternativeNameSummaries",
        .@"type" = "Type",
    };
};
