/// Specify which source for language code takes precedence for this audio
/// track. When you choose Follow input, the service uses the language code from
/// the input track if it's present. If there's no languge code on the input
/// track, the service uses the code that you specify in the setting Language
/// code. When you choose Use configured, the service uses the language code
/// that you specify.
pub const AudioLanguageCodeControl = enum {
    follow_input,
    use_configured,

    pub const json_field_names = .{
        .follow_input = "FOLLOW_INPUT",
        .use_configured = "USE_CONFIGURED",
    };
};
