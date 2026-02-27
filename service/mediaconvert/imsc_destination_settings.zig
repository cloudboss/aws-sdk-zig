const ImscAccessibilitySubs = @import("imsc_accessibility_subs.zig").ImscAccessibilitySubs;
const ImscStylePassthrough = @import("imsc_style_passthrough.zig").ImscStylePassthrough;

/// Settings related to IMSC captions. IMSC is a sidecar format that holds
/// captions in a file that is separate from the video container. Set up sidecar
/// captions in the same output group, but different output from your video. For
/// more information, see
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/ttml-and-webvtt-output-captions.html.
pub const ImscDestinationSettings = struct {
    /// If the IMSC captions track is intended to provide accessibility for people
    /// who are deaf or hard of hearing: Set Accessibility subtitles to Enabled.
    /// When you do, MediaConvert adds accessibility attributes to your output HLS
    /// or DASH manifest. For HLS manifests, MediaConvert adds the following
    /// accessibility attributes under EXT-X-MEDIA for this track:
    /// CHARACTERISTICS="public.accessibility.transcribes-spoken-dialog,public.accessibility.describes-music-and-sound" and AUTOSELECT="YES". For DASH manifests, MediaConvert adds the following in the adaptation set for this track: . If the captions track is not intended to provide such accessibility: Keep the default value, Disabled. When you do, for DASH manifests, MediaConvert instead adds the following in the adaptation set for this track: .
    accessibility: ?ImscAccessibilitySubs,

    /// Keep this setting enabled to have MediaConvert use the font style and
    /// position information from the captions source in the output. This option is
    /// available only when your input captions are IMSC, SMPTE-TT, or TTML. Disable
    /// this setting for simplified output captions.
    style_passthrough: ?ImscStylePassthrough,

    pub const json_field_names = .{
        .accessibility = "Accessibility",
        .style_passthrough = "StylePassthrough",
    };
};
