const AssistedNluMode = @import("assisted_nlu_mode.zig").AssistedNluMode;
const IntentDisambiguationSettings = @import("intent_disambiguation_settings.zig").IntentDisambiguationSettings;

/// Configures the Assisted Natural Language Understanding (NLU) feature for
/// your bot. This specification determines whether enhanced intent recognition
/// and utterance understanding capabilities are active.
pub const NluImprovementSpecification = struct {
    /// Specifies the mode for Assisted NLU operation. Use `Primary` to make
    /// Assisted NLU the primary intent recognition method, or `Fallback` to use it
    /// only when standard NLU confidence is low.
    assisted_nlu_mode: ?AssistedNluMode = null,

    /// Determines whether the Assisted NLU feature is enabled for the bot. When set
    /// to `true`, Amazon Lex uses advanced models to improve intent recognition and
    /// slot resolution, with the default being `false`.
    enabled: bool = false,

    /// An object containing specifications for the Intent Disambiguation feature
    /// within the Assisted NLU settings. These settings determine how the bot
    /// handles ambiguous user inputs that could match multiple intents.
    intent_disambiguation_settings: ?IntentDisambiguationSettings = null,

    pub const json_field_names = .{
        .assisted_nlu_mode = "assistedNluMode",
        .enabled = "enabled",
        .intent_disambiguation_settings = "intentDisambiguationSettings",
    };
};
