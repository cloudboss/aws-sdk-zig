/// Specifies when to stop processing the stream. You can specify a maximum
/// amount
/// of time to process the video.
pub const StreamProcessingStopSelector = struct {
    /// Specifies the maximum amount of time in seconds that you want the stream to
    /// be processed. The largest amount of time is 2 minutes. The default is 10
    /// seconds.
    max_duration_in_seconds: ?i64,

    pub const json_field_names = .{
        .max_duration_in_seconds = "MaxDurationInSeconds",
    };
};
