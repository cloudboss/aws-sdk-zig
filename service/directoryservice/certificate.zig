const ClientCertAuthSettings = @import("client_cert_auth_settings.zig").ClientCertAuthSettings;
const CertificateState = @import("certificate_state.zig").CertificateState;
const CertificateType = @import("certificate_type.zig").CertificateType;

/// Information about the certificate.
pub const Certificate = struct {
    /// The identifier of the certificate.
    certificate_id: ?[]const u8,

    /// A `ClientCertAuthSettings` object that contains client certificate
    /// authentication settings.
    client_cert_auth_settings: ?ClientCertAuthSettings,

    /// The common name for the certificate.
    common_name: ?[]const u8,

    /// The date and time when the certificate will expire.
    expiry_date_time: ?i64,

    /// The date and time that the certificate was registered.
    registered_date_time: ?i64,

    /// The state of the certificate.
    state: ?CertificateState,

    /// Describes a state change for the certificate.
    state_reason: ?[]const u8,

    /// The function that the registered certificate performs. Valid values include
    /// `ClientLDAPS` or `ClientCertAuth`. The default value is
    /// `ClientLDAPS`.
    @"type": ?CertificateType,

    pub const json_field_names = .{
        .certificate_id = "CertificateId",
        .client_cert_auth_settings = "ClientCertAuthSettings",
        .common_name = "CommonName",
        .expiry_date_time = "ExpiryDateTime",
        .registered_date_time = "RegisteredDateTime",
        .state = "State",
        .state_reason = "StateReason",
        .@"type" = "Type",
    };
};
