/// The device attestation key (DAK) information.
pub const DakCertificateMetadata = struct {
    /// The advertised product ID (APID) that's used for pre-production and
    /// production
    /// applications.
    ap_id: ?[]const u8 = null,

    /// The certificate ID for the DAK.
    certificate_id: []const u8,

    /// The device type ID that's used for prototyping applications.
    device_type_id: ?[]const u8 = null,

    /// Whether factory support has been enabled.
    factory_support: ?bool = null,

    /// The maximum number of signatures that the DAK can sign. A value of `-1`
    /// indicates that there's no device limit.
    max_allowed_signature: ?i32 = null,

    pub const json_field_names = .{
        .ap_id = "ApId",
        .certificate_id = "CertificateId",
        .device_type_id = "DeviceTypeId",
        .factory_support = "FactorySupport",
        .max_allowed_signature = "MaxAllowedSignature",
    };
};
