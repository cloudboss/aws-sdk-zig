/// The summary of the certificate.
pub const CertificateSummary = struct {
    /// The entity that issued the certificate.
    issuer: ?[]const u8,

    /// The certificate is not valid after this date.
    not_valid_after: ?i64,

    /// The certificate is not valid before this date.
    not_valid_before: ?i64,

    /// The entity the certificate belongs to.
    subject: ?[]const u8,

    /// A hexadecimal identifier for the certificate.
    thumbprint: ?[]const u8,

    pub const json_field_names = .{
        .issuer = "issuer",
        .not_valid_after = "notValidAfter",
        .not_valid_before = "notValidBefore",
        .subject = "subject",
        .thumbprint = "thumbprint",
    };
};
