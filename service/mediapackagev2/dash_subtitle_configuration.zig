const DashTtmlConfiguration = @import("dash_ttml_configuration.zig").DashTtmlConfiguration;

/// The configuration for DASH subtitles.
pub const DashSubtitleConfiguration = struct {
    /// Settings for TTML subtitles.
    ttml_configuration: ?DashTtmlConfiguration,

    pub const json_field_names = .{
        .ttml_configuration = "TtmlConfiguration",
    };
};
