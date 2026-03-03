/// Contains information about the specific inference event, including start and
/// end time,
/// diagnostics information, event duration and so on.
pub const InferenceEventSummary = struct {
    /// An array which specifies the names and values of all sensors contributing to
    /// an
    /// inference event.
    diagnostics: ?[]const u8 = null,

    /// Indicates the size of an inference event in seconds.
    event_duration_in_seconds: ?i64 = null,

    /// Indicates the ending time of an inference event.
    event_end_time: ?i64 = null,

    /// Indicates the starting time of an inference event.
    event_start_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the inference scheduler being used for the
    /// inference
    /// event.
    inference_scheduler_arn: ?[]const u8 = null,

    /// The name of the inference scheduler being used for the inference events.
    inference_scheduler_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .diagnostics = "Diagnostics",
        .event_duration_in_seconds = "EventDurationInSeconds",
        .event_end_time = "EventEndTime",
        .event_start_time = "EventStartTime",
        .inference_scheduler_arn = "InferenceSchedulerArn",
        .inference_scheduler_name = "InferenceSchedulerName",
    };
};
