const VideoSegmentationConfiguration = @import("video_segmentation_configuration.zig").VideoSegmentationConfiguration;

/// Configuration settings for processing video content in multimodal knowledge
/// bases.
pub const VideoConfiguration = struct {
    /// Configuration for segmenting video content during processing.
    segmentation_configuration: VideoSegmentationConfiguration,

    pub const json_field_names = .{
        .segmentation_configuration = "segmentationConfiguration",
    };
};
