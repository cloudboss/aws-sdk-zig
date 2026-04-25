const CertificateExport = @import("certificate_export.zig").CertificateExport;
const CertificateManagedBy = @import("certificate_managed_by.zig").CertificateManagedBy;
const RenewalEligibility = @import("renewal_eligibility.zig").RenewalEligibility;
const RenewalStatus = @import("renewal_status.zig").RenewalStatus;
const CertificateStatus = @import("certificate_status.zig").CertificateStatus;
const CertificateType = @import("certificate_type.zig").CertificateType;
const ValidationMethod = @import("validation_method.zig").ValidationMethod;

/// Contains ACM-specific metadata about a certificate.
pub const AcmCertificateMetadata = struct {
    /// The time at which the certificate was requested.
    created_at: ?i64 = null,

    /// Indicates whether the certificate has been exported.
    exported: ?bool = null,

    /// Indicates whether the certificate can be exported.
    export_option: ?CertificateExport = null,

    /// The date and time when the certificate was imported. This value exists only
    /// when the certificate type is `IMPORTED`.
    imported_at: ?i64 = null,

    /// Indicates whether the certificate is currently in use by an Amazon Web
    /// Services service.
    in_use: ?bool = null,

    /// The time at which the certificate was issued. This value exists only when
    /// the certificate type is `AMAZON_ISSUED`.
    issued_at: ?i64 = null,

    /// Identifies the Amazon Web Services service that manages the certificate
    /// issued by ACM.
    managed_by: ?CertificateManagedBy = null,

    /// Specifies whether the certificate is eligible for renewal. At this time,
    /// only exported private certificates can be renewed with the RenewCertificate
    /// command.
    renewal_eligibility: ?RenewalEligibility = null,

    /// The renewal status of the certificate.
    renewal_status: ?RenewalStatus = null,

    /// The time at which the certificate was revoked. This value exists only when
    /// the certificate status is `REVOKED`.
    revoked_at: ?i64 = null,

    /// The status of the certificate.
    ///
    /// A certificate enters status PENDING_VALIDATION upon being requested, unless
    /// it fails for any of the reasons given in the troubleshooting topic
    /// [Certificate request
    /// fails](https://docs.aws.amazon.com/acm/latest/userguide/troubleshooting-failed.html). ACM makes repeated attempts to validate a certificate for 72 hours and then times out. If a certificate shows status FAILED or VALIDATION_TIMED_OUT, delete the request, correct the issue with [DNS validation](https://docs.aws.amazon.com/acm/latest/userguide/dns-validation.html) or [Email validation](https://docs.aws.amazon.com/acm/latest/userguide/email-validation.html), and try again. If validation succeeds, the certificate enters status ISSUED.
    status: ?CertificateStatus = null,

    /// The source of the certificate. For certificates provided by ACM, this value
    /// is `AMAZON_ISSUED`. For certificates that you imported with
    /// ImportCertificate, this value is `IMPORTED`. ACM does not provide [managed
    /// renewal](https://docs.aws.amazon.com/acm/latest/userguide/acm-renewal.html)
    /// for imported certificates. For more information about the differences
    /// between certificates that you import and those that ACM provides, see
    /// [Importing
    /// Certificates](https://docs.aws.amazon.com/acm/latest/userguide/import-certificate.html) in the *Certificate Manager User Guide*.
    @"type": ?CertificateType = null,

    /// Specifies the domain validation method.
    validation_method: ?ValidationMethod = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .exported = "Exported",
        .export_option = "ExportOption",
        .imported_at = "ImportedAt",
        .in_use = "InUse",
        .issued_at = "IssuedAt",
        .managed_by = "ManagedBy",
        .renewal_eligibility = "RenewalEligibility",
        .renewal_status = "RenewalStatus",
        .revoked_at = "RevokedAt",
        .status = "Status",
        .@"type" = "Type",
        .validation_method = "ValidationMethod",
    };
};
