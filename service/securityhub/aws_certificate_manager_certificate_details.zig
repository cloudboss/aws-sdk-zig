const AwsCertificateManagerCertificateDomainValidationOption = @import("aws_certificate_manager_certificate_domain_validation_option.zig").AwsCertificateManagerCertificateDomainValidationOption;
const AwsCertificateManagerCertificateExtendedKeyUsage = @import("aws_certificate_manager_certificate_extended_key_usage.zig").AwsCertificateManagerCertificateExtendedKeyUsage;
const AwsCertificateManagerCertificateKeyUsage = @import("aws_certificate_manager_certificate_key_usage.zig").AwsCertificateManagerCertificateKeyUsage;
const AwsCertificateManagerCertificateOptions = @import("aws_certificate_manager_certificate_options.zig").AwsCertificateManagerCertificateOptions;
const AwsCertificateManagerCertificateRenewalSummary = @import("aws_certificate_manager_certificate_renewal_summary.zig").AwsCertificateManagerCertificateRenewalSummary;

/// Provides details about an Certificate Manager certificate.
pub const AwsCertificateManagerCertificateDetails = struct {
    /// The ARN of the private certificate authority (CA) that will be used to issue
    /// the
    /// certificate.
    certificate_authority_arn: ?[]const u8,

    /// Indicates when the certificate was requested.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    created_at: ?[]const u8,

    /// The fully qualified domain name (FQDN), such as www.example.com, that is
    /// secured by the
    /// certificate.
    domain_name: ?[]const u8,

    /// Contains information about the initial validation of each domain name that
    /// occurs as a
    /// result of the `RequestCertificate` request.
    ///
    /// Only provided if the certificate type is `AMAZON_ISSUED`.
    domain_validation_options: ?[]const AwsCertificateManagerCertificateDomainValidationOption,

    /// Contains a list of Extended Key Usage X.509 v3 extension objects. Each
    /// object specifies
    /// a purpose for which the certificate public key can be used and consists of a
    /// name and an
    /// object identifier (OID).
    extended_key_usages: ?[]const AwsCertificateManagerCertificateExtendedKeyUsage,

    /// For a failed certificate request, the reason for the failure.
    ///
    /// Valid values: `NO_AVAILABLE_CONTACTS` |
    /// `ADDITIONAL_VERIFICATION_REQUIRED` | `DOMAIN_NOT_ALLOWED` |
    /// `INVALID_PUBLIC_DOMAIN` | `DOMAIN_VALIDATION_DENIED` |
    /// `CAA_ERROR` | `PCA_LIMIT_EXCEEDED` | `PCA_INVALID_ARN`
    /// | `PCA_INVALID_STATE` | `PCA_REQUEST_FAILED` |
    /// `PCA_NAME_CONSTRAINTS_VALIDATION` | `PCA_RESOURCE_NOT_FOUND` |
    /// `PCA_INVALID_ARGS` | `PCA_INVALID_DURATION` |
    /// `PCA_ACCESS_DENIED` | `SLR_NOT_FOUND` | `OTHER`
    failure_reason: ?[]const u8,

    /// Indicates when the certificate was imported. Provided if the certificate
    /// type is
    /// `IMPORTED`.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    imported_at: ?[]const u8,

    /// The list of ARNs for the Amazon Web Services resources that use the
    /// certificate.
    in_use_by: ?[]const []const u8,

    /// Indicates when the certificate was issued. Provided if the certificate type
    /// is
    /// `AMAZON_ISSUED`.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    issued_at: ?[]const u8,

    /// The name of the certificate authority that issued and signed the
    /// certificate.
    issuer: ?[]const u8,

    /// The algorithm that was used to generate the public-private key pair.
    ///
    /// Valid values: `RSA_2048` | `RSA_1024` |` RSA_4096` |
    /// `EC_prime256v1` | `EC_secp384r1` |
    /// `EC_secp521r1`
    key_algorithm: ?[]const u8,

    /// A list of key usage X.509 v3 extension objects.
    key_usages: ?[]const AwsCertificateManagerCertificateKeyUsage,

    /// The time after which the certificate becomes invalid.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    not_after: ?[]const u8,

    /// The time before which the certificate is not valid.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    not_before: ?[]const u8,

    /// Provides a value that specifies whether to add the certificate to a
    /// transparency
    /// log.
    options: ?AwsCertificateManagerCertificateOptions,

    /// Whether the certificate is eligible for renewal.
    ///
    /// Valid values: `ELIGIBLE` | `INELIGIBLE`
    renewal_eligibility: ?[]const u8,

    /// Information about the status of the Certificate Manager managed renewal for
    /// the
    /// certificate. Provided only when the certificate type is `AMAZON_ISSUED`.
    renewal_summary: ?AwsCertificateManagerCertificateRenewalSummary,

    /// The serial number of the certificate.
    serial: ?[]const u8,

    /// The algorithm that was used to sign the certificate.
    signature_algorithm: ?[]const u8,

    /// The status of the certificate.
    ///
    /// Valid values: `PENDING_VALIDATION` | `ISSUED` |
    /// `INACTIVE` | `EXPIRED` | `VALIDATION_TIMED_OUT` |
    /// `REVOKED` | `FAILED`
    status: ?[]const u8,

    /// The name of the entity that is associated with the public key contained in
    /// the
    /// certificate.
    subject: ?[]const u8,

    /// One or more domain names (subject alternative names) included in the
    /// certificate. This
    /// list contains the domain names that are bound to the public key that is
    /// contained in the
    /// certificate.
    ///
    /// The subject alternative names include the canonical domain name (CN) of the
    /// certificate
    /// and additional domain names that can be used to connect to the website.
    subject_alternative_names: ?[]const []const u8,

    /// The source of the certificate. For certificates that Certificate Manager
    /// provides,
    /// `Type` is `AMAZON_ISSUED`. For certificates that are imported with
    /// `ImportCertificate`, `Type` is `IMPORTED`.
    ///
    /// Valid values: `IMPORTED` | `AMAZON_ISSUED` |
    /// `PRIVATE`
    @"type": ?[]const u8,

    pub const json_field_names = .{
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
        .not_after = "NotAfter",
        .not_before = "NotBefore",
        .options = "Options",
        .renewal_eligibility = "RenewalEligibility",
        .renewal_summary = "RenewalSummary",
        .serial = "Serial",
        .signature_algorithm = "SignatureAlgorithm",
        .status = "Status",
        .subject = "Subject",
        .subject_alternative_names = "SubjectAlternativeNames",
        .@"type" = "Type",
    };
};
