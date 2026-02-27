/// The guardrail coverage for the text characters.
pub const GuardrailTextCharactersCoverage = struct {
    /// The text characters that were guarded by the guardrail coverage.
    guarded: ?i32,

    /// The total text characters by the guardrail coverage.
    total: ?i32,

    pub const json_field_names = .{
        .guarded = "guarded",
        .total = "total",
    };
};
