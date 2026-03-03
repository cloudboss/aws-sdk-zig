/// The start and end times of an inference experiment.
///
/// The maximum duration that you can set for an inference experiment is 30
/// days.
pub const InferenceExperimentSchedule = struct {
    /// The timestamp at which the inference experiment ended or will end.
    end_time: ?i64 = null,

    /// The timestamp at which the inference experiment started or will start.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
    };
};
