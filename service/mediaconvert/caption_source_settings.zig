const AncillarySourceSettings = @import("ancillary_source_settings.zig").AncillarySourceSettings;
const DvbSubSourceSettings = @import("dvb_sub_source_settings.zig").DvbSubSourceSettings;
const EmbeddedSourceSettings = @import("embedded_source_settings.zig").EmbeddedSourceSettings;
const FileSourceSettings = @import("file_source_settings.zig").FileSourceSettings;
const CaptionSourceType = @import("caption_source_type.zig").CaptionSourceType;
const TeletextSourceSettings = @import("teletext_source_settings.zig").TeletextSourceSettings;
const TrackSourceSettings = @import("track_source_settings.zig").TrackSourceSettings;
const WebvttHlsSourceSettings = @import("webvtt_hls_source_settings.zig").WebvttHlsSourceSettings;

/// If your input captions are SCC, TTML, STL, SMI, SRT, or IMSC in an xml file,
/// specify the URI of the input captions source file. If your input captions
/// are IMSC in an IMF package, use TrackSourceSettings instead of
/// FileSoureSettings.
pub const CaptionSourceSettings = struct {
    /// Settings for ancillary captions source.
    ancillary_source_settings: ?AncillarySourceSettings,

    /// DVB Sub Source Settings
    dvb_sub_source_settings: ?DvbSubSourceSettings,

    /// Settings for embedded captions Source
    embedded_source_settings: ?EmbeddedSourceSettings,

    /// If your input captions are SCC, SMI, SRT, STL, TTML, WebVTT, or IMSC 1.1 in
    /// an xml file, specify the URI of the input caption source file. If your
    /// caption source is IMSC in an IMF package, use TrackSourceSettings instead of
    /// FileSoureSettings.
    file_source_settings: ?FileSourceSettings,

    /// Use Source to identify the format of your input captions. The service cannot
    /// auto-detect caption format.
    source_type: ?CaptionSourceType,

    /// Settings specific to Teletext caption sources, including Page number.
    teletext_source_settings: ?TeletextSourceSettings,

    /// Settings specific to caption sources that are specified by track number.
    /// Currently, this is only IMSC captions in an IMF package. If your caption
    /// source is IMSC 1.1 in a separate xml file, use FileSourceSettings instead of
    /// TrackSourceSettings.
    track_source_settings: ?TrackSourceSettings,

    /// Settings specific to WebVTT sources in HLS alternative rendition group.
    /// Specify the properties (renditionGroupId, renditionName or
    /// renditionLanguageCode) to identify the unique subtitle track among the
    /// alternative rendition groups present in the HLS manifest. If no unique track
    /// is found, or multiple tracks match the specified properties, the job fails.
    /// If there is only one subtitle track in the rendition group, the settings can
    /// be left empty and the default subtitle track will be chosen. If your caption
    /// source is a sidecar file, use FileSourceSettings instead of
    /// WebvttHlsSourceSettings.
    webvtt_hls_source_settings: ?WebvttHlsSourceSettings,

    pub const json_field_names = .{
        .ancillary_source_settings = "AncillarySourceSettings",
        .dvb_sub_source_settings = "DvbSubSourceSettings",
        .embedded_source_settings = "EmbeddedSourceSettings",
        .file_source_settings = "FileSourceSettings",
        .source_type = "SourceType",
        .teletext_source_settings = "TeletextSourceSettings",
        .track_source_settings = "TrackSourceSettings",
        .webvtt_hls_source_settings = "WebvttHlsSourceSettings",
    };
};
