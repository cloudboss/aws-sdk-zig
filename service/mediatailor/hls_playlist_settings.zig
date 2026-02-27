const AdMarkupType = @import("ad_markup_type.zig").AdMarkupType;

/// HLS playlist configuration parameters.
pub const HlsPlaylistSettings = struct {
    /// Determines the type of SCTE 35 tags to use in ad markup. Specify `DATERANGE`
    /// to use `DATERANGE` tags (for live or VOD content). Specify `SCTE35_ENHANCED`
    /// to use `EXT-X-CUE-OUT` and `EXT-X-CUE-IN` tags (for VOD content only).
    ad_markup_type: ?[]const AdMarkupType,

    /// The total duration (in seconds) of each manifest. Minimum value: `30`
    /// seconds. Maximum value: `3600` seconds.
    manifest_window_seconds: ?i32,

    pub const json_field_names = .{
        .ad_markup_type = "AdMarkupType",
        .manifest_window_seconds = "ManifestWindowSeconds",
    };
};
