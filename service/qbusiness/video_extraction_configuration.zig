const VideoExtractionStatus = @import("video_extraction_status.zig").VideoExtractionStatus;

/// Configuration settings for video content extraction and processing.
pub const VideoExtractionConfiguration = struct {
    /// The status of video extraction (ENABLED or DISABLED) for processing video
    /// content from files.
    video_extraction_status: VideoExtractionStatus,

    pub const json_field_names = .{
        .video_extraction_status = "videoExtractionStatus",
    };
};
