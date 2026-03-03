const NielsenWatermarksSettings = @import("nielsen_watermarks_settings.zig").NielsenWatermarksSettings;

/// Audio Watermark Settings
pub const AudioWatermarkSettings = struct {
    /// Settings to configure Nielsen Watermarks in the audio encode
    nielsen_watermarks_settings: ?NielsenWatermarksSettings = null,

    pub const json_field_names = .{
        .nielsen_watermarks_settings = "NielsenWatermarksSettings",
    };
};
