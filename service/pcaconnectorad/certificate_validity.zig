const ValidityPeriod = @import("validity_period.zig").ValidityPeriod;

/// Information describing the end of the validity period of the certificate.
/// This parameter
/// sets the “Not After” date for the certificate. Certificate validity is the
/// period of time
/// during which a certificate is valid. Validity can be expressed as an
/// explicit date and time
/// when the certificate expires, or as a span of time after issuance, stated in
/// days, months,
/// or years. For more information, see Validity in RFC 5280. This value is
/// unaffected when
/// ValidityNotBefore is also specified. For example, if Validity is set to 20
/// days in the
/// future, the certificate will expire 20 days from issuance time regardless of
/// the
/// ValidityNotBefore value.
pub const CertificateValidity = struct {
    /// Renewal period is the period of time before certificate expiration when a
    /// new
    /// certificate will be requested.
    renewal_period: ValidityPeriod,

    /// Information describing the end of the validity period of the certificate.
    /// This parameter
    /// sets the “Not After” date for the certificate. Certificate validity is the
    /// period of time
    /// during which a certificate is valid. Validity can be expressed as an
    /// explicit date and time
    /// when the certificate expires, or as a span of time after issuance, stated in
    /// days, months,
    /// or years. For more information, see Validity in RFC 5280. This value is
    /// unaffected when
    /// ValidityNotBefore is also specified. For example, if Validity is set to 20
    /// days in the
    /// future, the certificate will expire 20 days from issuance time regardless of
    /// the
    /// ValidityNotBefore value.
    validity_period: ValidityPeriod,

    pub const json_field_names = .{
        .renewal_period = "RenewalPeriod",
        .validity_period = "ValidityPeriod",
    };
};
