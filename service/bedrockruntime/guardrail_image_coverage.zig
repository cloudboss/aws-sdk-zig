/// The details of the guardrail image coverage.
pub const GuardrailImageCoverage = struct {
    /// The count (integer) of images guardrails guarded.
    guarded: ?i32 = null,

    /// Represents the total number of images (integer) that were in the request
    /// (guarded and unguarded).
    total: ?i32 = null,

    pub const json_field_names = .{
        .guarded = "guarded",
        .total = "total",
    };
};
