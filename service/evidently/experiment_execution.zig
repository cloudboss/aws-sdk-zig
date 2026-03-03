/// This structure contains the date and time that the experiment started and
/// ended.
pub const ExperimentExecution = struct {
    /// The date and time that the experiment ended.
    ended_time: ?i64 = null,

    /// The date and time that the experiment started.
    started_time: ?i64 = null,

    pub const json_field_names = .{
        .ended_time = "endedTime",
        .started_time = "startedTime",
    };
};
