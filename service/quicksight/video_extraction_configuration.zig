const VideoExtractionStatus = @import("video_extraction_status.zig").VideoExtractionStatus;
const VideoExtractionType = @import("video_extraction_type.zig").VideoExtractionType;

/// The configuration for video extraction from knowledge base documents.
pub const VideoExtractionConfiguration = struct {
    /// The status of video extraction. Valid values are ENABLED and DISABLED.
    video_extraction_status: VideoExtractionStatus,

    /// The type of video extraction to perform.
    video_extraction_type: ?VideoExtractionType = null,

    pub const json_field_names = .{
        .video_extraction_status = "videoExtractionStatus",
        .video_extraction_type = "videoExtractionType",
    };
};
