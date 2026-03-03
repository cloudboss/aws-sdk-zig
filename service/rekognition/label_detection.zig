const Label = @import("label.zig").Label;

/// Information about a label detected in a video analysis request and the time
/// the label was detected in the video.
pub const LabelDetection = struct {
    /// The time duration of a segment in milliseconds, I.e. time elapsed from
    /// StartTimestampMillis to EndTimestampMillis.
    duration_millis: ?i64 = null,

    /// The time in milliseconds defining the end of the timeline segment containing
    /// a continuously detected label.
    end_timestamp_millis: ?i64 = null,

    /// Details about the detected label.
    label: ?Label = null,

    /// The time in milliseconds defining the start of the timeline segment
    /// containing a continuously detected label.
    start_timestamp_millis: ?i64 = null,

    /// Time, in milliseconds from the start of the video, that the label was
    /// detected.
    /// Note that `Timestamp` is not guaranteed to be accurate to the individual
    /// frame where the label first appears.
    timestamp: i64 = 0,

    pub const json_field_names = .{
        .duration_millis = "DurationMillis",
        .end_timestamp_millis = "EndTimestampMillis",
        .label = "Label",
        .start_timestamp_millis = "StartTimestampMillis",
        .timestamp = "Timestamp",
    };
};
