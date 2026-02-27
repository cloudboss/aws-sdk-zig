/// Describes the validity terms.
pub const ValidityTerm = struct {
    /// Describes the agreement duration.
    agreement_duration: ?[]const u8,

    pub const json_field_names = .{
        .agreement_duration = "agreementDuration",
    };
};
