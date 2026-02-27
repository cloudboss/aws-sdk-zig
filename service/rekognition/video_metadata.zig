const VideoColorRange = @import("video_color_range.zig").VideoColorRange;

/// Information about a video that Amazon Rekognition analyzed. `Videometadata`
/// is returned in
/// every page of paginated responses from a Amazon Rekognition video operation.
pub const VideoMetadata = struct {
    /// Type of compression used in the analyzed video.
    codec: ?[]const u8,

    /// A description of the range of luminance values in a video, either LIMITED
    /// (16 to 235) or FULL (0 to 255).
    color_range: ?VideoColorRange,

    /// Length of the video in milliseconds.
    duration_millis: ?i64,

    /// Format of the analyzed video. Possible values are MP4, MOV and AVI.
    format: ?[]const u8,

    /// Vertical pixel dimension of the video.
    frame_height: ?i64,

    /// Number of frames per second in the video.
    frame_rate: ?f32,

    /// Horizontal pixel dimension of the video.
    frame_width: ?i64,

    pub const json_field_names = .{
        .codec = "Codec",
        .color_range = "ColorRange",
        .duration_millis = "DurationMillis",
        .format = "Format",
        .frame_height = "FrameHeight",
        .frame_rate = "FrameRate",
        .frame_width = "FrameWidth",
    };
};
