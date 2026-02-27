pub const AutomatedReasoningCheckResult = enum {
    valid,
    invalid,
    satisfiable,
    impossible,
    translation_ambiguous,
    too_complex,
    no_translation,

    pub const json_field_names = .{
        .valid = "VALID",
        .invalid = "INVALID",
        .satisfiable = "SATISFIABLE",
        .impossible = "IMPOSSIBLE",
        .translation_ambiguous = "TRANSLATION_AMBIGUOUS",
        .too_complex = "TOO_COMPLEX",
        .no_translation = "NO_TRANSLATION",
    };
};
