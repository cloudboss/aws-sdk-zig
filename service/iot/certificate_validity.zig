/// When the certificate is valid.
pub const CertificateValidity = struct {
    /// The certificate is not valid after this date.
    not_after: ?i64,

    /// The certificate is not valid before this date.
    not_before: ?i64,

    pub const json_field_names = .{
        .not_after = "notAfter",
        .not_before = "notBefore",
    };
};
