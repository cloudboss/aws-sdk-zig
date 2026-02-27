/// Information about when jobs are submitted, started, and finished is
/// specified in Unix epoch format in seconds.
pub const Timing = struct {
    /// The time, in Unix epoch format, that the transcoding job finished
    finish_time: ?i64,

    /// The time, in Unix epoch format, that transcoding for the job began.
    start_time: ?i64,

    /// The time, in Unix epoch format, that you submitted the job.
    submit_time: ?i64,

    pub const json_field_names = .{
        .finish_time = "FinishTime",
        .start_time = "StartTime",
        .submit_time = "SubmitTime",
    };
};
