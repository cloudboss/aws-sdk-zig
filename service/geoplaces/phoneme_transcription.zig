/// How to pronounce the various components of the address or place.
pub const PhonemeTranscription = struct {
    /// A list of [BCP 47](https://en.wikipedia.org/wiki/IETF_language_tag)
    /// compliant language codes for the results to be rendered in. If there is no
    /// data for the result in the requested language, data will be returned in the
    /// default language for the entry.
    language: ?[]const u8,

    /// Boolean which indicates if it the preferred pronunciation.
    preferred: ?bool,

    /// Value which indicates how to pronounce the value.
    value: ?[]const u8,

    pub const json_field_names = .{
        .language = "Language",
        .preferred = "Preferred",
        .value = "Value",
    };
};
