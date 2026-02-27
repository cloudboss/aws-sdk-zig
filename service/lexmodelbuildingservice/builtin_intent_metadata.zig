const Locale = @import("locale.zig").Locale;

/// Provides metadata for a built-in intent.
pub const BuiltinIntentMetadata = struct {
    /// A unique identifier for the built-in intent. To find the signature
    /// for an intent, see [Standard Built-in
    /// Intents](https://developer.amazon.com/public/solutions/alexa/alexa-skills-kit/docs/built-in-intent-ref/standard-intents) in the *Alexa Skills
    /// Kit*.
    signature: ?[]const u8,

    /// A list of identifiers for the locales that the intent
    /// supports.
    supported_locales: ?[]const Locale,

    pub const json_field_names = .{
        .signature = "signature",
        .supported_locales = "supportedLocales",
    };
};
