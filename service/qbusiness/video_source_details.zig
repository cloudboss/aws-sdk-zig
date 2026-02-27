const VideoExtractionType = @import("video_extraction_type.zig").VideoExtractionType;

/// Details about a video source, including its identifier, format, and time
/// information.
pub const VideoSourceDetails = struct {
    /// The ending timestamp in milliseconds for the relevant video segment.
    end_time_milliseconds: ?i64,

    /// Unique identifier for the video media file.
    media_id: ?[]const u8,

    /// The MIME type of the video file (e.g., video/mp4, video/avi).
    media_mime_type: ?[]const u8,

    /// The starting timestamp in milliseconds for the relevant video segment.
    start_time_milliseconds: ?i64,

    /// The type of video extraction performed on the content.
    video_extraction_type: ?VideoExtractionType,

    pub const json_field_names = .{
        .end_time_milliseconds = "endTimeMilliseconds",
        .media_id = "mediaId",
        .media_mime_type = "mediaMimeType",
        .start_time_milliseconds = "startTimeMilliseconds",
        .video_extraction_type = "videoExtractionType",
    };
};
