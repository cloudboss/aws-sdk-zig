const AutomatedReasoningCheckImpossibleFinding = @import("automated_reasoning_check_impossible_finding.zig").AutomatedReasoningCheckImpossibleFinding;
const AutomatedReasoningCheckInvalidFinding = @import("automated_reasoning_check_invalid_finding.zig").AutomatedReasoningCheckInvalidFinding;
const AutomatedReasoningCheckNoTranslationsFinding = @import("automated_reasoning_check_no_translations_finding.zig").AutomatedReasoningCheckNoTranslationsFinding;
const AutomatedReasoningCheckSatisfiableFinding = @import("automated_reasoning_check_satisfiable_finding.zig").AutomatedReasoningCheckSatisfiableFinding;
const AutomatedReasoningCheckTooComplexFinding = @import("automated_reasoning_check_too_complex_finding.zig").AutomatedReasoningCheckTooComplexFinding;
const AutomatedReasoningCheckTranslationAmbiguousFinding = @import("automated_reasoning_check_translation_ambiguous_finding.zig").AutomatedReasoningCheckTranslationAmbiguousFinding;
const AutomatedReasoningCheckValidFinding = @import("automated_reasoning_check_valid_finding.zig").AutomatedReasoningCheckValidFinding;

/// Represents the result of an Automated Reasoning validation check, indicating
/// whether the content is logically valid, invalid, or falls into other
/// categories based on the policy rules.
pub const AutomatedReasoningCheckFinding = union(enum) {
    /// Indicates that Automated Reasoning cannot make a statement about the claims.
    /// This can happen if the premises are logically incorrect, or if there is a
    /// conflict within the Automated Reasoning policy itself.
    impossible: ?AutomatedReasoningCheckImpossibleFinding,
    /// Indicates that the claims are false. The claims are not implied by the
    /// premises and Automated Reasoning policy. Furthermore, there exist different
    /// claims that are consistent with the premises and Automated Reasoning policy.
    invalid: ?AutomatedReasoningCheckInvalidFinding,
    /// Identifies that some or all of the input prompt wasn't translated into
    /// logic. This can happen if the input isn't relevant to the Automated
    /// Reasoning policy, or if the policy doesn't have variables to model relevant
    /// input.
    no_translations: ?AutomatedReasoningCheckNoTranslationsFinding,
    /// Indicates that the claims can be true or false. It depends on what
    /// assumptions are made for the claim to be implied from the premises and
    /// Automated Reasoning policy rules. In this situation, different assumptions
    /// can make input claims false and alternative claims true.
    satisfiable: ?AutomatedReasoningCheckSatisfiableFinding,
    /// Indicates that the input contains too much information for Automated
    /// Reasoning to process within its latency limits.
    too_complex: ?AutomatedReasoningCheckTooComplexFinding,
    /// Indicates that an ambiguity was detected in the translation, making it
    /// unsound to continue with validity checking. Additional context or follow-up
    /// questions might be needed to get translation to succeed.
    translation_ambiguous: ?AutomatedReasoningCheckTranslationAmbiguousFinding,
    /// Indicates that the claims are true. The claims are implied by the premises
    /// and the Automated Reasoning policy. Given the Automated Reasoning policy and
    /// premises, it is not possible for these claims to be false.
    valid: ?AutomatedReasoningCheckValidFinding,

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
