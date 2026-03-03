/// The certificate issuer indentifier.
pub const IssuerCertificateIdentifier = struct {
    /// The issuer certificate serial number.
    issuer_certificate_serial_number: ?[]const u8 = null,

    /// The subject of the issuer certificate.
    issuer_certificate_subject: ?[]const u8 = null,

    /// The issuer ID.
    issuer_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .issuer_certificate_serial_number = "issuerCertificateSerialNumber",
        .issuer_certificate_subject = "issuerCertificateSubject",
        .issuer_id = "issuerId",
    };
};
