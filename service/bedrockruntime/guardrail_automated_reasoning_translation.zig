const GuardrailAutomatedReasoningStatement = @import("guardrail_automated_reasoning_statement.zig").GuardrailAutomatedReasoningStatement;
const GuardrailAutomatedReasoningInputTextReference = @import("guardrail_automated_reasoning_input_text_reference.zig").GuardrailAutomatedReasoningInputTextReference;

/// Contains the logical translation of natural language input into formal
/// logical statements, including premises, claims, and confidence scores.
pub const GuardrailAutomatedReasoningTranslation = struct {
    /// The logical statements that are being validated against the premises and
    /// policy rules.
    claims: ?[]const GuardrailAutomatedReasoningStatement,

    /// A confidence score between 0 and 1 indicating how certain the system is
    /// about the logical translation.
    confidence: ?f64,

    /// The logical statements that serve as the foundation or assumptions for the
    /// claims.
    premises: ?[]const GuardrailAutomatedReasoningStatement,

    /// References to portions of the original input text that correspond to the
    /// claims but could not be fully translated.
    untranslated_claims: ?[]const GuardrailAutomatedReasoningInputTextReference,

    /// References to portions of the original input text that correspond to the
    /// premises but could not be fully translated.
    untranslated_premises: ?[]const GuardrailAutomatedReasoningInputTextReference,

    pub const json_field_names = .{
        .claims = "claims",
        .confidence = "confidence",
        .premises = "premises",
        .untranslated_claims = "untranslatedClaims",
        .untranslated_premises = "untranslatedPremises",
    };
};
