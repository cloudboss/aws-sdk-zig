/// Provide the font script, using an ISO 15924 script code, if the LanguageCode
/// is not sufficient for determining the script type. Where LanguageCode or
/// CustomLanguageCode is sufficient, use "AUTOMATIC" or leave unset.
pub const FontScript = enum {
    automatic,
    hans,
    hant,

    pub const json_field_names = .{
        .automatic = "AUTOMATIC",
        .hans = "HANS",
        .hant = "HANT",
    };
};
