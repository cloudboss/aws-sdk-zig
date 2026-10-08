const TermType = @import("term_type.zig").TermType;

/// Defines a validity term that specifies the duration or date range of an
/// agreement.
pub const ValidityTerm = struct {
    /// The duration of the agreement, in ISO 8601 format.
    agreement_duration: ?[]const u8 = null,

    /// The date when the agreement ends.
    agreement_end_date: ?i64 = null,

    /// The date when the agreement starts.
    agreement_start_date: ?i64 = null,

    /// The unique identifier of the term.
    id: []const u8,

    /// The category of the term.
    type: TermType,

    pub const json_field_names = .{
        .agreement_duration = "agreementDuration",
        .agreement_end_date = "agreementEndDate",
        .agreement_start_date = "agreementStartDate",
        .id = "id",
        .type = "type",
    };
};
