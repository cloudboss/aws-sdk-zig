/// The progress values reported by the `AssessmentProgress` response
/// element.
pub const ReplicationTaskAssessmentRunProgress = struct {
    /// The number of individual assessments that have completed, successfully or
    /// not.
    individual_assessment_completed_count: i32 = 0,

    /// The number of individual assessments that are specified to run.
    individual_assessment_count: i32 = 0,

    pub const json_field_names = .{
        .individual_assessment_completed_count = "IndividualAssessmentCompletedCount",
        .individual_assessment_count = "IndividualAssessmentCount",
    };
};
