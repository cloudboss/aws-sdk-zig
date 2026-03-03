const ContentType = @import("content_type.zig").ContentType;
const ModerationLabel = @import("moderation_label.zig").ModerationLabel;

/// Information about an inappropriate, unwanted, or offensive content label
/// detection in a stored video.
pub const ContentModerationDetection = struct {
    /// A list of predicted results for the type of content an image contains. For
    /// example,
    /// the image content might be from animation, sports, or a video game.
    content_types: ?[]const ContentType = null,

    /// The time duration of a segment in milliseconds, I.e. time elapsed from
    /// StartTimestampMillis to EndTimestampMillis.
    duration_millis: ?i64 = null,

    /// The time in milliseconds defining the end of the timeline segment containing
    /// a
    /// continuously detected moderation label.
    end_timestamp_millis: ?i64 = null,

    /// The content moderation label detected by in the stored video.
    moderation_label: ?ModerationLabel = null,

    /// The time in milliseconds defining the start of the timeline segment
    /// containing a
    /// continuously detected moderation label.
    start_timestamp_millis: ?i64 = null,

    /// Time, in milliseconds from the beginning of the video, that the content
    /// moderation label was detected.
    /// Note that `Timestamp` is not guaranteed to be accurate to the individual
    /// frame where the moderated content first appears.
    timestamp: i64 = 0,

    pub const json_field_names = .{
        .content_types = "ContentTypes",
        .duration_millis = "DurationMillis",
        .end_timestamp_millis = "EndTimestampMillis",
        .moderation_label = "ModerationLabel",
        .start_timestamp_millis = "StartTimestampMillis",
        .timestamp = "Timestamp",
    };
};
