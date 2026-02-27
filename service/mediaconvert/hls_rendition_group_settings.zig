const LanguageCode = @import("language_code.zig").LanguageCode;

/// Settings specific to audio sources in an HLS alternate rendition group.
/// Specify the properties (renditionGroupId, renditionName or
/// renditionLanguageCode) to identify the unique audio track among the
/// alternative rendition groups present in the HLS manifest. If no unique track
/// is found, or multiple tracks match the properties provided, the job fails.
/// If no properties in hlsRenditionGroupSettings are specified, the default
/// audio track within the video segment is chosen. If there is no audio within
/// video segment, the alternative audio with DEFAULT=YES is chosen instead.
pub const HlsRenditionGroupSettings = struct {
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
