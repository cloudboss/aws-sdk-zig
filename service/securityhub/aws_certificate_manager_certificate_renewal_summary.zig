const AwsCertificateManagerCertificateDomainValidationOption = @import("aws_certificate_manager_certificate_domain_validation_option.zig").AwsCertificateManagerCertificateDomainValidationOption;

/// Contains information about the Certificate Manager managed renewal for an
/// `AMAZON_ISSUED` certificate.
pub const AwsCertificateManagerCertificateRenewalSummary = struct {
    /// Information about the validation of each domain name in the certificate, as
    /// it pertains
    /// to Certificate Manager managed renewal. Provided only when the certificate
    /// type is
    /// `AMAZON_ISSUED`.
    domain_validation_options: ?[]const AwsCertificateManagerCertificateDomainValidationOption,

    /// The status of the Certificate Manager managed renewal of the certificate.
    ///
    /// Valid values: `PENDING_AUTO_RENEWAL` | `PENDING_VALIDATION` |
    /// `SUCCESS` | `FAILED`
    renewal_status: ?[]const u8,

    /// The reason that a renewal request was unsuccessful. This attribute is used
    /// only when `RenewalStatus` is `FAILED`.
    ///
    /// Valid values: `NO_AVAILABLE_CONTACTS` |
    /// `ADDITIONAL_VERIFICATION_REQUIRED` | `DOMAIN_NOT_ALLOWED` |
    /// `INVALID_PUBLIC_DOMAIN` | `DOMAIN_VALIDATION_DENIED` |
    /// `CAA_ERROR` | `PCA_LIMIT_EXCEEDED` | `PCA_INVALID_ARN`
    /// | `PCA_INVALID_STATE` | `PCA_REQUEST_FAILED` |
    /// `PCA_NAME_CONSTRAINTS_VALIDATION` | `PCA_RESOURCE_NOT_FOUND` |
    /// `PCA_INVALID_ARGS` | `PCA_INVALID_DURATION` |
    /// `PCA_ACCESS_DENIED` | `SLR_NOT_FOUND` | `OTHER`
    renewal_status_reason: ?[]const u8,

    /// Indicates when the renewal summary was last updated.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    updated_at: ?[]const u8,

    pub const json_field_names = .{
        .domain_validation_options = "DomainValidationOptions",
        .renewal_status = "RenewalStatus",
        .renewal_status_reason = "RenewalStatusReason",
        .updated_at = "UpdatedAt",
    };
};
