const Locale = @import("locale.zig").Locale;

/// Provides information about a built in slot type.
pub const BuiltinSlotTypeMetadata = struct {
    /// A unique identifier for the built-in slot type. To find the
    /// signature for a slot type, see [Slot Type
    /// Reference](https://developer.amazon.com/public/solutions/alexa/alexa-skills-kit/docs/built-in-intent-ref/slot-type-reference) in the *Alexa Skills
    /// Kit*.
    signature: ?[]const u8,

    /// A list of target locales for the slot.
    supported_locales: ?[]const Locale,

    pub const json_field_names = .{
        .signature = "signature",
        .supported_locales = "supportedLocales",
    };
};
