/// Defines the conditions that will keep an agreement created from this offer
/// valid.
pub const ValidityTerm = struct {
    /// Defines the duration that the agreement remains active. If
    /// `AgreementStartDate` isn’t provided, the agreement duration is relative to
    /// the agreement signature time. The duration is represented in the ISO_8601
    /// format.
    agreement_duration: ?[]const u8 = null,

    /// Defines the date when the agreement ends. The agreement ends at 23:59:59.999
    /// UTC on the date provided. If `AgreementEndDate` isn’t provided, the
    /// agreement end date is determined by the validity of individual terms.
    agreement_end_date: ?i64 = null,

    /// Defines the date when agreement starts. The agreement starts at 00:00:00.000
    /// UTC on the date provided. If `AgreementStartDate` isn’t provided, the
    /// agreement start date is determined based on agreement signature time.
    agreement_start_date: ?i64 = null,

    /// Category of the term being updated.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .agreement_duration = "agreementDuration",
        .agreement_end_date = "agreementEndDate",
        .agreement_start_date = "agreementStartDate",
        .@"type" = "type",
    };
};
