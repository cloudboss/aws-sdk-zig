const AribDestinationSettings = @import("arib_destination_settings.zig").AribDestinationSettings;
const BurnInDestinationSettings = @import("burn_in_destination_settings.zig").BurnInDestinationSettings;
const DvbSubDestinationSettings = @import("dvb_sub_destination_settings.zig").DvbSubDestinationSettings;
const EbuTtDDestinationSettings = @import("ebu_tt_d_destination_settings.zig").EbuTtDDestinationSettings;
const EmbeddedDestinationSettings = @import("embedded_destination_settings.zig").EmbeddedDestinationSettings;
const EmbeddedPlusScte20DestinationSettings = @import("embedded_plus_scte_20_destination_settings.zig").EmbeddedPlusScte20DestinationSettings;
const RtmpCaptionInfoDestinationSettings = @import("rtmp_caption_info_destination_settings.zig").RtmpCaptionInfoDestinationSettings;
const Scte20PlusEmbeddedDestinationSettings = @import("scte_20_plus_embedded_destination_settings.zig").Scte20PlusEmbeddedDestinationSettings;
const Scte27DestinationSettings = @import("scte_27_destination_settings.zig").Scte27DestinationSettings;
const SmpteTtDestinationSettings = @import("smpte_tt_destination_settings.zig").SmpteTtDestinationSettings;
const TeletextDestinationSettings = @import("teletext_destination_settings.zig").TeletextDestinationSettings;
const TtmlDestinationSettings = @import("ttml_destination_settings.zig").TtmlDestinationSettings;
const WebvttDestinationSettings = @import("webvtt_destination_settings.zig").WebvttDestinationSettings;

/// Caption Destination Settings
pub const CaptionDestinationSettings = struct {
    arib_destination_settings: ?AribDestinationSettings,

    burn_in_destination_settings: ?BurnInDestinationSettings,

    dvb_sub_destination_settings: ?DvbSubDestinationSettings,

    ebu_tt_d_destination_settings: ?EbuTtDDestinationSettings,

    embedded_destination_settings: ?EmbeddedDestinationSettings,

    embedded_plus_scte_20_destination_settings: ?EmbeddedPlusScte20DestinationSettings,

    rtmp_caption_info_destination_settings: ?RtmpCaptionInfoDestinationSettings,

    scte_20_plus_embedded_destination_settings: ?Scte20PlusEmbeddedDestinationSettings,

    scte_27_destination_settings: ?Scte27DestinationSettings,

    smpte_tt_destination_settings: ?SmpteTtDestinationSettings,

    teletext_destination_settings: ?TeletextDestinationSettings,

    ttml_destination_settings: ?TtmlDestinationSettings,

    webvtt_destination_settings: ?WebvttDestinationSettings,

    pub const json_field_names = .{
        .arib_destination_settings = "AribDestinationSettings",
        .burn_in_destination_settings = "BurnInDestinationSettings",
        .dvb_sub_destination_settings = "DvbSubDestinationSettings",
        .ebu_tt_d_destination_settings = "EbuTtDDestinationSettings",
        .embedded_destination_settings = "EmbeddedDestinationSettings",
        .embedded_plus_scte_20_destination_settings = "EmbeddedPlusScte20DestinationSettings",
        .rtmp_caption_info_destination_settings = "RtmpCaptionInfoDestinationSettings",
        .scte_20_plus_embedded_destination_settings = "Scte20PlusEmbeddedDestinationSettings",
        .scte_27_destination_settings = "Scte27DestinationSettings",
        .smpte_tt_destination_settings = "SmpteTtDestinationSettings",
        .teletext_destination_settings = "TeletextDestinationSettings",
        .ttml_destination_settings = "TtmlDestinationSettings",
        .webvtt_destination_settings = "WebvttDestinationSettings",
    };
};
