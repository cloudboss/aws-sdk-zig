const CertificateValidationRecordStatus = @import("certificate_validation_record_status.zig").CertificateValidationRecordStatus;

/// Describes a certificate CNAME record to add to your DNS. For more
/// information, see
/// [AssociateCustomDomain](https://docs.aws.amazon.com/apprunner/latest/api/API_AssociateCustomDomain.html).
pub const CertificateValidationRecord = struct {
    /// The certificate CNAME record name.
    name: ?[]const u8,

    /// The current state of the certificate CNAME record validation. It should
    /// change to `SUCCESS` after App Runner completes validation with your
    /// DNS.
    status: ?CertificateValidationRecordStatus,

    /// The record type, always `CNAME`.
    type: ?[]const u8,

    /// The certificate CNAME record value.
    value: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .status = "Status",
        .type = "Type",
        .value = "Value",
    };
};
