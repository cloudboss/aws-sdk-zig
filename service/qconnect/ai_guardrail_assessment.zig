/// The assessment information from the AI Guardrail.
pub const AIGuardrailAssessment = struct {
    /// Indicates whether the AI Guardrail blocked the content.
    blocked: bool,

    pub const json_field_names = .{
        .blocked = "blocked",
    };
};
