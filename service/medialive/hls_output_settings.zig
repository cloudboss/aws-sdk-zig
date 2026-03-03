const HlsH265PackagingType = @import("hls_h265_packaging_type.zig").HlsH265PackagingType;
const HlsSettings = @import("hls_settings.zig").HlsSettings;

/// Hls Output Settings
pub const HlsOutputSettings = struct {
    /// Only applicable when this output is referencing an H.265 video description.
    /// Specifies whether MP4 segments should be packaged as HEV1 or HVC1.
    h265_packaging_type: ?HlsH265PackagingType = null,

    /// Settings regarding the underlying stream. These settings are different for
    /// audio-only outputs.
    hls_settings: HlsSettings,

    /// String concatenated to the end of the destination filename. Accepts \"Format
    /// Identifiers\":#formatIdentifierParameters.
    name_modifier: ?[]const u8 = null,

    /// String concatenated to end of segment filenames.
    segment_modifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .h265_packaging_type = "H265PackagingType",
        .hls_settings = "HlsSettings",
        .name_modifier = "NameModifier",
        .segment_modifier = "SegmentModifier",
    };
};
