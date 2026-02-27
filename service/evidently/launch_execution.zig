/// This structure contains information about the start and end times of the
/// launch.
pub const LaunchExecution = struct {
    /// The date and time that the launch ended.
    ended_time: ?i64,

    /// The date and time that the launch started.
    started_time: ?i64,

    pub const json_field_names = .{
        .ended_time = "endedTime",
        .started_time = "startedTime",
    };
};
