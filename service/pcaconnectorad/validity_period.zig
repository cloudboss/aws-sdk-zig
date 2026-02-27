const ValidityPeriodType = @import("validity_period_type.zig").ValidityPeriodType;

/// Information describing the end of the validity period of the certificate.
/// This parameter
/// sets the “Not After” date for the certificate. Certificate validity is the
/// period of time
/// during which a certificate is valid. Validity can be expressed as an
/// explicit date and time
/// when the certificate expires, or as a span of time after issuance, stated in
/// hours, days,
/// months, or years. For more information, see Validity in RFC 5280. This value
/// is unaffected
/// when ValidityNotBefore is also specified. For example, if Validity is set to
/// 20 days in the
/// future, the certificate will expire 20 days from issuance time regardless of
/// the
/// ValidityNotBefore value.
pub const ValidityPeriod = struct {
    /// The numeric value for the validity period.
    period: i64,

    /// The unit of time. You can select hours, days, weeks, months, and years.
    period_type: ValidityPeriodType,

    pub const json_field_names = .{
        .period = "Period",
        .period_type = "PeriodType",
    };
};
