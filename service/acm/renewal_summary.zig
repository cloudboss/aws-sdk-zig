const DomainValidation = @import("domain_validation.zig").DomainValidation;
const RenewalStatus = @import("renewal_status.zig").RenewalStatus;
const FailureReason = @import("failure_reason.zig").FailureReason;

/// Contains information about the status of ACM's [managed
/// renewal](https://docs.aws.amazon.com/acm/latest/userguide/acm-renewal.html)
/// for the certificate. This structure exists only when the certificate type is
/// `AMAZON_ISSUED`.
pub const RenewalSummary = struct {
    /// Contains information about the validation of each domain name in the
    /// certificate, as it pertains to ACM's [managed
    /// renewal](https://docs.aws.amazon.com/acm/latest/userguide/acm-renewal.html).
    /// This is different from the initial validation that occurs as a result of the
    /// RequestCertificate request. This field exists only when the certificate type
    /// is `AMAZON_ISSUED`.
    domain_validation_options: []const DomainValidation,

    /// The status of ACM's [managed
    /// renewal](https://docs.aws.amazon.com/acm/latest/userguide/acm-renewal.html)
    /// of the certificate.
    renewal_status: RenewalStatus,

    /// The reason that a renewal request was unsuccessful.
    renewal_status_reason: ?FailureReason = null,

    /// The time at which the renewal summary was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .domain_validation_options = "DomainValidationOptions",
        .renewal_status = "RenewalStatus",
        .renewal_status_reason = "RenewalStatusReason",
        .updated_at = "UpdatedAt",
    };
};
