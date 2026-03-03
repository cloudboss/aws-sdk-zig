const VideoDetail = @import("video_detail.zig").VideoDetail;

/// Details regarding output
pub const OutputDetail = struct {
    /// Duration in milliseconds
    duration_in_ms: ?i32 = null,

    /// Contains details about the output's video stream
    video_details: ?VideoDetail = null,

    pub const json_field_names = .{
        .duration_in_ms = "DurationInMs",
        .video_details = "VideoDetails",
    };
};
