const AncillarySourceSettings = @import("ancillary_source_settings.zig").AncillarySourceSettings;
const AribSourceSettings = @import("arib_source_settings.zig").AribSourceSettings;
const DvbSubSourceSettings = @import("dvb_sub_source_settings.zig").DvbSubSourceSettings;
const EmbeddedSourceSettings = @import("embedded_source_settings.zig").EmbeddedSourceSettings;
const Scte20SourceSettings = @import("scte_20_source_settings.zig").Scte20SourceSettings;
const Scte27SourceSettings = @import("scte_27_source_settings.zig").Scte27SourceSettings;
const TeletextSourceSettings = @import("teletext_source_settings.zig").TeletextSourceSettings;

/// Caption Selector Settings
pub const CaptionSelectorSettings = struct {
    ancillary_source_settings: ?AncillarySourceSettings = null,

    arib_source_settings: ?AribSourceSettings = null,

    dvb_sub_source_settings: ?DvbSubSourceSettings = null,

    embedded_source_settings: ?EmbeddedSourceSettings = null,

    scte_20_source_settings: ?Scte20SourceSettings = null,

    scte_27_source_settings: ?Scte27SourceSettings = null,

    teletext_source_settings: ?TeletextSourceSettings = null,

    pub const json_field_names = .{
        .ancillary_source_settings = "AncillarySourceSettings",
        .arib_source_settings = "AribSourceSettings",
        .dvb_sub_source_settings = "DvbSubSourceSettings",
        .embedded_source_settings = "EmbeddedSourceSettings",
        .scte_20_source_settings = "Scte20SourceSettings",
        .scte_27_source_settings = "Scte27SourceSettings",
        .teletext_source_settings = "TeletextSourceSettings",
    };
};
