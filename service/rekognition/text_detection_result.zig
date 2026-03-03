const TextDetection = @import("text_detection.zig").TextDetection;

/// Information about text detected in a video. Incudes the detected text,
/// the time in milliseconds from the start of the video that the text was
/// detected, and where it was detected on the screen.
pub const TextDetectionResult = struct {
    /// Details about text detected in a video.
    text_detection: ?TextDetection = null,

    /// The time, in milliseconds from the start of the video, that the text was
    /// detected.
    /// Note that `Timestamp` is not guaranteed to be accurate to the individual
    /// frame where the text first appears.
    timestamp: i64 = 0,

    pub const json_field_names = .{
        .text_detection = "TextDetection",
        .timestamp = "Timestamp",
    };
};
