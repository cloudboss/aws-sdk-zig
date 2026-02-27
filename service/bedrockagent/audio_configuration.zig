const AudioSegmentationConfiguration = @import("audio_segmentation_configuration.zig").AudioSegmentationConfiguration;

/// Configuration settings for processing audio content in multimodal knowledge
/// bases.
pub const AudioConfiguration = struct {
    /// Configuration for segmenting audio content during processing.
    segmentation_configuration: AudioSegmentationConfiguration,

    pub const json_field_names = .{
        .segmentation_configuration = "segmentationConfiguration",
    };
};
