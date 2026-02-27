/// The object containing the result statistics for a completed assessment run.
pub const ReplicationTaskAssessmentRunResultStatistic = struct {
    /// The number of individual assessments that were cancelled during the
    /// assessment run.
    cancelled: i32 = 0,

    /// The number of individual assessments that encountered a critical error and
    /// could not complete properly.
    @"error": i32 = 0,

    /// The number of individual assessments that failed to meet the criteria
    /// defined in the assessment run.
    failed: i32 = 0,

    /// The number of individual assessments that successfully passed all checks in
    /// the assessment run.
    passed: i32 = 0,

    /// The number of individual assessments that were skipped during the assessment
    /// run.
    skipped: i32 = 0,

    /// Indicates that the recent completed AssessmentRun triggered a warning.
    warning: i32 = 0,

    pub const json_field_names = .{
        .cancelled = "Cancelled",
        .@"error" = "Error",
        .failed = "Failed",
        .passed = "Passed",
        .skipped = "Skipped",
        .warning = "Warning",
    };
};
