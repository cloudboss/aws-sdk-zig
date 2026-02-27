const AutomatedAbrSettings = @import("automated_abr_settings.zig").AutomatedAbrSettings;

/// Use automated encoding to have MediaConvert choose your encoding settings
/// for you, based on characteristics of your input video.
pub const AutomatedEncodingSettings = struct {
    /// Use automated ABR to have MediaConvert set up the renditions in your ABR
    /// package for you automatically, based on characteristics of your input video.
    /// This feature optimizes video quality while minimizing the overall size of
    /// your ABR package.
    abr_settings: ?AutomatedAbrSettings,

    pub const json_field_names = .{
        .abr_settings = "AbrSettings",
    };
};
