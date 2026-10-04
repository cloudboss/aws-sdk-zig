const ContentLightLevel = @import("content_light_level.zig").ContentLightLevel;
const MasteringDisplayColorVolume = @import("mastering_display_color_volume.zig").MasteringDisplayColorVolume;

/// HDR (High Dynamic Range) metadata extracted from the container, including
/// mastering display color volume and content light level information. This
/// metadata is present in HDR10 and similar HDR content.
pub const HdrMetadata = struct {
    /// Content light level information (CTA-861.3). Describes the light level
    /// characteristics of the content.
    content_light_level: ?ContentLightLevel = null,

    /// Mastering display color volume metadata (SMPTE ST 2086). Describes the color
    /// volume of the display used to master the content. Chromaticity coordinates
    /// are in units of 0.00002. Luminance values are in units of 0.0001 cd/m².
    mastering_display_color_volume: ?MasteringDisplayColorVolume = null,

    pub const json_field_names = .{
        .content_light_level = "ContentLightLevel",
        .mastering_display_color_volume = "MasteringDisplayColorVolume",
    };
};
