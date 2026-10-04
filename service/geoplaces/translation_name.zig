const TranslationNameType = @import("translation_name_type.zig").TranslationNameType;

/// A translation or alternative name for an address component.
pub const TranslationName = struct {
    /// A [BCP
    /// 47](https://www.iana.org/assignments/language-subtag-registry/language-subtag-registry) compliant language code for the translation name.
    language: ?[]const u8 = null,

    /// If `true`, indicates this is the primary name variant for the given
    /// language.
    primary: ?bool = null,

    /// If `true`, indicates this name is a transliterated version rather than a
    /// native script translation.
    transliterated: ?bool = null,

    /// The type of translation name. Valid values are `Abbreviation`, `AreaCode`,
    /// `BaseName`, `Exonym`, `Shortened`, and `Synonym`.
    @"type": TranslationNameType,

    /// The translated or alternative name value.
    value: []const u8,

    pub const json_field_names = .{
        .language = "Language",
        .primary = "Primary",
        .transliterated = "Transliterated",
        .@"type" = "Type",
        .value = "Value",
    };
};
