const VideoSegmentConfiguration = @import("video_segment_configuration.zig").VideoSegmentConfiguration;

/// Video asset processing configuration
pub const VideoAssetProcessingConfiguration = struct {
    /// Delimits the segment of the input that will be processed
    segment_configuration: ?VideoSegmentConfiguration,

    pub const json_field_names = .{
        .segment_configuration = "segmentConfiguration",
    };
};
