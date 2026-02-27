/// A record of a presented X509 credential from a temporary credential request.
pub const CredentialSummary = struct {
    /// Indicates whether the credential is enabled.
    enabled: ?bool,

    /// Indicates whether the temporary credential request was successful.
    failed: ?bool,

    /// The fully qualified domain name of the issuing certificate for the presented
    /// end-entity certificate.
    issuer: ?[]const u8,

    /// The ISO-8601 time stamp of when the certificate was last used in a temporary
    /// credential request.
    seen_at: ?i64,

    /// The serial number of the certificate.
    serial_number: ?[]const u8,

    /// The PEM-encoded data of the certificate.
    x_509_certificate_data: ?[]const u8,

    pub const json_field_names = .{
        .enabled = "enabled",
        .failed = "failed",
        .issuer = "issuer",
        .seen_at = "seenAt",
        .serial_number = "serialNumber",
        .x_509_certificate_data = "x509CertificateData",
    };
};
