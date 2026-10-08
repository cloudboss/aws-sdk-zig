const DomainValidationMethodUpdateSummary = @import("domain_validation_method_update_summary.zig").DomainValidationMethodUpdateSummary;
const UpdateStatus = @import("update_status.zig").UpdateStatus;
const UpdateType = @import("update_type.zig").UpdateType;

/// Contains information about the most recent certificate update, such as a
/// domain validation method migration. This structure is returned as part of
/// the CertificateDetail response from DescribeCertificate.
pub const UpdateSummary = struct {
    /// Contains information about a domain validation method migration, including
    /// the previous and target validation methods.
    domain_validation_method_update_summary: ?DomainValidationMethodUpdateSummary = null,

    /// The time at which the certificate update was requested.
    requested_at: ?i64 = null,

    /// The status of the certificate update. The following are valid values:
    ///
    /// * `PENDING_DOMAIN_VALIDATION` – The certificate update is waiting for domain
    ///   ownership validation to complete.
    /// * `SUCCESS` – The certificate was updated successfully.
    /// * `FAILED` – The certificate update failed.
    status: ?UpdateStatus = null,

    /// The type of update that was requested for the certificate. The following are
    /// valid values:
    ///
    /// * `DOMAIN_VALIDATION_METHOD` – The update changes the domain validation
    ///   method for the certificate.
    type: ?UpdateType = null,

    /// The time at which the certificate update status was last changed.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .domain_validation_method_update_summary = "DomainValidationMethodUpdateSummary",
        .requested_at = "RequestedAt",
        .status = "Status",
        .type = "Type",
        .updated_at = "UpdatedAt",
    };
};
