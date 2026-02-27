/// Details about the media file's data track.
pub const DataProperties = struct {
    /// The language code of the data track, in three character ISO 639-3 format.
    language_code: ?[]const u8,

    pub const json_field_names = .{
        .language_code = "LanguageCode",
    };
};
