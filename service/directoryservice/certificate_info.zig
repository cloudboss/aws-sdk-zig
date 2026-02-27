const CertificateState = @import("certificate_state.zig").CertificateState;
const CertificateType = @import("certificate_type.zig").CertificateType;

/// Contains general information about a certificate.
pub const CertificateInfo = struct {
    /// The identifier of the certificate.
    certificate_id: ?[]const u8,

    /// The common name for the certificate.
    common_name: ?[]const u8,

    /// The date and time when the certificate will expire.
    expiry_date_time: ?i64,

    /// The state of the certificate.
    state: ?CertificateState,

    /// The function that the registered certificate performs. Valid values include
    /// `ClientLDAPS` or `ClientCertAuth`. The default value is
    /// `ClientLDAPS`.
    type: ?CertificateType,

    pub const json_field_names = .{
        .certificate_id = "CertificateId",
        .common_name = "CommonName",
        .expiry_date_time = "ExpiryDateTime",
        .state = "State",
        .type = "Type",
    };
};
