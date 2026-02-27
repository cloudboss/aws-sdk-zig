/// For use with DVB-DASH profiles only. The settings for font downloads that
/// you want Elemental MediaPackage to pass through to the manifest.
pub const DashDvbFontDownload = struct {
    /// The `fontFamily` name for subtitles, as described in [EBU-TT-D Subtitling
    /// Distribution Format](https://tech.ebu.ch/publications/tech3380).
    font_family: ?[]const u8,

    /// The `mimeType` of the resource that's at the font download URL.
    ///
    /// For information about font MIME types, see the [MPEG-DASH Profile for
    /// Transport of ISO BMFF Based DVB Services over IP Based
    /// Networks](https://dvb.org/wp-content/uploads/2021/06/A168r4_MPEG-DASH-Profile-for-Transport-of-ISO-BMFF-Based-DVB-Services_Draft-ts_103-285-v140_November_2021.pdf) document.
    mime_type: ?[]const u8,

    /// The URL for downloading fonts for subtitles.
    url: ?[]const u8,

    pub const json_field_names = .{
        .font_family = "FontFamily",
        .mime_type = "MimeType",
        .url = "Url",
    };
};
