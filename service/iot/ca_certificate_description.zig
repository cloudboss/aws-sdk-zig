const AutoRegistrationStatus = @import("auto_registration_status.zig").AutoRegistrationStatus;
const CertificateMode = @import("certificate_mode.zig").CertificateMode;
const CACertificateStatus = @import("ca_certificate_status.zig").CACertificateStatus;
const CertificateValidity = @import("certificate_validity.zig").CertificateValidity;

/// Describes a CA certificate.
pub const CACertificateDescription = struct {
    /// Whether the CA certificate configured for auto registration of device
    /// certificates.
    /// Valid values are "ENABLE" and "DISABLE"
    auto_registration_status: ?AutoRegistrationStatus,

    /// The CA certificate ARN.
    certificate_arn: ?[]const u8,

    /// The CA certificate ID.
    certificate_id: ?[]const u8,

    /// The mode of the CA.
    ///
    /// All the device certificates that are registered using this CA will be
    /// registered
    /// in the same mode as the CA. For more information about certificate mode for
    /// device certificates, see [certificate
    /// mode](https://docs.aws.amazon.com/iot/latest/apireference/API_CertificateDescription.html#iot-Type-CertificateDescription-certificateMode).
    certificate_mode: ?CertificateMode,

    /// The CA certificate data, in PEM format.
    certificate_pem: ?[]const u8,

    /// The date the CA certificate was created.
    creation_date: ?i64,

    /// The customer version of the CA certificate.
    customer_version: ?i32,

    /// The generation ID of the CA certificate.
    generation_id: ?[]const u8,

    /// The date the CA certificate was last modified.
    last_modified_date: ?i64,

    /// The owner of the CA certificate.
    owned_by: ?[]const u8,

    /// The status of a CA certificate.
    status: ?CACertificateStatus,

    /// When the CA certificate is valid.
    validity: ?CertificateValidity,

    pub const json_field_names = .{
        .auto_registration_status = "autoRegistrationStatus",
        .certificate_arn = "certificateArn",
        .certificate_id = "certificateId",
        .certificate_mode = "certificateMode",
        .certificate_pem = "certificatePem",
        .creation_date = "creationDate",
        .customer_version = "customerVersion",
        .generation_id = "generationId",
        .last_modified_date = "lastModifiedDate",
        .owned_by = "ownedBy",
        .status = "status",
        .validity = "validity",
    };
};
