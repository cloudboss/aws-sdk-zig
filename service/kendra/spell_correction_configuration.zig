/// Provides the configuration information for suggested query spell
/// corrections.
///
/// Suggested spell corrections are based on words that appear in your indexed
/// documents
/// and how closely a corrected word matches a misspelled word.
///
/// This feature is designed with certain defaults or limits. For information on
/// the
/// current limits and how to request more support for some limits, see the
/// [Spell
/// Checker
/// documentation](https://docs.aws.amazon.com/kendra/latest/dg/query-spell-check.html).
pub const SpellCorrectionConfiguration = struct {
    /// `TRUE` to suggest spell corrections for queries.
    include_query_spell_check_suggestions: bool = false,

    pub const json_field_names = .{
        .include_query_spell_check_suggestions = "IncludeQuerySpellCheckSuggestions",
    };
};
