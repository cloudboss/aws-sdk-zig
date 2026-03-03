const DomainValidationRecord = @import("domain_validation_record.zig").DomainValidationRecord;
const RenewalStatus = @import("renewal_status.zig").RenewalStatus;

/// Describes the status of a SSL/TLS certificate renewal managed by Amazon
/// Lightsail.
pub const RenewalSummary = struct {
    /// An array of objects that describe the domain validation records of the
    /// certificate.
    domain_validation_records: ?[]const DomainValidationRecord = null,

    /// The renewal status of the certificate.
    ///
    /// The following renewal status are possible:
    ///
    /// * **
    /// `PendingAutoRenewal`
    /// ** - Lightsail is
    /// attempting to automatically validate the domain names of the certificate. No
    /// further
    /// action is required.
    ///
    /// * **
    /// `PendingValidation`
    /// ** - Lightsail couldn't
    /// automatically validate one or more domain names of the certificate. You must
    /// take action
    /// to validate these domain names or the certificate won't be renewed. Check to
    /// make sure
    /// your certificate's domain validation records exist in your domain's DNS, and
    /// that your
    /// certificate remains in use.
    ///
    /// * **
    /// `Success`
    /// ** - All domain names in the
    /// certificate are validated, and Lightsail renewed the certificate. No further
    /// action is
    /// required.
    ///
    /// * **
    /// `Failed`
    /// ** - One or more domain names were
    /// not validated before the certificate expired, and Lightsail did not renew
    /// the
    /// certificate. You can request a new certificate using the `CreateCertificate`
    /// action.
    renewal_status: ?RenewalStatus = null,

    /// The reason for the renewal status of the certificate.
    renewal_status_reason: ?[]const u8 = null,

    /// The timestamp when the certificate was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .domain_validation_records = "domainValidationRecords",
        .renewal_status = "renewalStatus",
        .renewal_status_reason = "renewalStatusReason",
        .updated_at = "updatedAt",
    };
};
