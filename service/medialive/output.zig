const OutputSettings = @import("output_settings.zig").OutputSettings;

/// Output settings. There can be multiple outputs within a group.
pub const Output = struct {
    /// The names of the AudioDescriptions used as audio sources for this output.
    audio_description_names: ?[]const []const u8 = null,

    /// The names of the CaptionDescriptions used as caption sources for this
    /// output.
    caption_description_names: ?[]const []const u8 = null,

    /// The name used to identify an output.
    output_name: ?[]const u8 = null,

    /// Output type-specific settings.
    output_settings: OutputSettings,

    /// The name of the VideoDescription used as the source for this output.
    video_description_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .audio_description_names = "AudioDescriptionNames",
        .caption_description_names = "CaptionDescriptionNames",
        .output_name = "OutputName",
        .output_settings = "OutputSettings",
        .video_description_name = "VideoDescriptionName",
    };
};
