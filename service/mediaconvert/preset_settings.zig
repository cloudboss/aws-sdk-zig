const AudioDescription = @import("audio_description.zig").AudioDescription;
const CaptionDescriptionPreset = @import("caption_description_preset.zig").CaptionDescriptionPreset;
const ContainerSettings = @import("container_settings.zig").ContainerSettings;
const VideoDescription = @import("video_description.zig").VideoDescription;

/// Settings for preset
pub const PresetSettings = struct {
    /// Contains groups of audio encoding settings organized by audio codec. Include
    /// one instance of per output. Can contain multiple groups of encoding
    /// settings.
    audio_descriptions: ?[]const AudioDescription,

    /// This object holds groups of settings related to captions for one output. For
    /// each output that has captions, include one instance of CaptionDescriptions.
    caption_descriptions: ?[]const CaptionDescriptionPreset,

    /// Container specific settings.
    container_settings: ?ContainerSettings,

    /// VideoDescription contains a group of video encoding settings. The specific
    /// video settings depend on the video codec that you choose for the property
    /// codec. Include one instance of VideoDescription per output.
    video_description: ?VideoDescription,

    pub const json_field_names = .{
        .audio_descriptions = "AudioDescriptions",
        .caption_descriptions = "CaptionDescriptions",
        .container_settings = "ContainerSettings",
        .video_description = "VideoDescription",
    };
};
