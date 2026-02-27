const LanguageCode = @import("language_code.zig").LanguageCode;

/// Settings specific to WebVTT sources in HLS alternative rendition group.
/// Specify the properties (renditionGroupId, renditionName or
/// renditionLanguageCode) to identify the unique subtitle track among the
/// alternative rendition groups present in the HLS manifest. If no unique track
/// is found, or multiple tracks match the specified properties, the job fails.
/// If there is only one subtitle track in the rendition group, the settings can
/// be left empty and the default subtitle track will be chosen. If your caption
/// source is a sidecar file, use FileSourceSettings instead of
/// WebvttHlsSourceSettings.
pub const WebvttHlsSourceSettings = struct {
    /// Optional. Specify alternative group ID
    rendition_group_id: ?[]const u8,

    /// Optionally specify the language, using an ISO 639-2 or ISO 639-3
    /// three-letter code in all capital letters. You can find a list of codes at:
    /// https://www.loc.gov/standards/iso639-2/php/code_list.php
    rendition_language_code: ?LanguageCode,

    /// Optional. Specify media name
    rendition_name: ?[]const u8,

    pub const json_field_names = .{
        .rendition_group_id = "RenditionGroupId",
        .rendition_language_code = "RenditionLanguageCode",
        .rendition_name = "RenditionName",
    };
};
