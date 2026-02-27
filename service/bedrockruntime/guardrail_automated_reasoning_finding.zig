const GuardrailAutomatedReasoningImpossibleFinding = @import("guardrail_automated_reasoning_impossible_finding.zig").GuardrailAutomatedReasoningImpossibleFinding;
const GuardrailAutomatedReasoningInvalidFinding = @import("guardrail_automated_reasoning_invalid_finding.zig").GuardrailAutomatedReasoningInvalidFinding;
const GuardrailAutomatedReasoningNoTranslationsFinding = @import("guardrail_automated_reasoning_no_translations_finding.zig").GuardrailAutomatedReasoningNoTranslationsFinding;
const GuardrailAutomatedReasoningSatisfiableFinding = @import("guardrail_automated_reasoning_satisfiable_finding.zig").GuardrailAutomatedReasoningSatisfiableFinding;
const GuardrailAutomatedReasoningTooComplexFinding = @import("guardrail_automated_reasoning_too_complex_finding.zig").GuardrailAutomatedReasoningTooComplexFinding;
const GuardrailAutomatedReasoningTranslationAmbiguousFinding = @import("guardrail_automated_reasoning_translation_ambiguous_finding.zig").GuardrailAutomatedReasoningTranslationAmbiguousFinding;
const GuardrailAutomatedReasoningValidFinding = @import("guardrail_automated_reasoning_valid_finding.zig").GuardrailAutomatedReasoningValidFinding;

/// Represents a logical validation result from automated reasoning policy
/// evaluation. The finding indicates whether claims in the input are logically
/// valid, invalid, satisfiable, impossible, or have other logical issues.
pub const GuardrailAutomatedReasoningFinding = union(enum) {
    /// Contains the result when the automated reasoning evaluation determines that
    /// no valid logical conclusions can be drawn due to contradictions in the
    /// premises or policy rules themselves.
    impossible: ?GuardrailAutomatedReasoningImpossibleFinding,
    /// Contains the result when the automated reasoning evaluation determines that
    /// the claims in the input are logically invalid and contradict the established
    /// premises or policy rules.
    invalid: ?GuardrailAutomatedReasoningInvalidFinding,
    /// Contains the result when the automated reasoning evaluation cannot extract
    /// any relevant logical information from the input that can be validated
    /// against the policy rules.
    no_translations: ?GuardrailAutomatedReasoningNoTranslationsFinding,
    /// Contains the result when the automated reasoning evaluation determines that
    /// the claims in the input could be either true or false depending on
    /// additional assumptions not provided in the input context.
    satisfiable: ?GuardrailAutomatedReasoningSatisfiableFinding,
    /// Contains the result when the automated reasoning evaluation cannot process
    /// the input due to its complexity or volume exceeding the system's processing
    /// capacity for logical analysis.
    too_complex: ?GuardrailAutomatedReasoningTooComplexFinding,
    /// Contains the result when the automated reasoning evaluation detects that the
    /// input has multiple valid logical interpretations, requiring additional
    /// context or clarification to proceed with validation.
    translation_ambiguous: ?GuardrailAutomatedReasoningTranslationAmbiguousFinding,
    /// Contains the result when the automated reasoning evaluation determines that
    /// the claims in the input are logically valid and definitively true based on
    /// the provided premises and policy rules.
    valid: ?GuardrailAutomatedReasoningValidFinding,

    pub const json_field_names = .{
        .impossible = "impossible",
        .invalid = "invalid",
        .no_translations = "noTranslations",
        .satisfiable = "satisfiable",
        .too_complex = "tooComplex",
        .translation_ambiguous = "translationAmbiguous",
        .valid = "valid",
    };
};
