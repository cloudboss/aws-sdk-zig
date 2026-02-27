/// This structure contains the start and end times of a single canary run.
pub const CanaryRunTimeline = struct {
    /// The end time of the run.
    completed: ?i64,

    /// The time at which the metrics will be generated for this run or retries.
    metric_timestamp_for_run_and_retries: ?i64,

    /// The start time of the run.
    started: ?i64,

    pub const json_field_names = .{
        .completed = "Completed",
        .metric_timestamp_for_run_and_retries = "MetricTimestampForRunAndRetries",
        .started = "Started",
    };
};
