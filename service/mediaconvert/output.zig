const AudioDescription = @import("audio_description.zig").AudioDescription;
const CaptionDescription = @import("caption_description.zig").CaptionDescription;
const ContainerSettings = @import("container_settings.zig").ContainerSettings;
const OutputSettings = @import("output_settings.zig").OutputSettings;
const VideoDescription = @import("video_description.zig").VideoDescription;

/// Each output in your job is a collection of settings that describes how you
/// want MediaConvert to encode a single output file or stream. For more
/// information, see
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/create-outputs.html.
pub const Output = struct {
    /// Contains groups of audio encoding settings organized by audio codec. Include
    /// one instance of per output. Can contain multiple groups of encoding
    /// settings.
    audio_descriptions: ?[]const AudioDescription = null,

    /// Contains groups of captions settings. For each output that has captions,
    /// include one instance of CaptionDescriptions. Can contain multiple groups of
    /// captions settings.
    caption_descriptions: ?[]const CaptionDescription = null,

    /// Container specific settings.
    container_settings: ?ContainerSettings = null,

    /// Use Extension to specify the file extension for outputs in File output
    /// groups. If you do not specify a value, the service will use default
    /// extensions by container type as follows * MPEG-2 transport stream, m2ts *
    /// Quicktime, mov * MXF container, mxf * MPEG-4 container, mp4 * WebM
    /// container, webm * Animated GIF container, gif * No Container, the service
    /// will use codec extensions (e.g. AAC, H265, H265, AC3)
    extension: ?[]const u8 = null,

    /// Use Name modifier to have the service add a string to the end of each output
    /// filename. You specify the base filename as part of your destination URI.
    /// When you create multiple outputs in the same output group, Name modifier is
    /// required. Name modifier also accepts format identifiers. For DASH ISO
    /// outputs, if you use the format identifiers $Number$ or $Time$ in one output,
    /// you must use them in the same way in all outputs of the output group.
    name_modifier: ?[]const u8 = null,

    /// Specific settings for this type of output.
    output_settings: ?OutputSettings = null,

    /// Use Preset to specify a preset for your transcoding settings. Provide the
    /// system or custom preset name. You can specify either Preset or Container
    /// settings, but not both.
    preset: ?[]const u8 = null,

    /// VideoDescription contains a group of video encoding settings. The specific
    /// video settings depend on the video codec that you choose for the property
    /// codec. Include one instance of VideoDescription per output.
    video_description: ?VideoDescription = null,

    pub const json_field_names = .{
        .audio_descriptions = "AudioDescriptions",
        .caption_descriptions = "CaptionDescriptions",
        .container_settings = "ContainerSettings",
        .extension = "Extension",
        .name_modifier = "NameModifier",
        .output_settings = "OutputSettings",
        .preset = "Preset",
        .video_description = "VideoDescription",
    };
};
