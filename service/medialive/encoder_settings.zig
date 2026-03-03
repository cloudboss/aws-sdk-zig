const AudioDescription = @import("audio_description.zig").AudioDescription;
const AvailBlanking = @import("avail_blanking.zig").AvailBlanking;
const AvailConfiguration = @import("avail_configuration.zig").AvailConfiguration;
const BlackoutSlate = @import("blackout_slate.zig").BlackoutSlate;
const CaptionDescription = @import("caption_description.zig").CaptionDescription;
const ColorCorrectionSettings = @import("color_correction_settings.zig").ColorCorrectionSettings;
const FeatureActivations = @import("feature_activations.zig").FeatureActivations;
const GlobalConfiguration = @import("global_configuration.zig").GlobalConfiguration;
const MotionGraphicsConfiguration = @import("motion_graphics_configuration.zig").MotionGraphicsConfiguration;
const NielsenConfiguration = @import("nielsen_configuration.zig").NielsenConfiguration;
const OutputGroup = @import("output_group.zig").OutputGroup;
const ThumbnailConfiguration = @import("thumbnail_configuration.zig").ThumbnailConfiguration;
const TimecodeConfig = @import("timecode_config.zig").TimecodeConfig;
const VideoDescription = @import("video_description.zig").VideoDescription;

/// Encoder Settings
pub const EncoderSettings = struct {
    audio_descriptions: []const AudioDescription,

    /// Settings for ad avail blanking.
    avail_blanking: ?AvailBlanking = null,

    /// Event-wide configuration settings for ad avail insertion.
    avail_configuration: ?AvailConfiguration = null,

    /// Settings for blackout slate.
    blackout_slate: ?BlackoutSlate = null,

    /// Settings for caption decriptions
    caption_descriptions: ?[]const CaptionDescription = null,

    /// Color Correction Settings
    color_correction_settings: ?ColorCorrectionSettings = null,

    /// Feature Activations
    feature_activations: ?FeatureActivations = null,

    /// Configuration settings that apply to the event as a whole.
    global_configuration: ?GlobalConfiguration = null,

    /// Settings for motion graphics.
    motion_graphics_configuration: ?MotionGraphicsConfiguration = null,

    /// Nielsen configuration settings.
    nielsen_configuration: ?NielsenConfiguration = null,

    output_groups: []const OutputGroup,

    /// Thumbnail configuration settings.
    thumbnail_configuration: ?ThumbnailConfiguration = null,

    /// Contains settings used to acquire and adjust timecode information from
    /// inputs.
    timecode_config: TimecodeConfig,

    video_descriptions: []const VideoDescription,

    pub const json_field_names = .{
        .audio_descriptions = "AudioDescriptions",
        .avail_blanking = "AvailBlanking",
        .avail_configuration = "AvailConfiguration",
        .blackout_slate = "BlackoutSlate",
        .caption_descriptions = "CaptionDescriptions",
        .color_correction_settings = "ColorCorrectionSettings",
        .feature_activations = "FeatureActivations",
        .global_configuration = "GlobalConfiguration",
        .motion_graphics_configuration = "MotionGraphicsConfiguration",
        .nielsen_configuration = "NielsenConfiguration",
        .output_groups = "OutputGroups",
        .thumbnail_configuration = "ThumbnailConfiguration",
        .timecode_config = "TimecodeConfig",
        .video_descriptions = "VideoDescriptions",
    };
};
