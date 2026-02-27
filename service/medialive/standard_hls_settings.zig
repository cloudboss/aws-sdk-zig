const M3u8Settings = @import("m3_u_8_settings.zig").M3u8Settings;

/// Standard Hls Settings
pub const StandardHlsSettings = struct {
    /// List all the audio groups that are used with the video output stream. Input
    /// all the audio GROUP-IDs that are associated to the video, separate by ','.
    audio_rendition_sets: ?[]const u8,

    m3_u_8_settings: M3u8Settings,

    pub const json_field_names = .{
        .audio_rendition_sets = "AudioRenditionSets",
        .m3_u_8_settings = "M3u8Settings",
    };
};
