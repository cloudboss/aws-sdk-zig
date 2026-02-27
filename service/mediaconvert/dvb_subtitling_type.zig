/// Specify whether your DVB subtitles are standard or for hearing impaired.
/// Choose hearing impaired if your subtitles include audio descriptions and
/// dialogue. Choose standard if your subtitles include only dialogue.
pub const DvbSubtitlingType = enum {
    hearing_impaired,
    standard,

    pub const json_field_names = .{
        .hearing_impaired = "HEARING_IMPAIRED",
        .standard = "STANDARD",
    };
};
