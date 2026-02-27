/// This structure contains the time and date that Evidently completed the
/// analysis of the experiment.
pub const ExperimentSchedule = struct {
    /// The time and date that Evidently completed the analysis of the experiment.
    analysis_complete_time: ?i64,

    pub const json_field_names = .{
        .analysis_complete_time = "analysisCompleteTime",
    };
};
