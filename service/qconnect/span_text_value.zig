const AIGuardrailAssessment = @import("ai_guardrail_assessment.zig").AIGuardrailAssessment;
const SpanCitation = @import("span_citation.zig").SpanCitation;

/// Text message content
pub const SpanTextValue = struct {
    /// The AI Guardrail assessment for the span text.
    ai_guardrail_assessment: ?AIGuardrailAssessment,

    /// The citations associated with the span text.
    citations: ?[]const SpanCitation,

    /// String content of the message text
    value: []const u8,

    pub const json_field_names = .{
        .ai_guardrail_assessment = "aiGuardrailAssessment",
        .citations = "citations",
        .value = "value",
    };
};
