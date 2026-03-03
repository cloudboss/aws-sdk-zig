const AIGuardrailAssessment = @import("ai_guardrail_assessment.zig").AIGuardrailAssessment;
const Citation = @import("citation.zig").Citation;

/// The message data in text type.
pub const TextMessage = struct {
    /// The AI Guardrail assessment for the text message.
    ai_guardrail_assessment: ?AIGuardrailAssessment = null,

    /// The citations associated with the text message.
    citations: ?[]const Citation = null,

    /// The value of the message data in text type.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .ai_guardrail_assessment = "aiGuardrailAssessment",
        .citations = "citations",
        .value = "value",
    };
};
