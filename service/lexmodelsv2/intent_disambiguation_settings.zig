/// Configures the Intent Disambiguation feature that helps resolve ambiguous
/// user inputs when multiple intents could match. When enabled, the system
/// presents clarifying questions to users, helping them specify their exact
/// intent for improved conversation accuracy.
pub const IntentDisambiguationSettings = struct {
    /// Provides a custom message that will be displayed before presenting the
    /// disambiguation options to users. This message helps set the context for
    /// users and can be customized to match your bot's tone and brand. If not
    /// specified, a default message will be used.
    custom_disambiguation_message: ?[]const u8,

    /// Determines whether the Intent Disambiguation feature is enabled. When set to
    /// `true`, Amazon Lex will present disambiguation options to users when
    /// multiple intents could match their input, with the default being `false`.
    enabled: bool = false,

    /// Specifies the maximum number of intent options (2-5) to present to users
    /// when disambiguation is needed. This setting determines how many intent
    /// options will be shown to users when the system detects ambiguous input. The
    /// default value is 3.
    max_disambiguation_intents: ?i32,

    pub const json_field_names = .{
        .custom_disambiguation_message = "customDisambiguationMessage",
        .enabled = "enabled",
        .max_disambiguation_intents = "maxDisambiguationIntents",
    };
};
