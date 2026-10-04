/// The validity period of a certificate authority's certificate.
pub const CertificateAuthorityValidity = struct {
    /// The Unix epoch timestamp in seconds for the end of the certificate
    /// authority's validity
    /// period.
    not_after: ?i64 = null,

    /// The Unix epoch timestamp in seconds for the start of the certificate
    /// authority's
    /// validity period.
    not_before: ?i64 = null,

    pub const json_field_names = .{
        .not_after = "notAfter",
        .not_before = "notBefore",
    };
};
