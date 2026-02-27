const BurninDestinationSettings = @import("burnin_destination_settings.zig").BurninDestinationSettings;
const CaptionDestinationType = @import("caption_destination_type.zig").CaptionDestinationType;
const DvbSubDestinationSettings = @import("dvb_sub_destination_settings.zig").DvbSubDestinationSettings;
const EmbeddedDestinationSettings = @import("embedded_destination_settings.zig").EmbeddedDestinationSettings;
const ImscDestinationSettings = @import("imsc_destination_settings.zig").ImscDestinationSettings;
const SccDestinationSettings = @import("scc_destination_settings.zig").SccDestinationSettings;
const SrtDestinationSettings = @import("srt_destination_settings.zig").SrtDestinationSettings;
const TeletextDestinationSettings = @import("teletext_destination_settings.zig").TeletextDestinationSettings;
const TtmlDestinationSettings = @import("ttml_destination_settings.zig").TtmlDestinationSettings;
const WebvttDestinationSettings = @import("webvtt_destination_settings.zig").WebvttDestinationSettings;

/// Settings related to one captions tab on the MediaConvert console. Usually,
/// one captions tab corresponds to one output captions track. Depending on your
/// output captions format, one tab might correspond to a set of output captions
/// tracks. For more information, see
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/including-captions.html.
pub const CaptionDestinationSettings = struct {
    /// Burn-in is a captions delivery method, rather than a captions format.
    /// Burn-in writes the captions directly on your video frames, replacing pixels
    /// of video content with the captions. Set up burn-in captions in the same
    /// output as your video. For more information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/burn-in-output-captions.html.
    burnin_destination_settings: ?BurninDestinationSettings,

    /// Specify the format for this set of captions on this output. The default
    /// format is embedded without SCTE-20. Note that your choice of video output
    /// container constrains your choice of output captions format. For more
    /// information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/captions-support-tables.html. If you are using SCTE-20 and you want to create an output that complies with the SCTE-43 spec, choose SCTE-20 plus embedded. To create a non-compliant output where the embedded captions come first, choose Embedded plus SCTE-20.
    destination_type: ?CaptionDestinationType,

    /// Settings related to DVB-Sub captions. Set up DVB-Sub captions in the same
    /// output as your video. For more information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/dvb-sub-output-captions.html.
    dvb_sub_destination_settings: ?DvbSubDestinationSettings,

    /// Settings related to CEA/EIA-608 and CEA/EIA-708 (also called embedded or
    /// ancillary) captions. Set up embedded captions in the same output as your
    /// video. For more information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/embedded-output-captions.html.
    embedded_destination_settings: ?EmbeddedDestinationSettings,

    /// Settings related to IMSC captions. IMSC is a sidecar format that holds
    /// captions in a file that is separate from the video container. Set up sidecar
    /// captions in the same output group, but different output from your video. For
    /// more information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/ttml-and-webvtt-output-captions.html.
    imsc_destination_settings: ?ImscDestinationSettings,

    /// Settings related to SCC captions. SCC is a sidecar format that holds
    /// captions in a file that is separate from the video container. Set up sidecar
    /// captions in the same output group, but different output from your video. For
    /// more information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/scc-srt-output-captions.html.
    scc_destination_settings: ?SccDestinationSettings,

    /// Settings related to SRT captions. SRT is a sidecar format that holds
    /// captions in a file that is separate from the video container. Set up sidecar
    /// captions in the same output group, but different output from your video.
    srt_destination_settings: ?SrtDestinationSettings,

    /// Settings related to teletext captions. Set up teletext captions in the same
    /// output as your video. For more information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/teletext-output-captions.html.
    teletext_destination_settings: ?TeletextDestinationSettings,

    /// Settings related to TTML captions. TTML is a sidecar format that holds
    /// captions in a file that is separate from the video container. Set up sidecar
    /// captions in the same output group, but different output from your video. For
    /// more information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/ttml-and-webvtt-output-captions.html.
    ttml_destination_settings: ?TtmlDestinationSettings,

    /// Settings related to WebVTT captions. WebVTT is a sidecar format that holds
    /// captions in a file that is separate from the video container. Set up sidecar
    /// captions in the same output group, but different output from your video. For
    /// more information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/ttml-and-webvtt-output-captions.html.
    webvtt_destination_settings: ?WebvttDestinationSettings,

    pub const json_field_names = .{
        .burnin_destination_settings = "BurninDestinationSettings",
        .destination_type = "DestinationType",
        .dvb_sub_destination_settings = "DvbSubDestinationSettings",
        .embedded_destination_settings = "EmbeddedDestinationSettings",
        .imsc_destination_settings = "ImscDestinationSettings",
        .scc_destination_settings = "SccDestinationSettings",
        .srt_destination_settings = "SrtDestinationSettings",
        .teletext_destination_settings = "TeletextDestinationSettings",
        .ttml_destination_settings = "TtmlDestinationSettings",
        .webvtt_destination_settings = "WebvttDestinationSettings",
    };
};
